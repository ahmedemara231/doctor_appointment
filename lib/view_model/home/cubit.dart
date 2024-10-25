import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>
{
  HomeCubit() : super(HomeState.initial());
  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

}