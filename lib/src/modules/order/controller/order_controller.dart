import 'package:abctechapp/src/modules/assists/dto/assistance_dto.dart';
import 'package:abctechapp/src/modules/common/dto/page.dart';
import 'package:abctechapp/src/modules/order/dto/order_dto.dart';
import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:abctechapp/src/modules/order/enums/order_status.dart';
import 'package:abctechapp/src/modules/order/service/geolocation_service.dart';
import 'package:abctechapp/src/modules/order/service/order_service.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<List<OrderDTO>> {
  late OrderService _orderService;
  late GeolocationService _geolocationService;

  PageDTO<OrderDTO> pageDTO = PageDTO(content: [], last: false, totalPages: 0, totalElements: 0, numberOfElements: 0, number: 0);
  List<OrderDTO> allOrders = [];
  OrderStatus _orderStatusFilter = OrderStatus.STARTED;
  RxInt navigationIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    _orderService = Get.find<OrderService>();
    _geolocationService = Get.find<GeolocationService>();
    _orderStatusFilter = OrderStatus.STARTED;
    _geolocationService.start();
    _loadOrders(0);
  }

  void createNewOrder() async {
    final selectedAssists = await Get.toNamed(Routes.assists);

    if (selectedAssists != null) {
      _geolocationService.getPosition().then(
        (value) async {
          var startOrderLocation = _orderLocationFromPosition(value);

          final assistsCodes = selectedAssists.map((element) => element.assistanceCode).toList();

          final order = await _orderService.createOrder(OrderDTO(
            assistsCodes: List<String>.from((assistsCodes as List<dynamic>)),
            startOrderLocation: startOrderLocation,
          ));

          Get.snackbar(
            "Sucesso",
            "Ordem de serviço #${order.orderCode!.substring(0, order.orderCode!.indexOf('-'))} criada com sucesso",
            backgroundColor: Colors.black87,
            colorText: Colors.orange,
          );

          onNavigationBarTapped(0);
        },
        onError: (error) => {
          Get.snackbar(
            "Erro ao criar ordem",
            "Para criar uma ordem é necessário permitir o acesso a localização.",
            backgroundColor: Colors.black87,
            colorText: Colors.deepOrange,
          ),
        },
      );
    }
  }

  void onNavigationBarTapped(int index) {
    _orderStatusFilter = OrderStatus.values[index];
    navigationIndex.value = index;
    allOrders.clear();
    _loadOrders(0);
  }

  void nextPage() {
    if (!pageDTO.last) {
      _loadOrders(pageDTO.number + 1);
    }
  }

  Future<void> showFinalizeDialog(BuildContext context, OrderDTO order) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finalizar ordem'),
          content: Text('Deseja finalizar a ordem de serviço #${order.orderCode!.substring(0, order.orderCode!.indexOf('-'))}?'),
          contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Finalizar'),
              onPressed: () {
                _finalizeOrder(order);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadOrders(int page) {
    change([], status: RxStatus.loading());
    _orderService.getOrders(_orderStatusFilter, page).then((value) {
      pageDTO = value;
      allOrders.addAll(value.content);
      change(allOrders, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  void _finalizeOrder(OrderDTO order) async {
    _geolocationService.getPosition().then((value) async {
      var finishOrderLocation = _orderLocationFromPosition(value);

      await _orderService.finilizeOrder(order.orderCode!, finishOrderLocation);

      Get.snackbar(
        "Sucesso",
        "Ordem de serviço #${order.orderCode!.substring(0, order.orderCode!.indexOf('-'))} finalizada com sucesso",
        backgroundColor: Colors.black87,
        colorText: Colors.orange,
      );

      onNavigationBarTapped(0);
    });
  }

  OrderLocationDTO _orderLocationFromPosition(Position position) {
    return OrderLocationDTO(
      latitude: position.latitude,
      longitude: position.longitude,
      dateTime: DateTime.now(),
    );
  }
}
