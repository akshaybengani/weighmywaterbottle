import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighmywaterbottle/providers/user_data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (final BuildContext _) {
            return UserDataProvider();
          },
        ),
      ],
    ));
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
