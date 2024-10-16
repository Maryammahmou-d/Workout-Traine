import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

Widget defaultSnackBar({
  required BuildContext context,
  required message,
  required backgroundColor,
  required borderColor,
  Duration? duration,
  title,
  void Function()? onTap,
}) {
  return Flushbar(
    message: message,
    messageColor: AppColors.white,
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    titleColor: AppColors.white,
    shouldIconPulse: false,
    borderRadius: const BorderRadius.all(
      Radius.circular(12),
    ),
    margin: const EdgeInsets.only(
      top: 8,
      left: 20,
      right: 20,
    ),
    duration: const Duration(seconds: 2),
  )..show(context);
}

Widget errorSnackBar({
  required BuildContext context,
  required message,
  title,
}) {
  return defaultSnackBar(
    context: context,
    message: message,
    duration: const Duration(seconds: 6),
    title: title,
    onTap: () {},
    borderColor: AppColors.red,
    backgroundColor: AppColors.red,
  );
}

Widget successSnackBar({
  required BuildContext context,
  required message,
  title,
  void Function()? onTap,
}) {
  return defaultSnackBar(
    context: context,
    message: message,
    title: title,
    onTap: onTap,
    borderColor: Colors.green,
    backgroundColor: Colors.green,
  );
}
