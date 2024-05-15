import 'package:client/data/datacache.dart';
import 'package:client/model/request_response/move/move_request.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';
import 'package:client/service/messaging/service_observer.dart';

class MoveService implements HTTPServiceObserver {

  late final HTTPService _httpService;
  late final MoveServiceObserver _observer;

  MoveService(this._observer) {
    _httpService = HTTPService(this);
  }

  void sendMoveRequest(List<ShipModel> ships, List<List<int>> srcCoords) {
    Map<String, String> headers = { 'token': DataCache.instance.userToken };
    MoveRequest request = MoveRequest(ships, srcCoords);
    String body = JSONEncoder.encode(request);
    _httpService.postRequest('/move', headers, body);
    _observer.notifySent();
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