// Event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/models/intake/intake.dart';

abstract class DashboardEvent {}

class LoadDashboard extends DashboardEvent {}

// State
abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Intake> intakeHistory;

  DashboardLoaded({
    required final this.intakeHistory,
  });
}

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(
    final DashboardEvent event,
  ) async* {
    if (event is LoadDashboard) {
      yield DashboardLoading();

      await Future.delayed(const Duration(seconds: 1));

      yield DashboardLoaded(intakeHistory: []);
    }
  }
}
