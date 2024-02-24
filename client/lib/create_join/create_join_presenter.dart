import 'package:client/service/http/http_create_service.dart';
import 'package:client/service/http/http_login_service.dart';

class CreateAndJoinPagePresenter {

  CreateAndJoinPagePresenter(this._view) {
    _loginService = LoginService(_LoginServiceObserver(this._view));
    _createService = CreateService(_CreateServiceObserver(this._view));
  }

  String _text = "";
  String _pass = "";
  final CreateAndJoinPageView _view;
  late final LoginService _loginService;
  late final CreateService _createService;

  void saveCode(String text) {
    _text = text;
  }
  void savePassword(String text) {
    _pass = text;
  }

  void joinGame() {
    _loginService.sendLoginRequest(_text, _pass);
  }

  void createGame() {
    _createService.sendCreateRequest(_text, _pass);
  }

  void swapToBoard() {
    _view.swapToBoard();
  }
  
}

class _LoginServiceObserver implements LoginServiceObserver {
  final CreateAndJoinPageView _view;
  _LoginServiceObserver(this._view);
  @override
  void notifySuccess(String code, String pass, String id, String userToken) {
    _view.postToast("Success! $id $code $pass $userToken");
  }

  @override
  void notifyFailure(String message) {
    _view.postToast(message);
  }

  @override
  void notifySent() {
    _view.postToast("Attempting to Log In...");
  }
}

class _CreateServiceObserver implements CreateServiceObserver {
  final CreateAndJoinPageView _view;
  _CreateServiceObserver(this._view);
  @override
  void notifySuccess(String code, String pass, String id, String userToken) {
    _view.postToast("Success! $id $code $pass $userToken");
  }

  @override
  void notifyFailure(String message) {
    _view.postToast(message);
  }

  @override
  void notifySent() {
    _view.postToast("Attempting to Create Game...");
  }
}

abstract interface class CreateAndJoinPageView {
  void swapToBoard();
  void postToast(String msg);
}