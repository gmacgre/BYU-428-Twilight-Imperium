import 'package:client/model/request_response/error_response.dart';
import 'package:client/model/request_response/login/login_request.dart';
import 'package:client/model/request_response/login/login_response.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/messaging/service_observer.dart';
import 'package:client/service/json/json_encoder.dart';

class LoginService implements HTTPServiceObserver {
  late HTTPService _httpService;
  late final LoginServiceObserver _observer;
  
  LoginService(this._observer) {
    _httpService = HTTPService(this);
  }

  sendLoginRequest(String roomCode, String roomPassword, int playerNum) {
    LoginRequest request = LoginRequest(
      roomCode: roomCode,
      roomPassword: roomPassword,
      playerTurn: playerNum
    );
    String body = JSONEncoder.encode(request);
    _httpService.postRequest('/login', {}, body);
    _observer.notifySent();
  }

  @override
  void processFailure(int errorCode, String body) {
    try {
      ErrorResponse res = JSONEncoder.decodeErrorResponse(body);
      _observer.notifyFailure("$errorCode: ${res.message}");
    } on FormatException  catch (e){
      _observer.notifyFailure('Error Processing /login: ${e.message}');
    }
    
  }

  @override
  void processSuccess(String body) {
    try {
      LoginResponse res = JSONEncoder.decodeLoginResponse(body);
      _observer.notifySuccess(res.playerTurn, res.userToken);
    } on FormatException catch (e) {
      _observer.notifyFailure('Error Processing /login: ${e.message}');
    }
  }

  @override
  void processException(String body) {
    _observer.notifyFailure(body);
  }
}

abstract class LoginServiceObserver extends ServiceObserver {
  void notifySuccess(int turn, String userToken);
}

