import 'package:client/data/datacache.dart';
import 'package:client/model/request_response/error_response.dart';
import 'package:client/model/request_response/gameState/game_state_response.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';
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
    try {
      GameStateResponse res = JSONEncoder.decodeGameStateResponse(body);
      DataCache cache = DataCache.instance;
      cache.players = res.players;
      
      _observer.notifySuccess();
    } on FormatException  catch (e){
      _observer.notifyFailure('Error Processing Successful /gameState: ${e.message}');
    }
  }

  @override
  void processFailure(int errorCode, String body) {
    try {
      ErrorResponse res = JSONEncoder.decodeErrorResponse(body);
      _observer.notifyFailure("$errorCode: ${res.message}");
    } on FormatException  catch (e){
      _observer.notifyFailure('Error Processing /gameState: ${e.message}');
    }
  }

  @override
  void processException(String body) {
    _observer.notifyFailure('Error getting game state - $body');
  }
}

abstract class GameStateServiceObserver extends ServiceObserver {
  void notifySuccess();
}