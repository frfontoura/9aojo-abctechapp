import 'package:abctechapp/src/modules/login/dto/assistance_dto.dart';
import 'package:abctechapp/src/modules/login/dto/page.dart';
import 'package:abctechapp/src/modules/login/service/assistance_service.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController with StateMixin<List<AssistanceDTO>> {
  late AssistanceService _assistanceService;
  PageDTO<AssistanceDTO> pageDTO = PageDTO(content: [], last: false, totalPages: 0, totalElements: 0, numberOfElements: 0, number: 0);
  List<AssistanceDTO> allAssists = [];

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
    change([], status: RxStatus.loading());
    _assistanceService.getAssists(page).then((value) {
      pageDTO = value;
      allAssists.addAll(value.content);
      change(allAssists, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }
}
