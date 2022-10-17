import 'package:abctechapp/src/infraestructure/api.dart';
import 'package:abctechapp/src/modules/order/dto/order_dto.dart';
import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:abctechapp/src/modules/order/enums/order_status.dart';
import 'package:get/get.dart';

class OrderProvider {
  final Api api = Get.find();

  Future<Response> getOrders(OrderStatus orderStatus, int page) =>
      api.get('/orders', query: {'page': '$page', 'orderStatusList': orderStatus.name});

  Future<Response> createOrder(OrderDTO orderDTO) => api.post('/orders', orderDTO);

  Future<Response> finilizeOrder(String orderCode, OrderLocationDTO finishOrderLocation) =>
      api.put('/orders/$orderCode/finalize', finishOrderLocation);

  Future<Response> getOrderDetail(String orderCode) => api.get('/orders/$orderCode');
}
