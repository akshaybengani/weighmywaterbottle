import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/dashboard/dashboard_bloc.dart';
import 'package:weighmywaterbottle/models/intake/intake.dart';
import 'package:weighmywaterbottle/services/wayfinder.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc _dashboardBloc;

  TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  void initState() {
    _dashboardBloc = DashboardBloc();
    _dashboardBloc.add(LoadDashboard());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (final BuildContext _) {
        return _dashboardBloc;
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (final BuildContext context, final DashboardState state) {
          return _body(state);
        },
      ),
    );
  }

  Widget _body(final DashboardState state) {
    if (state is DashboardLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          _dashboardBloc.add(LoadDashboard());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Welcome back",
              style: textStyle,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (state.intakeHistory.isEmpty)
                      Center(
                        child: Text(
                          "No intake History Available",
                          style: textStyle,
                        ),
                      ),
                    if (state.intakeHistory.isNotEmpty)
                      ...state.intakeHistory.map(
                        (Intake intake) {
                          return Card(
                            child: Text(
                              "Intake Amount${intake.amount}",
                              style: textStyle,
                            ),
                          );
                        },
                      ).toList()
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Wayfinder.instance.waterIntake();
                },
                child: Text(
                  "Add water intake",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
