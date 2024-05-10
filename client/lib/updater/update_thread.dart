import 'package:client/model/update/update.dart';
import 'package:client/service/messaging/update_service.dart';

final class UpdateThread implements UpdateServiceObserver{
  static final UpdateThread thread = UpdateThread._();
  UpdateThread._() {
    _runCount = 0;
    _mutex = false;
    _service = UpdateService(observer: this);
  }
  late int _runCount;
  int _failCount = 0;
  late bool _mutex;
  late UpdateService _service;
  UpdateThreadObserver? _observer;
  String? _token;

  void start(UpdateThreadObserver observer, String token) async {
    if(_runCount > 900) {
      // This is to see if the stop has been called recently. If it has, wait a bit before starting the loop. It will reset the count.
      await Future.delayed(const Duration(seconds: 4));
    }
    _runCount++;
    _observer = observer;
    _token = token;
    while(true) {
      await Future.delayed(const Duration(seconds: 3));
      // Basic Async Mutex
      if(_mutex) {
        continue;
      }
      else {
        _mutex = true;
      }

      // Filtering unneeded threads
      if(_runCount > 1) {
        _runCount--;
        _mutex = false;
        break;
      }
      //Basic Ping
      _service.ping(_token!);
      _mutex = false;
    }
  }

  void stop() async {
    _runCount = 999;
    await Future.delayed(const Duration(seconds: 4));
    _runCount = 0;
  }
  
  @override
  void increaseFailCount() {
    _failCount++;
    if (_failCount > 3) {
      if(_observer != null) {
        // _observer!.showDesync(true);
      }
    }
  }
  
  @override
  void reviewNewUpdates(List<Update> updates) {
    _failCount = 0;
    if(_observer != null) {
      _observer!.showDesync(false);
      _observer!.presentUpdate(updates);
    }
  }
}

abstract class UpdateThreadObserver {
  void showDesync(bool val);
  void presentUpdate(List<Update> updates);
}