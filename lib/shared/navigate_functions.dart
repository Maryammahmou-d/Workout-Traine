import 'package:flutter/material.dart';

class Navigate {
  Navigate({
    required this.context,
    required this.screen,
  });
  final BuildContext context;
  final Widget screen;

  Future to({
    Widget? replaceScreen,
    BuildContext? contextReplace,
  }) {
    return Navigator.push(
      (contextReplace ?? context),
      MaterialPageRoute(
        builder: (context) => replaceScreen ?? screen,
      ),
    );
  }

  Future off({
    Widget? replaceScreen,
    BuildContext? contextReplace,
  }) {
    return Navigator.pushReplacement(
      (contextReplace ?? context),
      MaterialPageRoute(
        builder: (context) => replaceScreen ?? screen,
      ),
    );
  }

  Future offAll({
    Widget? replaceScreen,
    BuildContext? contextReplace,
  }) {
    return Navigator.of(contextReplace ?? context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => replaceScreen ?? screen,
        ),
            (Route<dynamic> route) => false);
  }
}
