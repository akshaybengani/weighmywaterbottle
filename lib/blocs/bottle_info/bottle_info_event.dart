abstract class BottleInfoEvent {}

class UpdateBottleInfo extends BottleInfoEvent {
  final double fullBottleWeight;
  final double emptyBottleWeight;

  UpdateBottleInfo({
    required this.fullBottleWeight,
    required this.emptyBottleWeight,
  });
}
