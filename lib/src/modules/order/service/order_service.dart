import 'dart:developer';

import 'package:abctechapp/src/modules/common/dto/error_message_response.dart';
import 'package:abctechapp/src/modules/common/dto/page.dart';
import 'package:abctechapp/src/modules/order/dto/order_detail_dto.dart';
import 'package:abctechapp/src/modules/order/dto/order_dto.dart';
import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:abctechapp/src/modules/order/enums/order_status.dart';
import 'package:abctechapp/src/modules/order/provider/order_provider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OrderService extends GetxService {
  final OrderProvider _orderProvider;

  OrderService(this._orderProvider);

  Future<PageDTO<OrderDTO>> getOrders(OrderStatus orderStatus, int page) async {
    Response response = await _orderProvider.getOrders(orderStatus, page);

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
      var page = PageDTO<OrderDTO>.fromJson(response.bodyString!, (value) => OrderDTO.fromMap(value));

      return Future.sync(() => page);
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  Future<OrderDTO> createOrder(OrderDTO orderDTO) async {
    Response response = await _orderProvider.createOrder(orderDTO);

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
      return Future.sync(() => OrderDTO.fromJson(response.bodyString!));
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  Future<OrderDTO> finilizeOrder(String orderCode, OrderLocationDTO finishOrderLocation) async {
    Response response = await _orderProvider.finilizeOrder(orderCode, finishOrderLocation);

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
      return Future.sync(() => OrderDTO.fromJson(response.bodyString!));
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  Future<OrderDetailDTO> getOrderDetail(String orderCode) async {
    Response response = await _orderProvider.getOrderDetail(orderCode);

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
      return Future.sync(() => OrderDetailDTO.fromJson(response.bodyString!));
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }
}
