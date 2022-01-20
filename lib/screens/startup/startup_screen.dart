import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/startup/startup_bloc.dart';

class StartupScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const StartupScreen({
    Key? key,
    required final this.navigatorKey,
  }) : super(key: key);

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(final BuildContext _) {
    return BlocProvider<StartupBloc>(
      create: (final BuildContext _) {
        return StartupBloc(
          navigatorKey: widget.navigatorKey,
        )..add(LoadStartup());
      },
      child: BlocBuilder<StartupBloc, void>(
        builder: (final BuildContext _, final void state) {
          return const SafeArea(
            top: false,
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
