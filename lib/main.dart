// ignore_for_file: avoid_print, constant_identifier_names, use_key_in_widget_constructors

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weighmywaterbottle/services/health_service.dart';
import 'package:weighmywaterbottle/services/log_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(WeighMyWaterBottle());
  }, FirebaseCrashlytics.instance.recordError);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
}

class WeighMyWaterBottle extends StatelessWidget {
  WeighMyWaterBottle({Key? key}) : super(key: key);

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: _analytics,
        ),
      ],
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text("Test"),
            onPressed: () async {
              bool permissionStatus =
                  await HealthService.instance.requestPermission;

              if (permissionStatus) {
                bool recordStatus =
                    await HealthService.instance.logWater(waterML: 100);
                LogService.log("Water record status $recordStatus");
              } else {
                LogService.log("Water Logging permission denied");
              }
            },
          ),
        ),
      ),
    );
  }
}
