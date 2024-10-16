import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/shared/widgets/snackbar.dart';
import '../../main.dart';
import '../../models/workouts_plan_model.dart';
import '../../shared/constants.dart';
import '../dio_helper.dart';

class WorkoutsRepository {
  Map<String, List<ExerciseModel>> workoutsPlan = {};

  Future<void> getWorkoutsPlanFromCache({bool isForceRefresh = false}) async {
    try {
      String cacheKey = '${AppConstants.authRepository.user.id}-workout-plan';
      var cachedData = AppConstants.box.get(cacheKey);

      debugPrint("Cache data exists: ${cachedData != null}");

      if (cachedData != null && !isForceRefresh) {
        try {
          WorkoutsPlanModel cachedPlan =
              WorkoutsPlanModel.fromJson(json.decode(cachedData));
          workoutsPlan = cachedPlan.exercisesForDays;
        } catch (e) {
          await getWorkoutsPlan(userId: AppConstants.authRepository.user.id);
        }
      } else {
        await getWorkoutsPlan(userId: AppConstants.authRepository.user.id);
      }
    } catch (e) {
      await getWorkoutsPlan(userId: AppConstants.authRepository.user.id);
    }
  }

  Future<void> getWorkoutsPlan({
    required String userId,
  }) async {
    try {
      Response response = await DioHelper.getData(
        endpoint: 'auth/workout/get?id=${AppConstants.authRepository.user.id}',
      );
      if (response.statusCode == 200) {
        WorkoutsPlanModel workoutsPlanModel =
            WorkoutsPlanModel.fromJson(response.data);
        workoutsPlan = workoutsPlanModel.exercisesForDays;
        try {
          String userEncoded = json.encode(workoutsPlanModel.toJson());
          String cacheKey =
              '${AppConstants.authRepository.user.id}-workout-plan';
          await AppConstants.box.put(cacheKey, userEncoded);
          defaultSuccessSnackBar(
            context: navigatorKey.currentContext!,
            message: "Cached successfully",
          );
        } catch (e) {
          defaultErrorSnackBar(
            context: navigatorKey.currentContext!,
            message: "Failed to cache data",
          );
        }
      } else {
        throw response.data['error'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
