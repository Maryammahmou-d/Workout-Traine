import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/tips_and_tricks.dart';
import '../../services/dio_helper.dart';
import '../../shared/widgets/snackbar.dart';

part 'tips_and_tricks_state.dart';

class TipsAndTricksCubit extends Cubit<TipsAndTricksState> {
  TipsAndTricksCubit() : super(TipsAndTricksInitial());

  List<TipsAndTricksModel> workouts = [];

  void workoutTipsScreenInit(BuildContext context) {
    if (workouts.isEmpty) {
      getWorkoutTips(context: context);
    }
  }

  Future<void> getWorkoutTips({
    required BuildContext context,
  }) async {
    emit(GetWorkoutsTipsLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: "auth/tips_tricks/workout/get",
      );
      if (response.statusCode == 200) {
        workouts = List<TipsAndTricksModel>.from(response.data
            .map((json) => TipsAndTricksModel.fromJson(json))
            .toList());
        emit(GetWorkoutsTipsSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(GetWorkoutsTipsErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(GetWorkoutsTipsErrorState(e.toString()));
    }
  }

  List<TipsAndTricksModel> food = [];

  void foodTipsScreenInit(BuildContext context) {
    if (food.isEmpty) {
      getFoodTips(context: context);
    }
  }

  Future<void> getFoodTips({
    required BuildContext context,
  }) async {
    emit(GetFoodTipsLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: "auth/tips_tricks/food/get",
      );
      if (response.statusCode == 200) {
        food = List<TipsAndTricksModel>.from(response.data
            .map((json) => TipsAndTricksModel.fromJson(json))
            .toList());
        emit(GetFoodTipsSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(GetFoodTipsErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(GetFoodTipsErrorState(e.toString()));
    }
  }

  List<TipsAndTricksModel> lifeStyle = [];

  void lifeStyleTipsScreenInit(BuildContext context) {
    if (lifeStyle.isEmpty) {
      getLifeStyleTips(context: context);
    }
  }

  Future<void> getLifeStyleTips({
    required BuildContext context,
  }) async {
    emit(GetLifeStyleTipsLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: "auth/tips_tricks/life-style/get",
      );
      if (response.statusCode == 200) {
        lifeStyle = List<TipsAndTricksModel>.from(response.data
            .map((json) => TipsAndTricksModel.fromJson(json))
            .toList());
        emit(GetLifeStyleTipsSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(GetLifeStyleTipsErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(GetLifeStyleTipsErrorState(e.toString()));
    }
  }
}
