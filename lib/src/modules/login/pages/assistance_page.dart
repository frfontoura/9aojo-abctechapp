import 'package:abctechapp/src/modules/login/controller/assistance_controller.dart';
import 'package:abctechapp/src/modules/login/dto/assistance_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class AssistancePage extends GetView<AssistanceController> {
  const AssistancePage({super.key});

  Widget _moviesGrid(BuildContext context) {
    return LazyLoadScrollView(
        onEndOfPage: (() => controller.nextPage()),
        child: GridView.builder(
          itemCount: controller.pageDTO.totalElements,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: ((context, index) => _buildGridTileList(context, controller.allAssists[index])),
        ));
  }

  Widget _buildGridTileList(BuildContext context, AssistanceDTO assistanceDTO) {
    return Text(assistanceDTO.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Filmes em destaque")),
        body: Container(color: Colors.black87, child: Obx(() => _moviesGrid(context))));
  }
}
