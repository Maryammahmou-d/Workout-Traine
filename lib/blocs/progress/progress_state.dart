part of 'progress_cubit.dart';

@immutable
abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class GetUserVideosLoadingState extends ProgressState {}

class GetUserVideosSuccessState extends ProgressState {}

class GetUserVideosErrorState extends ProgressState {
  final String errMsg;

  GetUserVideosErrorState(this.errMsg);
}

class UploadUserVideosLoadingState extends ProgressState {}

class UploadUserVideosSuccessState extends ProgressState {}

class UploadUserVideosErrorState extends ProgressState {
  final String errMsg;

  UploadUserVideosErrorState(this.errMsg);
}

class GetUserImagesLoadingState extends ProgressState {}

class GetUserImagesSuccessState extends ProgressState {}

class GetUserImagesErrorState extends ProgressState {
  final String errMsg;

  GetUserImagesErrorState(this.errMsg);
}

class UploadUserImagesLoadingState extends ProgressState {}

class UploadUserImagesSuccessState extends ProgressState {}

class UploadUserImagesErrorState extends ProgressState {
  final String errMsg;

  UploadUserImagesErrorState(this.errMsg);
}

class ChangeToggleIndexValueState extends ProgressState {
  final int index;

  ChangeToggleIndexValueState(this.index);
}

class UploadMeasurementsLoadingState extends ProgressState {}

class UploadMeasurementsSuccessState extends ProgressState {}

class UploadMeasurementsErrorState extends ProgressState {
  final String errMsg;

  UploadMeasurementsErrorState(this.errMsg);
}

class ChangeMealToAlternativeState extends ProgressState {
  final String mealId;
  final String alternativeMealId;

  ChangeMealToAlternativeState(
    this.mealId,
    this.alternativeMealId,
  );
}
