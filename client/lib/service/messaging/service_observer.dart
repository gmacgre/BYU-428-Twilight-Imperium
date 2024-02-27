abstract class ServiceObserver {
  void notifySent();
  void notifyFailure(String message);
}