import 'dart:developer';

import 'package:abctechapp/src/infraestructure/api.dart';
import 'package:abctechapp/src/infraestructure/cache_manager.dart';
import 'package:abctechapp/src/modules/common/dto/error_message_response.dart';
import 'package:abctechapp/src/modules/login/dto/jwt_response_dto.dart';
import 'package:abctechapp/src/modules/login/dto/signin_request_dto.dart';
import 'package:abctechapp/src/modules/login/dto/signup_request_dto.dart';
import 'package:abctechapp/src/modules/login/dto/signup_response_dto.dart';
import 'package:abctechapp/src/modules/login/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService with CacheManager {
  final AuthProvider _authProvider;
  final Api api = Get.find();
  final RxBool isLogged = false.obs;

  AuthService(this._authProvider);

  Future<AuthService> init() async => this;

  Future<SingupResponseDTO> signup(SignupRequestDTO signupRequestDTO) async {
    Response response = await _authProvider.signup(signupRequestDTO);

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
      return Future.sync(() => SingupResponseDTO.fromJson(response.bodyString!));
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  Future<JwtResponseDTO> signin(SigninRequestDTO signinRequestDTO) async {
    Response response = await _authProvider.signin(signinRequestDTO);

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
      final jwtResponse = JwtResponseDTO.fromJson(response.bodyString!);
      final token = '${jwtResponse.type} ${jwtResponse.token}';

      await saveToken(token);
      isLogged.value = true;
      api.setAuthorizationHeader(token);

      return Future.sync(() => jwtResponse);
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  void logOut() {
    isLogged.value = false;
    api.setAuthorizationHeader(null);
    removeToken();
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
      api.setAuthorizationHeader(token);
    }
  }
}
