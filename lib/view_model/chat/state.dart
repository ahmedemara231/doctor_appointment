part of 'cubit_cubit.dart';

sealed class State extends Equatable {
  const State();
}

final class Initial extends State {
  @override
  List<Object> get props => [];
}
