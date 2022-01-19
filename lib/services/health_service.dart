import 'package:health/health.dart';
import 'package:weighmywaterbottle/services/log_service.dart';

class HealthService {
  static final HealthService instance = HealthService._();
  HealthService._();

  final List<HealthDataType> _type = [HealthDataType.WATER];
  final List<HealthDataAccess> _access = [HealthDataAccess.WRITE];
  final List<HealthDataAccess> _permission = [HealthDataAccess.READ_WRITE];

  final HealthFactory _health = HealthFactory();

  Future<bool> get requestPermission async {
    return _health.requestAuthorization(_type, permissions: _permission);
  }

  Future<bool> logWater({
    required double waterML,
  }) async {
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(seconds: 5));

    // 1ml = 0.001
    // 10ml = 0.01
    // 100ml = 0.1
    // 1000ml = 1
    // divide by 1000

    final double intake = waterML / 1000;

    bool? hasPermissions = await HealthFactory.hasPermissions(
      _type,
      permissions: _access,
    );

    if (hasPermissions == false) {
      await _health.requestAuthorization(_type, permissions: _permission);
    }

    bool success = await _health.writeHealthData(
      intake,
      HealthDataType.WATER,
      earlier,
      now,
    );

    LogService.log("Water intake is $success");
    return success;
  }
}


  // bool permissionStatus =
  //                 await HealthService.instance.requestPermission;

  //             if (permissionStatus) {
  //               bool recordStatus =
  //                   await HealthService.instance.logWater(waterML: 100);
  //               LogService.log("Water record status $recordStatus");
  //             } else {
  //               LogService.log("Water Logging permission denied");
  //             }