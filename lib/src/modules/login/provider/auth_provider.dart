import 'package:abctechapp/src/infraestructure/api.dart';
import 'package:abctechapp/src/modules/login/dto/signin_request_dto.dart';
import 'package:abctechapp/src/modules/login/dto/signup_request_dto.dart';
import 'package:get/get.dart';

class AuthProvider {
  final Api api = Get.find();

  Future<Response> signup(SignupRequestDTO signupRequestDTO) => api.post('/api/auth/signup', signupRequestDTO.toMap());

  Future<Response> signin(SigninRequestDTO signinRequestDTO) => api.post('/api/auth/signin', signinRequestDTO.toMap());
}
