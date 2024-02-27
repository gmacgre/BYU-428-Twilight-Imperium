import 'package:client/service/http/create_service.dart';
import 'package:client/service/http/game_state_service.dart';
import 'package:client/service/http/login_service.dart';

class CreateAndJoinPagePresenter {

  CreateAndJoinPagePresenter(this._view) {
    _loginService = LoginService(_LoginServiceObserver(this));
    _createService = CreateService(_CreateServiceObserver(this));
    _gameStateService = GameStateService(_GameStateServiceObserver(this));
  }

  String _text = "";
  String _pass = "";
  final CreateAndJoinPageView _view;
  late final LoginService _loginService;
  late final CreateService _createService;
  late final GameStateService _gameStateService;

  void saveCode(String text) {
    _text = text;
  }
  void savePassword(String text) {
    _pass = text;
  }

  void joinGame() {
    if(_noInput()) return;
    _view.setButtonState(false);
    _loginService.sendLoginRequest(_text, _pass);
  }

  void createGame() {
    if(_noInput()) return;
    _view.setButtonState(false);
    _createService.sendCreateRequest(_text, _pass);
  }

  bool _noInput() {
    if(_pass == "" || _text == "") {
      _view.postToast("Enter both the Room Code and Password.");
      return true;
    }
    return false;
  } 

  //The following are methods that private classes can call after returning from HTTP calls
  void _getGameState(String code, String id, String userToken) {
    _view.postToast("Success! Connecting to $code ($id)...");
    _gameStateService.getGameState(id, userToken);
  }

  void _failedConnection(String msg) {
    _view.postToast(msg);
    _view.setButtonState(true);
  }

  void _notifyView(String message) {
    _view.postToast(message);
  }

  void _swapToBoard() {
    _view.setButtonState(true);
    _view.swapToBoard();
  }
}

class _LoginServiceObserver implements LoginServiceObserver {
  final CreateAndJoinPagePresenter _presenter;
  _LoginServiceObserver(this._presenter);
  @override
  void notifySuccess(String code, String pass, String id, String userToken) {
    _presenter._getGameState(code, id, userToken);
  }

  @override
  void notifyFailure(String message) {
    _presenter._failedConnection(message);
  }

  @override
  void notifySent() {
    _presenter._notifyView("Attempting to Log In...");
  }
}

class _CreateServiceObserver implements CreateServiceObserver {
  final CreateAndJoinPagePresenter _presenter;
  _CreateServiceObserver(this._presenter);
  @override
  void notifySuccess(String code, String pass, String id, String userToken) {
    _presenter._getGameState(code, id, userToken);
  }

  @override
  void notifyFailure(String message) {
    _presenter._failedConnection(message);
  }

  @override
  void notifySent() {
    _presenter._notifyView("Attempting to Create Game...");
  }
}

class _GameStateServiceObserver implements GameStateServiceObserver {
  final CreateAndJoinPagePresenter _presenter;
  _GameStateServiceObserver(this._presenter);

  @override
  void notifyFailure(String msg) {
    _presenter._failedConnection(msg);
  }

  @override
  void notifySuccess() {
    _presenter._swapToBoard();
  }

  @override
  void notifySent() {}
}

abstract interface class CreateAndJoinPageView {
  void swapToBoard();
  void postToast(String msg);
  void setButtonState(bool state);
}