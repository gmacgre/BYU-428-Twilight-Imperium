class CreateAndJoinPagePresenter {

  CreateAndJoinPagePresenter(this._view);

  String? _text;
  String? _pass;
  final CreateAndJoinPageView _view;


  void saveCode(String text) {
    _text = text;
  }
  void savePassword(String text) {
    _pass = text;
  }

  void joinGame() {
    //TODO: SEND TO THE JOIN GAME SERVICE
  }

  void createGame() {
    //TODO: SEND TO THE CREATE GAME SERVICE
    swapToBoard();
  }

  void swapToBoard() {
    _view.swapToBoard();
  }
}

abstract interface class CreateAndJoinPageView {
  void swapToBoard();
}