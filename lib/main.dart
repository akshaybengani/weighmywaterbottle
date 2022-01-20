import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighmywaterbottle/providers/user_data_provider.dart';
import 'package:weighmywaterbottle/screens/startup/startup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (final BuildContext _) {
              return UserDataProvider();
            },
          ),
        ],
        child: WeighMyWaterBottle(),
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
}

class WeighMyWaterBottle extends StatelessWidget {
  WeighMyWaterBottle({Key? key}) : super(key: key);

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: "Weight My Water Bottle",
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: _analytics,
        ),
      ],
      home: StartupScreen(
        navigatorKey: _navigatorKey,
      ),
    );
  }
}
