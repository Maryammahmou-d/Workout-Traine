// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../shared/constants.dart';
import '../../shared/enums.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  bool isPassVisible = false;

  final FocusNode userNameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passNode = FocusNode();

  TextFieldValidation emailValidationState = TextFieldValidation.normal;
  TextFieldValidation passValidationState = TextFieldValidation.normal;

  late TextEditingController passwordController = TextEditingController(),
      emailController = TextEditingController();

  void changePassVisibility() {
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

  void isValidPassword({
    required String password,
  }) {
    if (password.isNotEmpty) {
      passValidationState = TextFieldValidation.valid;
    } else {
      passValidationState = TextFieldValidation.notValid;
    }
    emit(PasswordValidationState(passValidationState));
  }

  // ?  =======  Login =======

  Future<void> mapLoginEventToState(
    final String email,
    final String password,
  ) async {
    emit(const LoginLoadingState());
    var res = await AppConstants.authRepository.login(
      password: password,
      email: email,
    );
    if (res is bool && res) {
      emit(const LoginSuccessState());
    } else if (res is String) {
      emit(LoginErrorState(res.toString()));
    }
  }

  void resetPassword(String email) async {
    emit(const ResetPasswordLoadingState());
    var res = await AppConstants.authRepository.resetPassword(
      email: email,
    );
    if (res is bool && res) {
      emit(const ResetPasswordSuccessState());
    } else if (res is String) {
      emit(ResetPasswordErrorState(res.toString()));
    }
  }
}
