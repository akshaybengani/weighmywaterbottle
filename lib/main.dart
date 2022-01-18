import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(WeighMyWaterBottle());
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
            onPressed: () async {},
          ),
        ),
      ),
    );
  }
}
