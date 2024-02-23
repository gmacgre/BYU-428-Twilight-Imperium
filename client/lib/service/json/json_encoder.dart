import 'dart:convert';

import 'package:client/model/request_response/login/login_response.dart';

class JSONEncoder {
  static String encode(Object toEncode) {
    return jsonEncode(toEncode);
  }

  //Note: I tried making these decoder functions more generic, but I lost the thread around trying to make 
  //MapperContainers.global work for this project.
  //So for right now, I have 
  static LoginResponse decodeLoginResponse(String toDecode) {
    return LoginResponse.fromJson(jsonDecode(toDecode) as Map<String, dynamic>);
  }
}