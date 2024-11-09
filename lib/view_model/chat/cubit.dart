import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cubit_state.dart';

class Cubit extends Cubit<State> {
  Cubit() : super(Initial());
}
