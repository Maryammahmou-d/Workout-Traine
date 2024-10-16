import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/models/food_item.dart';
import 'package:gym/models/food_recipe_model.dart';
import 'package:gym/shared/constants.dart';

import '../../services/dio_helper.dart';
import '../../services/local_storage/cache_helper.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());

  List<FoodPlanModel> foodPlans = [];
  List<FoodRecipesModel> cookingRecipes = [];

  bool isAlternative = false;
  void changeDisplayedFood(int index) {
    isAlternative = !isAlternative;
    emit(ChangeDisplayedFood(isAlternative, index));
  }

  Future<void> saveFoodPlans() async {
    final List<String> foodPlansJson =
        foodPlans.map((plan) => json.encode(plan.toJson())).toList();
    await CacheHelper.setData(
        key: "${AppConstants.authRepository.user.id}-food-plan",
        value: foodPlansJson);
  }

  Future<void> getFoodPlansFromCache() async {
    emit(GetFoodPlansLoadingState());
    final List<Object?>? foodPlansJson = await CacheHelper.getData(
      key: "${AppConstants.authRepository.user.id}-food-plan",
    );

    if (foodPlansJson != null) {
      final List<String> foodPlansStringList =
          foodPlansJson.cast<String>().toList();
      foodPlans = foodPlansStringList
          .map((item) => FoodPlanModel.fromJson(json.decode(item)))
          .toList();

      emit(GetFoodPlansSuccessState());
      getFoodPlans(userId: AppConstants.authRepository.user.id);
    } else {
      await getFoodPlans(userId: AppConstants.authRepository.user.id);
    }
  }

  Future<void> getFoodPlans({
    required String userId,
    bool isFromCache = false,
  }) async {
    if (!isFromCache) {
      emit(GetFoodPlansLoadingState());
    }
    try {
      Response response = await DioHelper.getData(
        endpoint: 'auth/food/get',
        body: {
          "id": AppConstants.authRepository.user.id,
        },
      );
      if (response.statusCode == 200) {
        foodPlans = (response.data as List).map((planJson) {
          return FoodPlanModel.fromJson(planJson);
        }).toList();
        saveFoodPlans();
        emit(GetFoodPlansSuccessState());
      } else {
        emit(GetFoodPlansErrorState(response.data['error']));
      }
    } catch (e) {
      emit(GetFoodPlansErrorState(e.toString()));
    }
  }

  Future<void> getCookingRecipesPlans() async {
    emit(GetCookingRecipesLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: 'auth/food-recipes/get',
      );
      if (response.statusCode == 200) {
        cookingRecipes = (response.data as List).map((planJson) {
          return FoodRecipesModel.fromJson(planJson);
        }).toList();
        emit(GetCookingRecipesSuccessState());
      } else {
        emit(GetCookingRecipesErrorState(response.data['error']));
      }
    } catch (e) {
      emit(GetCookingRecipesErrorState(e.toString()));
    }
  }
}
