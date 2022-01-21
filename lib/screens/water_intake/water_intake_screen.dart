import 'package:flutter/material.dart';

class WaterIntakeScreen extends StatefulWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Add Bottle Weight",
            style: textStyle,
          )
        ],
      ),
    );
  }
}
