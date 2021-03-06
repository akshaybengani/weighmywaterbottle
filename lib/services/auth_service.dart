import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:weighmywaterbottle/services/log_service.dart';

class AuthService {
  static final AuthService instance = AuthService._();

  AuthService._();

  GlobalKey<NavigatorState>? _navigatorKey;

  set navigatorKey(final GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  BuildContext get context {
    return _navigatorKey!.currentState!.context;
  }

  void setUserIdToFirebaseCrashAnalytics() {
    FirebaseCrashlytics.instance.setUserIdentifier("userid").then(
          (_) => LogService.log(
            "🔥🔥User ID setuped in Firebase CrashAnalytics🔥🔥",
          ),
        );
  }

  Future<void> get logout async {}
}
