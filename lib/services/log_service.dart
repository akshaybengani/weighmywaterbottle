import 'package:flutter/foundation.dart';

class LogService {
  static void log(Object object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
