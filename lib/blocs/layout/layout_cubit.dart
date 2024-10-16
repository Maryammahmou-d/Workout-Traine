import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int navbarIndex = 0;
  void changeNavBarSelectedIndex(int index) {
    navbarIndex = index;
    emit(ChangeNavBarValueState(navbarIndex));
  }
}
