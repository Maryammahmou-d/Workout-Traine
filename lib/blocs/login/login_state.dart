part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class PasswordVisibilityState extends LoginState {
  final bool isPassVisible;
  const PasswordVisibilityState(this.isPassVisible);
  @override
  List<Object> get props => [isPassVisible];
}

class EmailValidationState extends LoginState {
  final TextFieldValidation emailState;
  const EmailValidationState(this.emailState);
  @override
  List<Object> get props => [emailState];
}

class PasswordValidationState extends LoginState {
  final TextFieldValidation passState;
  const PasswordValidationState(this.passState);
  @override
  List<Object> get props => [passState];
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
  @override
  List<Object> get props => [];
}

class LoginErrorState extends LoginState {
  final String error;
  const LoginErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
  @override
  List<Object> get props => [];
}

class ResetPasswordLoadingState extends LoginState {
  const ResetPasswordLoadingState();
  @override
  List<Object> get props => [];
}

class ResetPasswordErrorState extends LoginState {
  final String error;
  const ResetPasswordErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class ResetPasswordSuccessState extends LoginState {
  const ResetPasswordSuccessState();
  @override
  List<Object> get props => [];
}
