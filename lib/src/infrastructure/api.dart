import 'dart:convert';
import 'package:abctechapp/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Map<String, dynamic>> get(String endpoint, Map<String, dynamic> params) async {
    try {
      Uri getRequest = Uri.https(Constants.apiUrl, endpoint, params);

      var response = await http.get(getRequest);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Future.sync(() => data);
      } else {
        return Future.error(response.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
