part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();
}

class FoodInitial extends FoodState {
  @override
  List<Object> get props => [];
}

class ChangeDisplayedFood extends FoodState {
  final bool isAlternative;
  final int index;
  const ChangeDisplayedFood(this.isAlternative, this.index);
  @override
  List<Object> get props => [isAlternative, index];
}

class GetFoodPlansLoadingState extends FoodState {
  @override
  List<Object> get props => [];
}

class GetFoodPlansSuccessState extends FoodState {
  @override
  List<Object> get props => [];
}

class GetFoodPlansErrorState extends FoodState {
  final String errMsg;

  const GetFoodPlansErrorState(this.errMsg);
  @override
  List<Object> get props => [errMsg];
}

class GetCookingRecipesLoadingState extends FoodState {
  @override
  List<Object> get props => [];
}

class GetCookingRecipesSuccessState extends FoodState {
  @override
  List<Object> get props => [];
}

class GetCookingRecipesErrorState extends FoodState {
  final String errMsg;

  const GetCookingRecipesErrorState(this.errMsg);
  @override
  List<Object> get props => [errMsg];
}
