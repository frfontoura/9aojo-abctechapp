import 'dart:html';

import 'package:abctechapp/src/infraestructure/api.dart';
import 'package:get/get.dart';

class AssistanceProvider {
  final Api api = Get.find();

  Future<Response> getAssists(int page) => api.get('/assists');
}
