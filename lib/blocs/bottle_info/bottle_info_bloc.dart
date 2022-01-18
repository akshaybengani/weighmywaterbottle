import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/bottle_info/bottle_info_event.dart';
import 'package:weighmywaterbottle/blocs/bottle_info/bottle_info_state.dart';

class BottleInfoBloc extends Bloc<BottleInfoEvent, BottleInfoState> {
  BottleInfoBloc() : super(BottleInfoLoaded());

  @override
  Stream<BottleInfoState> mapEventToState(
    final BottleInfoEvent event,
  ) async* {
    if (event is UpdateBottleInfo) {}
  }
}
