part of 'tips_and_tricks_cubit.dart';

@immutable
abstract class TipsAndTricksState {}

class TipsAndTricksInitial extends TipsAndTricksState {}

class GetWorkoutsTipsLoadingState extends TipsAndTricksState {}

class GetWorkoutsTipsSuccessState extends TipsAndTricksState {}

class GetWorkoutsTipsErrorState extends TipsAndTricksState {
  final String errMsg;

  GetWorkoutsTipsErrorState(this.errMsg);
}

class GetFoodTipsLoadingState extends TipsAndTricksState {}

class GetFoodTipsSuccessState extends TipsAndTricksState {}

class GetFoodTipsErrorState extends TipsAndTricksState {
  final String errMsg;

  GetFoodTipsErrorState(this.errMsg);
}

class GetLifeStyleTipsLoadingState extends TipsAndTricksState {}

class GetLifeStyleTipsSuccessState extends TipsAndTricksState {}

class GetLifeStyleTipsErrorState extends TipsAndTricksState {
  final String errMsg;

  GetLifeStyleTipsErrorState(this.errMsg);
}
