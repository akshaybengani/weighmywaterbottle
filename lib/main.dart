import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const WeighMyWaterBottle());
}

class WeighMyWaterBottle extends StatelessWidget {
  const WeighMyWaterBottle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
