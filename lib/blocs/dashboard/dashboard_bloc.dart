import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<void, DashboardState> {
  DashboardBloc() : super(DashboardLoaded());

  @override
  Stream<DashboardState> mapEventToState(
    final void event,
  ) async* {}
}
