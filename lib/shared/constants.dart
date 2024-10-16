import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym/services/repos/auth_repo.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../services/repos/workouts_repo.dart';

class AppConstants {
  static final WorkoutsRepository workoutsRepository = WorkoutsRepository();
  static final AuthRepository authRepository = AuthRepository();

  static late Box box;

  static File? profilePicture;

  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);

  static bool isFirstTime = true;

  static TextTheme textTheme(BuildContext context) =>
      Theme.of(context).textTheme;

  bool checkEmailValidation(String email) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);

  static EdgeInsets edge({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    final parts = Intl.getCurrentLocale().split('_');
    final locale = Locale(parts.first, parts.last);

    return locale.languageCode == 'en'
        ? EdgeInsets.only(
            left: left,
            right: right,
            top: top,
            bottom: bottom,
          )
        : EdgeInsets.only(
            left: right,
            right: left,
            top: top,
            bottom: bottom,
          );
  }
}
