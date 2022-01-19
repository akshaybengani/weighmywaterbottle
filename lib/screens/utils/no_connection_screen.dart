import 'package:flutter/material.dart';
import 'package:weighmywaterbottle/blocs/startup/startup_bloc.dart';
import 'package:weighmywaterbottle/services/auth_service.dart';

class NoConnectionScreen extends StatefulWidget {
  final StartupBloc startupBloc;

  const NoConnectionScreen({
    Key? key,
    required final this.startupBloc,
  }) : super(key: key);

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool refreshing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No internet connection"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.instance.logout;
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "We are unable to connect to interent please check your internet connection and try again",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            ElevatedButton(
              onPressed: refreshing == true
                  ? null
                  : () {
                      setState(() => refreshing = true);
                      widget.startupBloc.wayfind();
                      setState(() => refreshing = false);
                    },
              child: const Text(
                "Retry now",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
