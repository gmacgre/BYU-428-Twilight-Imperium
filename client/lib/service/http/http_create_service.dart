import 'package:client/model/request_response/create/create_request.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';

class CreateService implements HTTPServiceObserver {
  late HTTPService _httpService;

  CreateService() {
    _httpService = HTTPService(this);
  }

  sendCreateRequest(String roomCode, String roomPassword) {
    CreateRequest toEncode = CreateRequest(roomCode: roomCode, roomPassword: roomPassword);
    String body = JSONEncoder.encode(toEncode);
    _httpService.postRequest('/create', {}, body);
    //Let our observer know that they can make the loading show up now :)
  }

  @override
  void processFailure(int errorCode, String body) {
    // TODO: implement processFailure
  }

  @override
  void processSuccess(String body) {
    // TODO: implement processSuccess
  }
}