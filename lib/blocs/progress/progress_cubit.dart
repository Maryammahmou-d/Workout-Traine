import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/models/progress_model.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../services/dio_helper.dart';
import '../../shared/constants.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());

  late TextEditingController chestController = TextEditingController(),
      waistController = TextEditingController(),
      thighController = TextEditingController(),
      armController = TextEditingController(),
      hipsController = TextEditingController();

  int toggleIndex = 0;

  void changeToggleIndexValue(int index) {
    toggleIndex = index;
    emit(ChangeToggleIndexValueState(index));
  }

  void clearMeasurementsControllers() {
    chestController.clear();
    waistController.clear();
    thighController.clear();
    armController.clear();
    hipsController.clear();
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File selectedImage = File(pickedImage.path);
      if (context.mounted) {
        uploadImageProgress(
          context: context,
          userId: AppConstants.authRepository.user.id,
          imageFile: selectedImage,
        );
      }
    }
  }

  Future<void> uploadImageProgress({
    required BuildContext context,
    required String userId,
    required File imageFile,
  }) async {
    emit(UploadUserImagesLoadingState());
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'user_id': AppConstants.authRepository.user.id,
      });
      Response response = await DioHelper.postData(
        endpoint: 'auth/myprogress-images/store',
        body: {},
        formData: formData,
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: "imageUploaded".getLocale(context),
          );
        }
        if (context.mounted) {
          getUserImagesProgress(
            context: context,
            userId: AppConstants.authRepository.user.id,
          );
        }
        emit(UploadUserImagesSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }

        emit(UploadUserImagesErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }

      emit(UploadUserImagesErrorState(e.toString()));
    }
  }

  List<ProgressModel> userImages = [];

  Future<void> getUserImagesProgress({
    required BuildContext context,
    required String userId,
  }) async {
    emit(GetUserImagesLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: "auth/myprogress-images/get?user_id=${AppConstants.authRepository.user.id}",
      );
      if (response.statusCode == 200) {
        userImages = List<ProgressModel>.from(
            response.data.map((json) => ProgressModel.fromJson(json)).toList());

        emit(GetUserImagesSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(GetUserImagesErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(GetUserImagesErrorState(e.toString()));
    }
  }

  Future<void> pickVideoFromGallery(BuildContext context) async {
    final videoPicker = ImagePicker();
    final pickedVideo =
        await videoPicker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      File selectedVideo = File(pickedVideo.path);
      if (context.mounted) {
        uploadVideoProgress(
          context: context,
          userId: AppConstants.authRepository.user.id,
          videoFile: selectedVideo,
        );
      }
    }
  }

  List<ProgressModel> userVideos = [];

  Future<void> getUserVideosProgress({
    required BuildContext context,
    required String userId,
  }) async {
    emit(GetUserVideosLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: "auth/myprogress-videos/get?user_id=${AppConstants.authRepository.user.id}",
      );
      if (response.statusCode == 200) {
        userVideos = List<ProgressModel>.from(response.data
            .map((json) => ProgressModel.fromJson(json, isVideo: true))
            .toList());
        emit(GetUserVideosSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(GetUserVideosErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(GetUserVideosErrorState(e.toString()));
    }
  }

  Future<void> uploadVideoProgress({
    required BuildContext context,
    required String userId,
    required File videoFile,
  }) async {
    emit(UploadUserVideosLoadingState());
    try {
      String fileName = videoFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "video":
            await MultipartFile.fromFile(videoFile.path, filename: fileName),
        'user_id': AppConstants.authRepository.user.id,
      });
      Response response = await DioHelper.postData(
        endpoint: 'auth/myprogress-videos/store',
        body: {},
        formData: formData,
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: "videoUploaded".getLocale(context),
          );
        }
        if (context.mounted) {
          getUserVideosProgress(context: context, userId: AppConstants.authRepository.user.id);
        }

        emit(UploadUserVideosSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(UploadUserVideosErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(UploadUserVideosErrorState(e.toString()));
    }
  }

  Future<void> uploadMeasurementsProgress({
    required BuildContext context,
    required String userId,
    required double chest,
    required double waist,
    required double thigh,
    required double arm,
    required double hips,
  }) async {
    emit(UploadMeasurementsLoadingState());
    try {
      Response response = await DioHelper.postData(
        endpoint: "auth/measurements/store",
        body: {
          "user_id": AppConstants.authRepository.user.id,
          "chest": chest,
          "waist": waist,
          "thigh": thigh,
          "arm": arm,
          "hips": hips,
          "date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
        },
      );
      if (response.statusCode == 200) {
        clearMeasurementsControllers();
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: "measurementsUploaded".getLocale(context),
          );
        }
        emit(UploadMeasurementsSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(UploadMeasurementsErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }

      emit(UploadMeasurementsErrorState(e.toString()));
    }
  }

  void changeMealToAlternative({
    required String mealId,
    required String alternativeId,
  }) {
    emit(ChangeMealToAlternativeState(mealId, alternativeId));
  }
}
