import 'package:client/model/update/update.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';

class UpdateService implements HTTPServiceObserver{
  UpdateService({
    required this.observer
  });
  UpdateServiceObserver observer;
  late final HTTPService _service = HTTPService(this);

  void ping(String token) async {
    // Don't ping if you don't have a token.
    if(token == '') return;
    _service.getRequest('/update', {'token': token});
  }
  
  @override
  void processException(String body) {
    observer.increaseFailCount();
  }
  
  @override
  void processFailure(int errorCode, String body) {
    observer.increaseFailCount();
  }
  
  @override
  void processSuccess(String body) {
    // Deserialize the Result, pass that to reviewNewUpdates()
    List<Update> updates = JSONEncoder.decodeUpdateResponse(body);
    observer.reviewNewUpdates(updates);
  }
}

abstract class UpdateServiceObserver {
  void increaseFailCount();
  void reviewNewUpdates(List<Update> updates);
}