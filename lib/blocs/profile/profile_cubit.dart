import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/blocs/profile/profile_state.dart';
import 'package:gym/services/local_storage/cache_helper.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/dio_helper.dart';
import '../../shared/widgets/snackbar.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUser() async {
    emit(const GetProfileLoadingState());
    try {
      await AppConstants.authRepository.getUser();
      emit(GetProfileSuccessState(userModel: AppConstants.authRepository.user));
    } catch (e) {
      emit(GetProfileErrorState(error: e.toString()));
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File selectedImage = File(pickedImage.path);
      if (context.mounted) {
        uploadProfilePicture(
          context: context,
          userId: AppConstants.authRepository.user.id,
          imageFile: selectedImage,
        );
      }
    }
  }

  Future<void> uploadProfilePicture({
    required BuildContext context,
    required String userId,
    required File imageFile,
  }) async {
    emit(UploadProfilePictureLoadingState());
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "profile_photo_path":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });
      Response response = await DioHelper.postData(
        endpoint:
            'auth/questionnaires/${AppConstants.authRepository.user.id}/update',
        body: {},
        formData: formData,
      );
      if (response.statusCode == 200) {
        AppConstants.profilePicture = imageFile;
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: "imageUploaded".getLocale(context),
          );
        }
        emit(UploadProfilePictureSuccessState());
        getUser();
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }

        emit(UploadProfilePictureErrorState(error: response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }

      emit(UploadProfilePictureErrorState(error: e.toString()));
    }
  }

  Future<void> deleteUser() async {
    emit(DeleteUserAccountLoadingState());
    String uId = AppConstants.authRepository.user.id;

    try {
      Response response =
          await DioHelper.postData(endpoint: 'auth/user/delete', body: {
        "id": uId,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        await CacheHelper.clearAll();
        await AppConstants.box.clear();
        emit(DeleteUserAccountSuccessState(uId));
      } else {
        emit(DeleteUserAccountErrorState(response.data['message']));
      }
    } catch (e) {
      emit(DeleteUserAccountErrorState(e.toString()));
    }
  }
}
