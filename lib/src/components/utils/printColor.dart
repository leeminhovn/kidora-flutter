class printColor {
  static red(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static blue(String text) {
    print('\x1B[34m$text\x1B[0m');
  }
}
