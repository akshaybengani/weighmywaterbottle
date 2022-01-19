import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

import 'package:weighmywaterbottle/services/log_service.dart';

class ConnectionService {
  static Future<bool> get checkConnection async {
    ConnectivityResult res = await (Connectivity().checkConnectivity());

    if (res == ConnectivityResult.mobile ||
        res == ConnectivityResult.wifi ||
        res == ConnectivityResult.ethernet) {
      try {
        final result = await InternetAddress.lookup("firebase.google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          LogService.log('connected');
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }
}
