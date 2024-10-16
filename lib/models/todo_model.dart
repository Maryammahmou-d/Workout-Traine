import 'dart:convert';

import 'package:flutter/material.dart';

class Todo {
  final String name;
  final String localeName;
  final String apiKey;
  final TodoIcon icon;
  final DateTime dateTime;
  final bool isEditable;
  final bool isTimeValue;
  String? iconPath;
  String? editableHint;
  bool isDone;
  double progress;
  double target;
  String picPath;
  List<Subtask> subtasks;

  Todo({
    required this.name,
    required this.localeName,
    required this.icon,
    required this.apiKey,
    required this.dateTime,
    this.isDone = false,
    this.isTimeValue = false,
    this.isEditable = false,
    this.progress = 0.0,
    this.target = 0.0,
    this.picPath = '',
    this.editableHint = '',
    this.subtasks = const [],
    this.iconPath,
  });

  String toJsonString() {
    final Map<String, dynamic> json = {
      'name': name,
      'localeName': localeName,
      'icon': icon.index,
      'isDone': isDone,
      'isEditable': isEditable,
      'isTimeValue': isTimeValue,
      'iconPath': iconPath,
      'progress': progress,
      'target': target,
      'picPath': picPath,
      ' editableHint': editableHint,
      'dateTime': dateTime.toString(),
      'apiKey': apiKey,
      'subtasks': subtasks.map((subtask) => subtask.toJsonString()).toList(),
    };
    return jsonEncode(json);
  }

  factory Todo.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Todo(
      name: json['name'],
      localeName: json['localeName'],
      icon: TodoIcon.values[json['icon']],
      isDone: json['isDone'],
      isEditable: json['isEditable'],
      isTimeValue: json['isTimeValue'],
      progress: json['progress'],
      target: json['target'],
      iconPath: json['iconPath'],
      picPath: json['picPath'],
      editableHint: json[' editableHint'],
      dateTime: json['dateTime'] is String
          ? DateTime.parse(json['dateTime'])
          : json['dateTime'],
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((subtaskJson) => Subtask.fromJson(subtaskJson))
              .toList() ??
          [],
      apiKey: json['apiKey'],
    );
  }
}

class Subtask {
  final String name;
  final String localeName;
  final String picPath;
  bool isDone;

  Subtask({
    required this.name,
    required this.localeName,
    required this.picPath,
    this.isDone = false,
  });

  String toJsonString() {
    final Map<String, dynamic> json = {
      'name': name,
      'localeName': localeName,
      'picPath': picPath,
      'isDone': isDone,
    };
    return jsonEncode(json);
  }

  factory Subtask.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Subtask(
      name: json['name'],
      localeName: json['localeName'],
      picPath: json['picPath'],
      isDone: json['isDone'],
    );
  }
}

enum TodoIcon { workout, restaurant, water, other }

IconData getIconData(TodoIcon icon) {
  switch (icon) {
    case TodoIcon.workout:
      return Icons.fitness_center;
    case TodoIcon.restaurant:
      return Icons.restaurant;
    case TodoIcon.water:
      return Icons.water_drop_outlined;
    case TodoIcon.other:
      return Icons.alarm;
  }
}
