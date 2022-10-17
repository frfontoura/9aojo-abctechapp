import 'package:abctechapp/src/modules/order/controller/order_controller.dart';
import 'package:abctechapp/src/modules/order/dto/order_dto.dart';
import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:abctechapp/src/modules/order/enums/order_location_type.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  Widget _renderOrders(List<OrderDTO> state) {
    return LazyLoadScrollView(
        onEndOfPage: (() => controller.nextPage()),
        child: ListView.builder(
          itemCount: controller.allOrders.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => _buildTileList(context, index),
        ));
  }

  Widget _buildTileList(BuildContext context, int index) {
    OrderDTO order = controller.allOrders[index];

    Widget startOrderLocation = buildOrderLocationInfo(OrderLocationType.START, order.startOrderLocation);

    Widget finishOrderLocation = order.finishOrderLocation != null
        ? buildOrderLocationInfo(OrderLocationType.FINISH, order.finishOrderLocation!)
        : const Text('Não finalizada', style: TextStyle(fontSize: 14, color: Colors.grey));

    return InkWell(
      // onTap: () => controller.selectAssist(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ordem: ${order.orderCode.substring(0, order.orderCode.indexOf('-'))}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                'Quantidade de serviços selecionados: ${order.assistsCodes.length}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              startOrderLocation,
              const SizedBox(height: 20),
              finishOrderLocation,
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.offAndToNamed(Routes.signup),
                child: const Text('Ver detalhes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderLocationInfo(OrderLocationType type, OrderLocationDTO orderLocation) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              '${OrderLocationType.START == type ? 'Iniciado' : 'Finalizado'} em:',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(formatter.format(orderLocation.dateTime), style: const TextStyle(fontSize: 14, color: Colors.grey))
          ],
        ),
        Column(
          children: [
            const Text('Latitude', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('${orderLocation.latitude}', style: const TextStyle(fontSize: 14, color: Colors.grey))
          ],
        ),
        Column(
          children: [
            const Text('Longitude', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('${orderLocation.longitude}', style: const TextStyle(fontSize: 14, color: Colors.grey))
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ordens de serviço")),
      body: Container(
        color: Colors.black87,
        constraints: const BoxConstraints.expand(),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text('Exibir as ordens ativas?', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Obx(
                  () => Switch(
                    value: controller.showActiveOrders.isTrue,
                    onChanged: (value) => controller.changeOrderStatusFilter(),
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange,
                    inactiveTrackColor: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          controller.obx((state) => _renderOrders(state ?? [])),
        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => {}, child: const Icon(Icons.add)),
    );
  }
}
