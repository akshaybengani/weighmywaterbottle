import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class WaterIntakeEvent {}

class UpdateWeight extends WaterIntakeEvent {
  final int weight;

  UpdateWeight({
    required this.weight,
  });
}

class LoadLastBottleWeight extends WaterIntakeEvent {}

class RecordWeight extends WaterIntakeEvent {}

// State
abstract class WaterIntakeState {}

class WaterIntakeLoading extends WaterIntakeState {}

class TextUpdate extends WaterIntakeState {
  final String text;

  TextUpdate(final this.text);
}

// Bloc
class WaterIntakeBloc extends Bloc<WaterIntakeEvent, WaterIntakeState> {
  WaterIntakeBloc() : super(WaterIntakeLoading());

  int lastBottleWeight = 0;
  int emptyBottleWeight = 0;
  int fullBottleWeight = 0;
  int currentBottleWeight = 0;

  @override
  Stream<WaterIntakeState> mapEventToState(
    final WaterIntakeEvent event,
  ) async* {
    if (event is LoadLastBottleWeight) {
      yield WaterIntakeLoading();

      await Future.delayed(const Duration(seconds: 1));
      lastBottleWeight = 1000;
      emptyBottleWeight = 500;
      fullBottleWeight = 1500;
      currentBottleWeight = lastBottleWeight;

      yield TextUpdate("");
    } else if (event is UpdateWeight) {
      // print(event.weight);

      currentBottleWeight = event.weight;

      String text = "";
      if (lastBottleWeight >= currentBottleWeight) {
        text =
            "Your last bottle weight is $lastBottleWeight\nYour current water weight is $currentBottleWeight\n\n $lastBottleWeight - $currentBottleWeight = ${lastBottleWeight - currentBottleWeight} grams";
      } else {
        text =
            "Your last bottle weight is $lastBottleWeight\nYour current water weight is $currentBottleWeight\n\n Your current weight is higher then the last one, it means you have refilled the water bottle and drinked all of it ";
      }

      yield TextUpdate(text);
    } else if (event is RecordWeight) {
      yield WaterIntakeLoading();

      await Future.delayed(const Duration(seconds: 1));
      yield TextUpdate("");
    }
  }
}
