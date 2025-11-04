class PhoenixRefManager {
  static int _counter = 0;

  static String generateRef() {
    _counter++;
    return _counter.toString();
  }

  static void reset() {
    _counter = 0;
  }
}
