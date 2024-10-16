part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class ChangePassVisibilityEvent extends SignUpEvent {
  const ChangePassVisibilityEvent();
  @override
  List<Object> get props => [];
}

class SignUpUserEvent extends SignUpEvent {
  final String username;
  final String email;
  final String password;
  final String phone;
  const SignUpUserEvent(
    this.username,
    this.email,
    this.password,
    this.phone,
  );
  @override
  List<Object> get props => [username, email, password,phone];
}
