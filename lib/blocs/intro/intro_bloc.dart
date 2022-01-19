import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class IntroEvent {}

class ConnectWithGoogle extends IntroEvent {}

// State
abstract class IntroState {}

class IntroLoading extends IntroState {}

class IntroLoaded extends IntroState {}

// Bloc
class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroLoaded());

  @override
  Stream<IntroState> mapEventToState(
    final IntroEvent event,
  ) async* {
    if (event is ConnectWithGoogle) {}
  }
}
