import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/intro/intro_bloc.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool checkboxValue = false;

  late IntroBloc _introBloc;

  TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  void initState() {
    _introBloc = IntroBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroBloc>(
      create: (final BuildContext _) {
        return _introBloc;
      },
      child: BlocBuilder<IntroBloc, IntroState>(
        builder: (final BuildContext context, final IntroState state) {
          return _body(state);
        },
      ),
    );
  }

  Widget _body(final IntroState state) {
    if (state is IntroLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Connect your Google Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "We will take your email to identify you as unique user",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Text(
              "And special access to read and write your hydration activity in Google fit",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: checkboxValue,
                  onChanged: (bool? changedValue) {
                    if (changedValue != null) {
                      setState(() {
                        checkboxValue = changedValue;
                      });
                    }
                  },
                ),
                Text(
                  "Are you sure you want to continue",
                  style: textStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: checkboxValue
                  ? () => _introBloc.add(ConnectWithGoogle())
                  : null,
              child: Text(
                "Connect with Google",
                style: textStyle,
              ),
            ),
          ],
        ),
      );
    }
  }
}
