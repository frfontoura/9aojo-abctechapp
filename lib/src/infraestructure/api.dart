import 'package:abctechapp/src/utils/constants.dart';
import 'package:get/get_connect/connect.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.apiUrl;
  }

  void setAuthorizationHeader(String? token) {
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = '$token';
      return request;
    });
  }
}
