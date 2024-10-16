part of 'workouts_cubit.dart';

@immutable
abstract class WorkoutsState {}

class WorkoutsInitial extends WorkoutsState {}

class GettingWorkoutsPlanLoadingState extends WorkoutsState {}

class GettingWorkoutsPlanSuccessState extends WorkoutsState {}

class GettingWorkoutsPlanErrorState extends WorkoutsState {
  final String errMsg;

  GettingWorkoutsPlanErrorState(this.errMsg);
}

class ChangeVideoIndexState extends WorkoutsState {
  final int currentIndex;

  ChangeVideoIndexState(this.currentIndex);
}

class GettingVideoLinksLoadingState extends WorkoutsState {}

class GettingVideoLinksSuccessState extends WorkoutsState {}

class GettingAllVideosFromCacheLoadingState extends WorkoutsState {
  final String day;

  GettingAllVideosFromCacheLoadingState(this.day);
}

class GettingAllVideosFromCacheSuccessState extends WorkoutsState {
  final String day;

  GettingAllVideosFromCacheSuccessState(this.day);
}


class GettingAllDaysVideosLoadingState extends WorkoutsState {

  GettingAllDaysVideosLoadingState();
}

class GettingAllDaysVideosSuccessState extends WorkoutsState {

  GettingAllDaysVideosSuccessState();
}


class CachedDayVideoState extends WorkoutsState {
  final int index;
  final String day;

  CachedDayVideoState(this.index , this.day);
}
