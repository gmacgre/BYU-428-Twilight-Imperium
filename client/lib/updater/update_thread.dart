class UpdateThread {
  void start() async {
    int i = 0;
    while(true) {
      await Future.delayed(const Duration(seconds: 5));
      print('tick ${i++}');
    }
  }
}