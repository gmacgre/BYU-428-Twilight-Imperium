import 'package:client/service/http/http_service.dart';
import 'package:client/service/messaging/service_observer.dart';

class GameStateService implements HTTPServiceObserver {
  late final HTTPService _service;
  late final GameStateServiceObserver _observer;

  GameStateService(this._observer) {
    _service = HTTPService(this);
  }

  void getGameState(String userToken) {
    Map<String, String> headers = {
      'token': userToken
    };
    _service.getRequest('/gameState', headers);
  }

  @override
  void processSuccess(String body) {
    //TODO: Process the response
    _observer.notifySuccess();
  }

  @override
  void processFailure(int errorCode, String body) {
    _observer.notifyFailure('Error getting game state - $errorCode: $body');
  }

  @override
  void processException(String body) {
    _observer.notifyFailure('Error getting game state - $body');
  }
}

abstract class GameStateServiceObserver extends ServiceObserver {
  void notifySuccess();
}