import 'package:client/service/http/http_service.dart';
import 'package:client/service/messaging/service_observer.dart';

class MoveService implements HTTPServiceObserver {

  late final HTTPService _httpService;
  late final MoveServiceObserver _observer;

  MoveService(this._observer) {
    _httpService = HTTPService(this);
  }

  void sendMoveRequest() {
    
  }

  @override
  void processSuccess(String body) {
    _observer.notifySuccess();
  }

  @override
  void processFailure(int errorCode, String body) {
    _observer.notifyFailure('Failed /move ($errorCode): $body');
  }

  @override
  void processException(String body) {
    _observer.notifyFailure('Exception in /move: $body');
  }
}

abstract class MoveServiceObserver extends ServiceObserver {
  void notifySuccess();
}