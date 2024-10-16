part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class PasswordVisibilityState extends SignUpState {
  final bool isPassVisible;
  const PasswordVisibilityState(this.isPassVisible);
  @override
  List<Object> get props => [isPassVisible];
}

class EmailValidationState extends SignUpState {
  final TextFieldValidation emailState;
  const EmailValidationState(this.emailState);
  @override
  List<Object> get props => [emailState];
}

class UserNameValidationState extends SignUpState {
  final TextFieldValidation userName;
  const UserNameValidationState(this.userName);
  @override
  List<Object> get props => [userName];
}

class PasswordValidationState extends SignUpState {
  final TextFieldValidation passState;
  const PasswordValidationState(this.passState);
  @override
  List<Object> get props => [passState];
}

class PhoneValidationState extends SignUpState {
  final TextFieldValidation phoneState;
  const PhoneValidationState(this.phoneState);
  @override
  List<Object> get props => [phoneState];
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState();
  @override
  List<Object> get props => [];
}

class SignUpErrorState extends SignUpState {
  final Response response;
  const SignUpErrorState(this.response);
  @override
  List<Object> get props => [response];
}

class SignUpSuccessState extends SignUpState {
  final String userId;
  final String token;
  const SignUpSuccessState(this.userId, this.token);
  @override
  List<Object> get props => [userId,token];
}
