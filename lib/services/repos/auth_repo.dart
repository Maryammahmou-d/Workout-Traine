import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gym/models/user_model.dart';
import 'package:gym/services/dio_helper.dart';
import 'package:gym/services/local_storage/cache_helper.dart';

class AuthRepository {
  UserModel user = UserModel.emptyUser();

  void getInitialUserValue(UserModel? cachedUser) {
    if (cachedUser != null) {
      user = cachedUser;
      getUser();
    }
  }

  Future<dynamic> login({
    required String password,
    required String email,
  }) async {
    try {
      Response response = await DioHelper.postData(
        endpoint: 'auth/login',
        body: {
          "password": password,
          "email": email,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await CacheHelper.setData(
            key: 'token', value: response.data['access_token']);
        user = UserModel.fromJson(response.data["user"]);
        String userEncoded = json.encode(user.toJson());
        await CacheHelper.setData(
          key: 'user',
          value: userEncoded,
        );
        return true;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> resetPassword({
    required String email,
  }) async {
    try {
      Response response = await DioHelper.postData(
        endpoint: 'auth/reset-pass',
        body: {
          "email": email,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> getUser() async {
    try {
      Response response = await DioHelper.getData(
        endpoint: 'auth/user',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        user = UserModel.fromJson(response.data);
        String userEncoded = json.encode(user.toJson());
        await CacheHelper.setData(
          key: 'user',
          value: userEncoded,
        );
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<Response> signUp({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      Response response = await DioHelper.postData(
        endpoint: 'auth/register',
        body: {
          "name": username,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 422) {
        throw response;
      } else {
        throw response;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
