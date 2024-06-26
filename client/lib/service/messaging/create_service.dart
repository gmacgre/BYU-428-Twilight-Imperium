import 'package:client/model/request_response/create/create_request.dart';
import 'package:client/model/request_response/error_response.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/messaging/service_observer.dart';
import 'package:client/service/json/json_encoder.dart';

class CreateService implements HTTPServiceObserver {
  late final HTTPService _httpService;
  late final CreateServiceObserver _observer;

  CreateService(this._observer) {
    _httpService = HTTPService(this);
  }

  sendCreateRequest(String roomCode, String roomPassword) {
    CreateRequest toEncode = CreateRequest(roomCode: roomCode, roomPassword: roomPassword);
    String body = JSONEncoder.encode(toEncode);
    _httpService.postRequest('/create', {}, body);
    _observer.notifySent();
  }

  @override
  void processFailure(int errorCode, String body) {
    try {
      ErrorResponse res = JSONEncoder.decodeErrorResponse(body);
      _observer.notifyFailure('$errorCode: ${res.message}');
    } on FormatException catch (e) {
      _observer.notifyFailure('Error Processing /create: ${e.message}');
    }
  }

  @override
  void processSuccess(String body) {
    try {
      CreateRequest res = JSONEncoder.decodeCreateRequest(body);
      _observer.notifySuccess(res.roomCode, res.roomPassword);
    } on FormatException catch (e) {
      _observer.notifyFailure('Error Processing /create: ${e.message}');
    }
  }

  @override
  void processException(String body) {
    _observer.notifyFailure(body);
  }
}

abstract class CreateServiceObserver extends ServiceObserver {
  void notifySuccess(String room, String pass);
}