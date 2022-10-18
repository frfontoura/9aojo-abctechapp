import 'package:abctechapp/src/modules/assists/controller/assistance_controller.dart';
import 'package:abctechapp/src/modules/assists/dto/assistance_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class AssistancePage extends GetView<AssistanceController> {
  const AssistancePage({super.key});

  Widget _renderAssist(Set<AssistanceDTO> state) {
    return LazyLoadScrollView(
        onEndOfPage: (() => controller.nextPage()),
        child: ListView.builder(
          itemCount: controller.allAssists.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => _buildTileList(context, index),
        ));
  }

  Widget _buildTileList(BuildContext context, int index) {
    AssistanceDTO assistanceDTO = controller.allAssists.elementAt(index);

    bool isSelected = controller.isSelected(index);

    return InkWell(
      onTap: () => controller.selectAssist(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? Colors.orange : Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                assistanceDTO.name,
                style: TextStyle(fontSize: 18, color: isSelected ? Colors.orange : Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                assistanceDTO.description,
                style: TextStyle(fontSize: 14, color: isSelected ? Colors.orange : Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Criar nova ordem de serviço")),
        body: Container(
          color: Colors.black87,
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Obx(() => Text(
                          'Serviços selecionados ${controller.selectedAssists.length} de 15',
                          style: const TextStyle(fontSize: 16, color: Colors.orange),
                          textAlign: TextAlign.left,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(child: controller.obx((state) => _renderAssist(state ?? {}))),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () => controller.finishSelectAssist(context), child: const Icon(Icons.done)));
  }
}
