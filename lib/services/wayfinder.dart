import 'package:flutter/material.dart';
import 'package:weighmywaterbottle/blocs/startup/startup_bloc.dart';
import 'package:weighmywaterbottle/screens/utils/no_connection_screen.dart';
import 'package:weighmywaterbottle/services/analytics_service.dart';

class Wayfinder {
  static final Wayfinder instance = Wayfinder._();

  Wayfinder._();

  GlobalKey<NavigatorState>? _navigatorKey;

  set navigatorKey(final GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  BuildContext get context {
    return _navigatorKey!.currentState!.context;
  }

  void pop() {
    _navigatorKey!.currentState!.pop();
  }

  void popUntilFirst() {
    _navigatorKey!.currentState!.popUntil((final Route currentRoute) {
      return currentRoute.isFirst;
    });
  }

  void popUntil({
    required final Type route,
  }) {
    _navigatorKey!.currentState!.popUntil((final Route currentRoute) {
      return currentRoute.settings.name == route.toString();
    });
  }

  void _push({
    required final MaterialPageRoute materialPageRoute,
  }) {
    _navigatorKey!.currentState!.push(materialPageRoute);
    AnalyticsService.instance.logEvent(
      name: "view_${materialPageRoute.settings.name}",
    );
  }

  void _replace({
    required final dynamic materialPageRoute,
  }) {
    _navigatorKey!.currentState!.pushAndRemoveUntil(
      materialPageRoute,
      (final Route<dynamic> route) {
        return false;
      },
    );
    AnalyticsService.instance.logEvent(
      name: "view_${materialPageRoute.settings.name}",
    );
  }

  void noConnection({
    required final StartupBloc startupBloc,
  }) {
    _replace(
      materialPageRoute: MaterialPageRoute(
        builder: (final BuildContext _) {
          return NoConnectionScreen(
            startupBloc: startupBloc,
          );
        },
        settings: RouteSettings(name: (NoConnectionScreen).toString()),
      ),
    );
  }
}
