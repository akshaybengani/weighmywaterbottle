import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/providers/user_data.dart';
import 'package:weighmywaterbottle/services/auth_service.dart';
import 'package:weighmywaterbottle/services/connection_service.dart';
import 'package:weighmywaterbottle/services/wayfinder.dart';

// Event
abstract class StartupEvent {}

class LoadStartup extends StartupEvent {}

// Bloc
class StartupBloc extends Bloc<StartupEvent, void> {
  final GlobalKey<NavigatorState> navigatorKey;

  StartupBloc({
    required final this.navigatorKey,
  }) : super(null) {
    Wayfinder.instance.navigatorKey = navigatorKey;
    // Themer.instance.navigatorKey = navigatorKey;
    AuthService.instance.navigatorKey = navigatorKey;
    UserData.instance.navigatorKey = navigatorKey;
  }

  @override
  Stream<void> mapEventToState(
    final StartupEvent event,
  ) async* {
    if (event is LoadStartup) {
      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
      await wayfind();
    }
  }

  Future<void> wayfind() async {
    // Check for Internet Connection
    if (await ConnectionService.checkConnection == false) {
      Wayfinder.instance.noConnection(startupBloc: this);
      return;
    }

    // Record Errors with Firebase CrashAnalytics
    FlutterError.onError = (final FlutterErrorDetails details) async {
      FirebaseCrashlytics.instance
          .recordError(details.exception, details.stack)
          .then((_) => print("🔥🔥FCA recording untracked errors🔥🔥"));
    };
  }
}
