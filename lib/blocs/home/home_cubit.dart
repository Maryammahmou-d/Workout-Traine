import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gym/models/chat_model.dart';

import '../../services/dio_helper.dart';
import '../../shared/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final TextEditingController messageController = TextEditingController();
  List<ChatModel> messages = [];
  File? profilePicture;
  void updateProfilePicture(File newProfilePicture){
    profilePicture = newProfilePicture;
    emit(UpdateProfilePicture());
  }
  void getMessages() async {
    emit(GetChatLoadingState());
    try {
      Response response = await DioHelper.getData(
        endpoint: 'auth/chat/get',
        body: {"id": AppConstants.authRepository.user.id},
      );
      if (response.statusCode == 200) {
        messages = (response.data['chats'] as List)
            .map((e) => ChatModel.fromJson(e))
            .toList()
            .reversed
            .toList();
        emit(GetChatSuccessState());
      } else {
        emit(GetChatErrorState(errMsg: response.data['message']));
      }
    } catch (e) {
      emit(GetChatErrorState(errMsg: e.toString()));
    }
  }

  void sendMessage(String message) async {
    emit(SendMessageLoadingState());
    try {
      Response response = await DioHelper.postData(
        endpoint: 'auth/chat/send',
        body: {
          "id": AppConstants.authRepository.user.id,
          "receiver_id": 1,
          "message": message,
        },
      );
      if (response.statusCode == 200) {
        Random random = Random();
        int randomNumber = random.nextInt(900000) + 100000;

        messages.add(ChatModel(
          createdAt: '',
          id: randomNumber,
          senderId: AppConstants.authRepository.user.id,
          receiver: null,
          updatedAt: '',
          message: message,
        ));
        messageController.clear();
        emit(SendMessageSuccessState(message: message));
        getMessages();
      } else {
        emit(SendMessageErrorState(errMsg: response.data['message']));
      }
    } catch (e) {
      emit(SendMessageErrorState(errMsg: e.toString()));
    }
  }
}
