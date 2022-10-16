import 'dart:developer';

import 'package:abctechapp/src/modules/login/dto/assistance_dto.dart';
import 'package:abctechapp/src/modules/login/dto/error_message_response.dart';
import 'package:abctechapp/src/modules/login/dto/page.dart';
import 'package:abctechapp/src/modules/login/provider/assistance_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssistanceService extends GetxService {
  final AssistanceProvider _assistanceProvider;

  AssistanceService(this._assistanceProvider);

  Future<PageDTO<AssistanceDTO>> getAssists(int page) async {
    Response response = await _assistanceProvider.getAssists(page);

    if (response.hasError) {
      if (response.status.code == 400) {
        final ErrorMessageResponse error = ErrorMessageResponse.fromJson(response.bodyString!);

        if (error.description != null) {
          log(error.description!);
        }

        return Future.error(ErrorDescription(error.message));
      }

      return Future.error(ErrorDescription("Erro na conexao"));
    }

    try {
      var page = PageDTO<AssistanceDTO>.fromJson(response.bodyString!, (value) => AssistanceDTO.fromMap(value));

      return Future.sync(() => page);
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }
}
