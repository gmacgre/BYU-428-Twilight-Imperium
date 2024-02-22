import 'package:client/model/request_response/login/login_request.dart';
import 'package:client/model/request_response/login/login_response.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';

class LoginService implements HTTPServiceObserver {
  late HTTPService _httpService;

  LoginService() {
    _httpService = HTTPService(this);
  }

  sendLoginRequest(String roomCode, String roomPassword) {
    LoginRequest request = LoginRequest(
      roomCode: roomCode,
      roomPassword: roomPassword
    );
    String body = JSONEncoder.encode(request);
    _httpService.postRequest('/login', {}, body);
    //Let our observer know that they can make the loading show up now :)
  }

  @override
  void processFailure(int errorCode, String body) {
    print('FAILURE:\n$body');
  }

  @override
  void processSuccess(String body) {
    print('SUCCESS:\n$body');
    LoginResponse res = JSONEncoder.decodeLoginResponse(body);
    print(res);
  }
}

