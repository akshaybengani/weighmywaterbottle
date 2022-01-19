import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:weighmywaterbottle/services/log_service.dart';

class AnalyticsService {
  static final AnalyticsService instance = AnalyticsService._();

  AnalyticsService._();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void logEvent({
    required final String name,
    Map<String, dynamic>? params,
  }) async {
    if (params != null) {
      params.addAll(
        {
          "user_id": "USERID",
        },
      );
    } else {
      params = {
        "user_id": "USERID",
      };
    }

    analytics.logEvent(name: name, parameters: params).then((_) {
      LogService.log("\n📒📒 Event logged 📒📒\n📒📒 $name 📒📒");
    });
  }
}
