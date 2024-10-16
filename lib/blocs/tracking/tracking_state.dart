part of 'tracking_cubit.dart';

@immutable
abstract class TrackingState {}

class TrackingInitial extends TrackingState {}
class SelectWorkoutsState extends TrackingState {}

class ChangeSelectedDayState extends TrackingState {
  final DateTime date;

  ChangeSelectedDayState(this.date);
}

class ChangeWorkoutOpeningState extends TrackingState {
  final int index;
  final bool isOpen;

  ChangeWorkoutOpeningState(this.index, this.isOpen);
}

class ChangeSetDoneState extends TrackingState {
  final int index;
  final bool isDone;

  ChangeSetDoneState(this.index, this.isDone);
}

class AddNewSetState extends TrackingState {}

class DeleteSetState extends TrackingState {}

class UploadTrackToApiLoadingState extends TrackingState {}
class UploadTrackToApiSuccessState extends TrackingState {}
class UploadTrackToApiErrorState extends TrackingState {
  final String errMsg;

  UploadTrackToApiErrorState(this.errMsg);
}

