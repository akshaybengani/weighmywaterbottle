import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/services/wayfinder.dart';

// Event
abstract class BottleInfoEvent {}

class UpdateBottleInfo extends BottleInfoEvent {
  final double fullBottleWeight;
  final double emptyBottleWeight;

  UpdateBottleInfo({
    required this.fullBottleWeight,
    required this.emptyBottleWeight,
  });
}

// State
abstract class BottleInfoState {}

class BottleInfoLoading extends BottleInfoState {}

class BottleInfoLoaded extends BottleInfoState {}

// Bloc
class BottleInfoBloc extends Bloc<BottleInfoEvent, BottleInfoState> {
  BottleInfoBloc() : super(BottleInfoLoaded());

  @override
  Stream<BottleInfoState> mapEventToState(
    final BottleInfoEvent event,
  ) async* {
    if (event is UpdateBottleInfo) {
      yield BottleInfoLoading();

      await Future.delayed(const Duration(seconds: 1));

      Wayfinder.instance.dashboard();

      yield BottleInfoLoaded();
    }
  }
}
