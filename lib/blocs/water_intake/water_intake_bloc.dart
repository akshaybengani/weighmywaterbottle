import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class WaterIntakeEvent {}

class UpdateWeight extends WaterIntakeEvent {
  final double weight;

  UpdateWeight({
    required this.weight,
  });
}

// State
abstract class WaterIntakeState {}

class WaterIntakeLoading extends WaterIntakeState {}

class WaterIntakeLoaded extends WaterIntakeState {}

// Bloc
class WaterIntakeBloc extends Bloc<WaterIntakeEvent, WaterIntakeState> {
  WaterIntakeBloc() : super(WaterIntakeLoaded());

  @override
  Stream<WaterIntakeState> mapEventToState(
    final WaterIntakeEvent event,
  ) async* {
    if (event is UpdateWeight) {}
  }
}
