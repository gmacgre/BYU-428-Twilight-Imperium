import 'package:client/data/datacache.dart';
import 'package:client/model/request_response/activate/Activate_request.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';
import 'package:client/service/messaging/service_observer.dart';

class ActivationService implements HTTPServiceObserver {

  late final HTTPService _httpService;
  late final ActivationServiceObserver _observer;
  

  ActivationService(this._observer) {
    _httpService = HTTPService(this);
  }

  void sendActivationRequest(int x, int y) {
    Map<String, String> headers = { 'token': DataCache.instance.userToken };
    ActivateRequest req = ActivateRequest(x, y);
    _httpService.postRequest('/', headers, JSONEncoder.encode(req));
    _observer.notifySent();
  }

  @override
  void processFailure(int errorCode, String body) {
    _observer.notifyFailure('Failed /activate ($errorCode): $body');
  }

  @override
  void processSuccess(String body) {
    _observer.notifySuccess();
  }

  @override
  void processException(String body) {
    _observer.notifyFailure('Exception in /activate: $body');
  }
}

abstract class ActivationServiceObserver extends ServiceObserver {
  void notifySuccess();
}