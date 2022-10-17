import 'package:abctechapp/src/modules/common/dto/page.dart';
import 'package:abctechapp/src/modules/order/dto/order_dto.dart';
import 'package:abctechapp/src/modules/order/enums/order_status.dart';
import 'package:abctechapp/src/modules/order/service/order_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<List<OrderDTO>> {
  late OrderService _orderService;
  PageDTO<OrderDTO> pageDTO = PageDTO(content: [], last: false, totalPages: 0, totalElements: 0, numberOfElements: 0, number: 0);
  List<OrderDTO> allOrders = [];
  OrderStatus orderStatusFilter = OrderStatus.FINISHED;
  RxBool showActiveOrders = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _orderService = Get.find<OrderService>();

    loadOrders(0);
  }

  void nextPage() {
    if (!pageDTO.last) {
      loadOrders(pageDTO.number + 1);
    }
  }

  void loadOrders(int page) {
    change([], status: RxStatus.loading());
    _orderService.getOrders(orderStatusFilter, page).then((value) {
      pageDTO = value;
      allOrders.addAll(value.content);
      change(allOrders, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  void changeOrderStatusFilter() {
    switch (orderStatusFilter) {
      case OrderStatus.STARTED:
        {
          orderStatusFilter = OrderStatus.FINISHED;
          showActiveOrders.value = false;
        }
        break;

      case OrderStatus.FINISHED:
        {
          orderStatusFilter = OrderStatus.STARTED;
          showActiveOrders.value = false;
        }
        break;
    }

    allOrders.clear();

    loadOrders(0);
  }
}
