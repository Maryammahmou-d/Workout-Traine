import 'package:equatable/equatable.dart';
import 'package:gym/models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileSuccessState extends ProfileState {
  final UserModel userModel;

  const GetProfileSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class GetProfileErrorState extends ProfileState {
  final String error;

  const GetProfileErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GetProfileLoadingState extends ProfileState {
  const GetProfileLoadingState();

  @override
  List<Object> get props => [];
}

class UploadProfilePictureSuccessState extends ProfileState {
  @override
  List<Object> get props => [];
}

class UploadProfilePictureErrorState extends ProfileState {
  final String error;

  const UploadProfilePictureErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadProfilePictureLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}
class DeleteUserAccountLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}
class DeleteUserAccountSuccessState extends ProfileState {
  final String uId;

  const DeleteUserAccountSuccessState(this.uId);
  @override
  List<Object> get props => [uId];
}

class DeleteUserAccountErrorState extends ProfileState {
  final String errMsg;

  const DeleteUserAccountErrorState(this.errMsg);
  @override
  List<Object> get props => [];
}
