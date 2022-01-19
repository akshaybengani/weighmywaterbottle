import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighmywaterbottle/providers/user_data_provider.dart';

class UserData {
  static final UserData instance = UserData._();

  UserData._();

  late GlobalKey<NavigatorState> navigatorKey;

  static UserDataProvider get provider {
    return Provider.of<UserDataProvider>(
      UserData.instance.navigatorKey.currentContext!,
      listen: false,
    );
  }

  static UserDataProvider listener(
    final BuildContext context,
  ) {
    return Provider.of<UserDataProvider>(
      context,
      listen: true,
    );
  }
}
