// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../services/repos/auth_repo.dart';
import '../../shared/constants.dart';
import '../../shared/enums.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<ChangePassVisibilityEvent>(mapChangePassVisibilityEventToState);
  }

  final FocusNode usernameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passNode = FocusNode();
  final FocusNode phoneNode = FocusNode();

  TextFieldValidation emailValidationState = TextFieldValidation.normal;
  TextFieldValidation passValidationState = TextFieldValidation.normal;
  TextFieldValidation userNameValidationState = TextFieldValidation.normal;
  TextFieldValidation phoneValidationState = TextFieldValidation.normal;

  late TextEditingController passwordController = TextEditingController(),
      emailController = TextEditingController(),
      usernameController = TextEditingController(),
      phoneController = TextEditingController();

  bool isPassVisible = false;

  void mapChangePassVisibilityEventToState(
    ChangePassVisibilityEvent event,
    Emitter<SignUpState> emit,
  ) {
    isPassVisible = !isPassVisible;
    emit(PasswordVisibilityState(isPassVisible));
  }

  void isValidEmail({
    required String email,
  }) {
    if (AppConstants().checkEmailValidation(email)) {
      emailValidationState = TextFieldValidation.valid;
    } else {
      emailValidationState = TextFieldValidation.notValid;
    }
    emit(EmailValidationState(emailValidationState));
  }

  void isValidUsername({
    required String username,
  }) {
    if (username.length >= 3) {
      userNameValidationState = TextFieldValidation.valid;
    } else {
      userNameValidationState = TextFieldValidation.notValid;
    }
    emit(UserNameValidationState(userNameValidationState));
  }

  void isValidPassword({
    required String password,
  }) {
    if (password.length >= 8) {
      passValidationState = TextFieldValidation.valid;
    } else {
      passValidationState = TextFieldValidation.notValid;
    }
    emit(PasswordValidationState(passValidationState));
  }

  void isPhoneValid({
    required String phoneNumber,
  }) {
    phoneController.clear();
    if (phoneNumber.isNotEmpty) {
      phoneController.text = phoneNumber;
      phoneValidationState = TextFieldValidation.valid;
    } else {
      phoneValidationState = TextFieldValidation.notValid;
    }
    emit(PhoneValidationState(phoneValidationState));
  }

  // ?  =======  SingUP =======

  Future<void> mapSingUPEventToState(SignUpUserEvent event) async {
    emit(const SignUpLoadingState());
    try {
      Response res = await AuthRepository.signUp(
        username: event.username,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );
      if (res.statusCode == 201) {
        emit(SignUpSuccessState(
          res.data['user_id'].toString(),
          res.data['access_token'],
        ));
      } else {
        emit(SignUpErrorState(res));
      }
    } catch (e) {
      emit(SignUpErrorState(e as Response));
    }
  }
}
