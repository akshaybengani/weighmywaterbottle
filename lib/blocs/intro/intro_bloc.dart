import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighmywaterbottle/blocs/intro/intro_event.dart';
import 'package:weighmywaterbottle/blocs/intro/intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroLoaded());

  @override
  Stream<IntroState> mapEventToState(
    final IntroEvent event,
  ) async* {
    if (event is ConnectWithGoogle) {}
  }
}
