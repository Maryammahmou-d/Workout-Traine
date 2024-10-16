import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym/shared/extentions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/track_weight_reps.dart';
import '../../models/workout_details_model.dart';
import '../../models/workouts_plan_model.dart';
import '../../services/dio_helper.dart';
import '../../shared/constants.dart';
import '../../shared/widgets/snack_bar_widget.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(TrackingInitial());
  DateTime selectedDay = DateTime.now();
  List<TrackWorkout> selectedWorkouts = [];

  Future<void> loadSelectedWorkouts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> selectedWorkoutsJson = prefs.getStringList(
            'selectedWorkouts_${DateFormat("dd-MM-yyyy").format(selectedDay).toString()}') ??
        [];

    selectedWorkouts = selectedWorkoutsJson.map((json) {
      final Map<String, dynamic> workoutJson = jsonDecode(json);
      return TrackWorkout.fromJson(workoutJson);
    }).toList();

    emit(SelectWorkoutsState());
  }

  Future<void> saveSelectedWorkouts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> selectedWorkoutsJson = selectedWorkouts.map((workout) {
      final Map<String, dynamic> workoutJson = workout.toJson();
      return jsonEncode(workoutJson);
    }).toList();
    await prefs.setStringList(
        'selectedWorkouts_${DateFormat("dd-MM-yyyy").format(selectedDay).toString()}',
        selectedWorkoutsJson);
  }

  void selectDate(DateTime date) {
    selectedDay = date;
    selectedWorkouts = [];
    emit(ChangeSelectedDayState(date));
    loadSelectedWorkouts();
  }

  void selectWorkouts(
    List<ExerciseModel> workout, {
    bool isInitial = true,
  }) {
    selectedWorkouts = [];
    for (ExerciseModel i in workout) {
      selectedWorkouts.add(
        TrackWorkout(
          title: i.title,
          isOpen: false,
          lbsAndReps: [LbsAndRepsModel(0, 0)],
        ),
      );
    }
    emit(SelectWorkoutsState());
    saveSelectedWorkouts();
  }

  void changeWorkoutOpenState(int index) {
    selectedWorkouts[index].isOpen = !selectedWorkouts[index].isOpen;
    emit(ChangeWorkoutOpeningState(index, selectedWorkouts[index].isOpen));
  }

  void changeIsWorkoutSetDoneValue(int index, int repsIndex) {
    selectedWorkouts[index].lbsAndReps[repsIndex].isDone =
        !selectedWorkouts[index].lbsAndReps[repsIndex].isDone;
    emit(
      ChangeWorkoutOpeningState(
        index,
        selectedWorkouts[index].lbsAndReps[repsIndex].isDone,
      ),
    );
  }

  void editSet({
    required int workoutIndex,
    required int index,
    int? lbs,
    int? reps,
  }) {
    if (lbs != null) {
      selectedWorkouts[workoutIndex].lbsAndReps[index].lbs = lbs;
    } else if (reps != null) {
      selectedWorkouts[workoutIndex].lbsAndReps[index].reps = reps;
    }

    emit(AddNewSetState());
    saveSelectedWorkouts();
  }

  addNewSet(int index) {
    selectedWorkouts[index].lbsAndReps.add(LbsAndRepsModel(0, 0));
    emit(AddNewSetState());
  }

  void deleteSet(int index) {
    selectedWorkouts[index].lbsAndReps.removeLast();
    emit(DeleteSetState());
    saveSelectedWorkouts();
  }

  void uploadToApi(BuildContext context) async {
    emit(UploadTrackToApiLoadingState());
    try {
      Map<String, dynamic> body = <String, dynamic>{};
      for (var i in selectedWorkouts) {
        body.addAll({
          "day": DateFormat('dd-MM-yyyy').format(selectedDay),
          "user_id": AppConstants.authRepository.user.id,
          i.title: i.lbsAndReps.map((e) => e.toJson()).toList(),
        });
      }
      Response response = await DioHelper.postData(
        endpoint: 'auth/track/store',
        body: body,
      );
      if (response.statusCode == 200) {
        successSnackBar(
          context: context,
          message: "weightsUploadedSuccessfully".getLocale(context),
        );
        emit(UploadTrackToApiSuccessState());
      } else {
        errorSnackBar(
          context: context,
          message: response.data['message'],
        );
        emit(UploadTrackToApiErrorState(response.data['message']));
      }
    } catch (e) {
      errorSnackBar(
        context: context,
        message: e.toString(),
      );
      emit(UploadTrackToApiErrorState(e.toString()));
    }
  }
}
