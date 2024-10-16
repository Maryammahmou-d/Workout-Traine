part of 'layout_cubit.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();
}

class LayoutInitial extends LayoutState {
  @override
  List<Object> get props => [];
}

class ChangeNavBarValueState extends LayoutState {
  final int index;
  const ChangeNavBarValueState(this.index);

  @override
  List<Object?> get props => [index];
}

// // Profile state

// class ProfileInitial extends LayoutState {
//   @override
//   List<Object> get props => [];
// }

// class GetProfileSuccessState extends LayoutState {
//   final UserModel userModel;

//   const GetProfileSuccessState({required this.userModel});

//   @override
//   List<Object> get props => [userModel];
// }

// class GetProfileErrorState extends LayoutState {
//   final String error;

//   const GetProfileErrorState({required this.error});

//   @override
//   List<Object> get props => [error];
// }

// class GetProfileLoadingState extends LayoutState {
//   const GetProfileLoadingState();

//   @override
//   List<Object> get props => [];
// }
