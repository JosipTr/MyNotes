import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit extends Cubit<bool> {
  SelectionCubit() : super(false);

  void select() => emit(!state);
}
