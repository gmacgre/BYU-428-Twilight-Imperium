import 'package:client/data/strings.dart';
import 'package:client/service/messaging/create_service.dart';
import 'package:client/service/messaging/game_state_service.dart';
import 'package:client/service/messaging/login_service.dart';

class CreateAndJoinPagePresenter {

  CreateAndJoinPagePresenter(this._view) {
    _loginService = LoginService(_LoginServiceObserver(this));
    _createService = CreateService(_CreateServiceObserver(this));
    _gameStateService = GameStateService(_GameStateServiceObserver(this));
  }

  String _text = "";
  String _pass = "";
  int _playerNumber = -1;
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
  void changeSeatNumber(int newNum) {
    _playerNumber = newNum;
  }

  void joinGame() {
    if(_noInput()) return;
    _view.setButtonState(false);
    _loginService.sendLoginRequest(_text, _pass, _playerNumber - 1);
  }

  void createGame() {
    if(_noInput()) return;
    _view.setButtonState(false);
    _createService.sendCreateRequest(_text, _pass);
  }

  bool _noInput() {
    if(_pass == "" || _text == "" || _playerNumber == -1) {
      _view.postToast(Strings.needBothRoomInput);
      return true;
    }
    return false;
  } 

  //The following are methods that private classes can call after returning from HTTP calls
  void _getGameState(int turn, String userToken) {
    _view.postToast(Strings.successNeedConnect(turn));
    _gameStateService.getGameState(userToken);
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

  void _login(String room, String pass) {
    _view.postToast(Strings.createSuccess);
    _loginService.sendLoginRequest(room, pass, _playerNumber - 1);
  }
}

class _LoginServiceObserver implements LoginServiceObserver {
  final CreateAndJoinPagePresenter _presenter;
  _LoginServiceObserver(this._presenter);
  @override
  void notifySuccess(int turn, String userToken) {
    _presenter._getGameState(turn, userToken);
  }

  @override
  void notifyFailure(String message) {
    _presenter._failedConnection(message);
  }

  @override
  void notifySent() {
    _presenter._notifyView(Strings.loginAttempt);
  }
}

class _CreateServiceObserver implements CreateServiceObserver {
  final CreateAndJoinPagePresenter _presenter;
  _CreateServiceObserver(this._presenter);
  @override
  void notifySuccess(String room, String pass) {
    _presenter._login(room, pass);
  }

  @override
  void notifyFailure(String message) {
    _presenter._failedConnection(message);
  }

  @override
  void notifySent() {
    _presenter._notifyView(Strings.createAttempt);
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