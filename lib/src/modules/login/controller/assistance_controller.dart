import 'package:abctechapp/src/modules/login/dto/assistance_dto.dart';
import 'package:abctechapp/src/modules/login/dto/page.dart';
import 'package:abctechapp/src/modules/login/service/assistance_service.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController with StateMixin<Set<AssistanceDTO>> {
  late AssistanceService _assistanceService;
  PageDTO<AssistanceDTO> pageDTO = PageDTO(content: [], last: false, totalPages: 0, totalElements: 0, numberOfElements: 0, number: 0);
  Set<AssistanceDTO> allAssists = {};
  List<AssistanceDTO> selectedAssists = [];

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

  void finishSelectAssist() {
    Get.back();
  }
}
