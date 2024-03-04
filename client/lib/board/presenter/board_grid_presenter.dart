import 'package:client/model/board_grid_model.dart';

class BoardGridPresenter {
  BoardGridPresenter(this._view) {
    _model = BoardGridModel(_depth);
    _view.onBind(_depth);
    _view.setBoardState(_model);
  }
  final int _depth = 3;
  late BoardGridModel _model;
  final BoardGridView _view;

  void startLoop() async {
    int i = 0;
    while(true) {
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}

abstract interface class BoardGridView {
  void onBind(int depth);
  void setBoardState(BoardGridModel model);
}
