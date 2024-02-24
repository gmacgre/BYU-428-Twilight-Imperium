import 'package:client/service/http/http_service.dart';

class GameStateService implements HTTPServiceObserver {
  late final HTTPService _service;
  late final GameStateServiceObserver _observer;

  GameStateService(this._observer) {
    _service = HTTPService(this);
  }

  void getGameState(String gameId, String userToken) {
    Map<String, String> headers = {
      'userToken': userToken
    };
    _service.getRequest('/gameState/$gameId', headers);
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

abstract interface class GameStateServiceObserver {
  void notifySuccess();
  void notifyFailure(String msg);
}