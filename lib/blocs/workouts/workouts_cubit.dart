import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:gym/shared/constants.dart';
import '../../models/workouts_plan_model.dart';

part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit() : super(WorkoutsInitial());

  Map<String, List<ExerciseModel>> workoutsPlan = {};
  int currentVideoIndex = 0;
  List<String> completedDays = [];

  void gettingWorkoutsPlan({bool isRefreshPlans = false}) async {
    emit(GettingWorkoutsPlanLoadingState());

    try {
      if (isRefreshPlans) {
        await AppConstants.workoutsRepository
            .getWorkoutsPlan(userId: AppConstants.authRepository.user.id);
      } else {
        completedDays =
            AppConstants.box.get("completedDays", defaultValue: <String>[]);
        if (AppConstants.workoutsRepository.workoutsPlan.isEmpty) {
          await AppConstants.workoutsRepository
              .getWorkoutsPlanFromCache(isForceRefresh: isRefreshPlans);
        }
      }
      workoutsPlan = AppConstants.workoutsRepository.workoutsPlan;
      emit(GettingWorkoutsPlanSuccessState());
    } catch (e) {
      await AppConstants.workoutsRepository
          .getWorkoutsPlan(userId: AppConstants.authRepository.user.id);
      emit(GettingWorkoutsPlanErrorState(e.toString()));
    }
  }

  void changeVideoIndexState(int index) {
    currentVideoIndex = index;
    emit(ChangeVideoIndexState(currentVideoIndex));
  }

  Map<String, List<String>> allVideoLinksPerDay = {};

  void getVideoLinksSeparately() {
    emit(GettingVideoLinksLoadingState());

    workoutsPlan.forEach((day, exercises) {
      List<String> videoLinks = [];
      for (var exercise in exercises) {
        videoLinks.add(exercise.video1);
        videoLinks.add(exercise.video2);
        videoLinks.add(exercise.video3);
      }

      allVideoLinksPerDay[day] = videoLinks;
    });
    emit(GettingWorkoutsPlanSuccessState());
  }

  void downloadAllDaysVideos() async {
    emit(GettingAllDaysVideosLoadingState());
    for (int i = 0; i < allVideoLinksPerDay.entries.length; i++) {
      await cacheAllVideos(allVideoLinksPerDay.entries.elementAt(i).value,
          allVideoLinksPerDay.entries.elementAt(i).key);
    }
    emit(GettingAllDaysVideosSuccessState());
  }

  Future<void> cacheAllVideos(List<String> links, String day) async {
    emit(GettingAllVideosFromCacheLoadingState(day));
    for (int i = 0; i < links.length; i++) {
      await _downloadAndCacheVideo(links[i], i, day);
    }
    completedDays.add(day);
    await AppConstants.box.put("completedDays", completedDays);
    emit(GettingAllVideosFromCacheSuccessState(day));
  }

  int currentDownloadingIndex = 0;

  Future<void> _downloadAndCacheVideo(
      String videoUrl, int index, String day) async {
    String cacheKey = videoUrl;
    bool isVideoCached = AppConstants.box.containsKey(cacheKey);

    if (!isVideoCached) {
      try {
        String filePath = "";
        if (Platform.isIOS) {
          List<Directory>? directories = await getExternalStorageDirectories(
              type: StorageDirectory.downloads);
          filePath = directories?.first.path ?? "";
          if (filePath.isEmpty) {
            final Directory appDocDir =
                await getApplicationDocumentsDirectory();
            filePath = '${appDocDir.path}/${videoUrl.split('/').last}';
          }
        } else {
          final Directory appDocDir = await getApplicationDocumentsDirectory();
          filePath = '${appDocDir.path}/${videoUrl.split('/').last}';
        }

        final response = await http.get(Uri.parse(videoUrl));
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await AppConstants.box.put(cacheKey, filePath);

        currentDownloadingIndex = index + 1;
        emit(CachedDayVideoState(index, day));
        if (kDebugMode) {
          print("Finished caching $videoUrl");
        }
      } catch (error) {
        if (kDebugMode) {
          print("Error downloading and caching video: $error");
        }
      }
    } else {
      currentDownloadingIndex = index + 1;
      emit(CachedDayVideoState(index, day));
    }
  }
}
