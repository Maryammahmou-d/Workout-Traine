part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class GetChatLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class GetChatSuccessState extends HomeState {
  @override
  List<Object> get props => [];
}

class GetChatErrorState extends HomeState {
  final String errMsg;

  const GetChatErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class SendMessageLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class SendMessageSuccessState extends HomeState {
  final String message;

  const SendMessageSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class SendMessageErrorState extends HomeState {
  final String errMsg;

  const SendMessageErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class UpdateProfilePicture extends HomeState {
  @override
  List<Object> get props => [];
}

