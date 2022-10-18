import 'package:abctechapp/src/modules/assists/dto/assistance_dto.dart';
import 'package:abctechapp/src/modules/common/dto/page.dart';
import 'package:abctechapp/src/modules/assists/service/assistance_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController with StateMixin<Set<AssistanceDTO>> {
  late AssistanceService _assistanceService;
  PageDTO<AssistanceDTO> pageDTO = PageDTO(content: [], last: false, totalPages: 0, totalElements: 0, numberOfElements: 0, number: 0);
  Set<AssistanceDTO> allAssists = {};
  RxList<AssistanceDTO> selectedAssists = RxList<AssistanceDTO>();

  AssistanceController();

  @override
  void onInit() {
    super.onInit();
    _assistanceService = Get.find<AssistanceService>();

    loadAssist(0);
  }

  void nextPage() {
    if (!pageDTO.last) {
      loadAssist(pageDTO.number + 1);
    }
  }

  void loadAssist(int page) {
    change({}, status: RxStatus.loading());
    _assistanceService.getAssists(page).then((value) {
      pageDTO = value;
      allAssists.addAll(value.content);
      change(allAssists, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change({}, status: RxStatus.error(error.toString()));
    });
  }

  void selectAssist(int index) {
    AssistanceDTO assistance = allAssists.elementAt(index);
    int indexFound = selectedAssists.indexWhere((element) => element.assistanceCode == assistance.assistanceCode);

    if (indexFound == -1) {
      if (selectedAssists.length < 15) {
        selectedAssists.add(assistance);
      }
    } else {
      selectedAssists.removeAt(indexFound);
    }

    change(allAssists, status: RxStatus.success());
  }

  bool isSelected(int index) {
    AssistanceDTO assistance = allAssists.elementAt(index);

    int indexFound = selectedAssists.indexWhere((element) => element.assistanceCode == assistance.assistanceCode);

    if (indexFound >= 0) {
      return true;
    }

    return false;
  }

  void finishSelectAssist(BuildContext context) {
    if (selectedAssists.length < 1 || selectedAssists.length > 15) {
      _dialogBuilder(context);
    } else {
      Get.back(result: selectedAssists.toList());
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione os serviços'),
          content: const Text('É necessário selecionar entre 1 e 15 serviços para criar uma ordem de serviço.'),
          contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
