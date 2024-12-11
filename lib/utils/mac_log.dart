import 'dart:developer' as developer;

class MacLog {
  static void printR(dynamic text) {
    developer.log('\x1B[31m$text\x1B[0m');
  }

  static void printG(dynamic text) {
    developer.log('\x1B[32m$text\x1B[0m');
  }

  static void printY(dynamic text) {
    developer.log('\x1B[33m$text\x1B[0m');
  }

  static void printB(dynamic text) {
    developer.log('\x1B[34m$text\x1B[0m');
  }

  static void printM(dynamic text) {
    developer.log('\x1B[35m$text\x1B[0m');
  }

  static void printC(dynamic text) {
    developer.log('\x1B[36m$text\x1B[0m');
  }

  static void printW(dynamic text) {
    developer.log('\x1B[37m$text\x1B[0m');
  }

  static void printO(dynamic text) {
    developer.log('\x1B[38;5;214m$text\x1B[0m');
  }
}
