import 'package:abctechapp/src/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OrderController>(OrderController());
  }
}
