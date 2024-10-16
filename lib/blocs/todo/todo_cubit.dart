import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/snack_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/todo_model.dart';
import '../../services/dio_helper.dart';
import '../../shared/constants.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  DateTime selectedDay = DateTime.now();
  List<Todo> todos = [];
  List<Todo> currentDisplayTodo = [];

  void selectDate(DateTime date) {
    selectedDay = date;
    changeCurrentList();
    emit(ChangeSelectedDayState(date));
  }

  void changeCurrentList() {
    currentDisplayTodo = todos.where((element) {
      return element.dateTime.day == selectedDay.day &&
          element.dateTime.month == selectedDay.month &&
          element.dateTime.year == selectedDay.year;
    }).toList();
    emit(ChangeCurrentListState(selectedDay, currentDisplayTodo));
  }

  bool isTodayInTheList = false;
  Future<void> loadTodos(BuildContext context) async {
    emit(LoadTodoListState());
    isTodayInTheList = false;
    final prefs = await SharedPreferences.getInstance();
    final stringTodoList = prefs.getStringList('todos') ?? [];

    todos.clear();

    for (final json in stringTodoList) {
      try {
        final todo = Todo.fromJson(json);
        todos.add(todo);
        if (todo.dateTime.day == DateTime.now().day &&
            todo.dateTime.month == DateTime.now().month &&
            todo.dateTime.year == DateTime.now().year) {}
        List<Todo> today = todos.where((element) {
          return element.dateTime.day == DateTime.now().day &&
              element.dateTime.month == DateTime.now().month &&
              element.dateTime.year == DateTime.now().year;
        }).toList();

        for (Todo task in today) {
          if (task.name.toLowerCase().contains("water") ||
              task.name.toLowerCase().contains("workouts")) {
            isTodayInTheList = true;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading todo: $e');
        }
      }
    }
    if (!isTodayInTheList) {
      addTodo(
        Todo(
          name: "Wake up",
          localeName: "wakeUp",
          apiKey: "wake",
          isEditable: true,
          isTimeValue: true,
          editableHint: "pickWakeUpTime",
          iconPath: "assets/images/icons/wakeup.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Sleep",
          localeName: "sleep",
          apiKey: "sleep",
          isEditable: true,
          isTimeValue: true,
          editableHint: "pickSleepTime",
          iconPath: "assets/images/icons/sleep.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Water",
          localeName: "water",
          apiKey: "water",
          icon: TodoIcon.water,
          progress: 0,
          target: 17,
          iconPath: "assets/images/icons/water.png",
          picPath: "assets/images/home/cup_of_water.png",
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Vitamins",
          localeName: "vitamins",
          apiKey: "vitamins",
          icon: TodoIcon.other,
          iconPath: "assets/images/icons/vitamins.png",
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Meals",
          localeName: "meals",
          apiKey: "meals",
          target: 4,
          icon: TodoIcon.other,
          iconPath: "assets/images/icons/meals.png",
          dateTime: DateTime.now(),
          subtasks: [
            Subtask(
              name: "Meal 1",
              localeName: "meal1",
              picPath: "",
            ),
            Subtask(
              name: "Meal 2",
              localeName: "meal2",
              picPath: "",
            ),
            Subtask(
              name: "Meal 3",
              localeName: "meal3",
              picPath: "",
            ),
            Subtask(
              name: "Meal 4",
              localeName: "meal4",
              picPath: "",
            ),
            Subtask(
              name: "Meal 5",
              localeName: "meal5",
              picPath: "",
            ),
          ],
        ),
      );
      addTodo(
        Todo(
          name: "Workouts",
          localeName: "workouts",
          apiKey: "workouts",
          iconPath: "assets/images/icons/workouts.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Cardio",
          localeName: "cardio",
          apiKey: "cardio",
          iconPath: "assets/images/icons/cardio.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Cardio Duration",
          localeName: "cardioDuration",
          apiKey: "workout_duration",
          isEditable: true,
          isTimeValue: true,
          editableHint: "pickCardioDuration",
          iconPath: "assets/images/icons/hours_at_gym.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Walking",
          localeName: "walking",
          apiKey: "walking",
          iconPath: "assets/images/icons/walking.png",
          icon: TodoIcon.workout,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name:
              "Cheating every thing you ate that it’s not in your diet even if it’s healthy or not",
          apiKey: "cheating",
          localeName: "cheating",
          iconPath: "assets/images/icons/cheating_diet.png",
          icon: TodoIcon.workout,
          editableHint: "enterTheFood",
          isEditable: true,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Any removed thing from your diet plan",
          localeName: "removed_foods",
          apiKey: "removed_foods",
          iconPath: "assets/images/icons/remove_from_diet.png",
          icon: TodoIcon.workout,
          editableHint: "enterRemovedFood",
          isEditable: true,
          dateTime: DateTime.now(),
        ),
      );
      addTodo(
        Todo(
          name: "Prayers",
          localeName: "prayers",
          apiKey: "prayers",
          icon: TodoIcon.other,
          target: 5,
          iconPath: "assets/images/icons/prayers.png",
          dateTime: DateTime.now(),
          subtasks: [
            Subtask(
              name: "Fajr",
              localeName: "fajr",
              picPath: "",
            ),
            Subtask(
              name: "Zuhr",
              localeName: "zuhr",
              picPath: "",
            ),
            Subtask(
              name: "Asr",
              localeName: "asr",
              picPath: "",
            ),
            Subtask(
              name: "Maghrib",
              localeName: "maghrib",
              picPath: "",
            ),
            Subtask(
              name: "Isha",
              localeName: "isha",
              picPath: "",
            ),
          ],
        ),
      );
    }
    currentDisplayTodo = todos.where((element) {
      return element.dateTime.day == selectedDay.day &&
          element.dateTime.month == selectedDay.month &&
          element.dateTime.year == selectedDay.year;
    }).toList();
    emit(LoadTodoState(List.from(todos)));
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todo = todos.map((todo) => todo.toJsonString()).toList();
    await prefs.setStringList('todos', todo);
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    _saveTodos();
    emit(SaveTodoState(todos));
  }

  void sendTodoProgressToApi({
    required BuildContext context,
  }) async {
    emit(SendTodoToApisLoadingState());
    try {

      Map<String, dynamic> todoProgress = {
        "day": DateFormat('dd-MM-yyyy').format(selectedDay),
        "user_id": AppConstants.authRepository.user.id,
      };
      for (var todo in currentDisplayTodo) {
        if (todo.subtasks.isNotEmpty) {
          todoProgress.addAll({
            todo.apiKey: (todo.progress + 1).toString(),
          });
        } else if (todo.apiKey == "water") {
          todoProgress.addAll({
            todo.apiKey: (todo.progress + 1).toString(),
          });
        } else if (todo.editableHint != null && todo.editableHint!.isNotEmpty) {
          todoProgress.addAll({
            todo.apiKey: todo.editableHint,
          });
        } else {
          todoProgress.addAll({todo.apiKey: todo.isDone ? "yes" : "no"});
        }
      }
      Response response = await DioHelper.postData(
        endpoint: 'auth/todo/update',
        body: todoProgress,
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          successSnackBar(
            context: context,
            message: "todoUploadedSuccessfully".getLocale(context),
          );
        }
        emit(SendTodoToApisSuccessState());
      } else {
        if (context.mounted) {
          errorSnackBar(
            context: context,
            message: response.data['message'],
          );
        }
        emit(SendTodoToApisErrorState(response.data['message']));
      }
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(SendTodoToApisErrorState(e.toString()));
    }
  }

  void toggleTodoStatus(int index, {bool? value}) {
    if (value != null) {
      todos[index].isDone = value;
      currentDisplayTodo[index].isDone =value;
    } else {
      todos[index].isDone = !todos[index].isDone;
      currentDisplayTodo[index].isDone =!currentDisplayTodo[index].isDone;
    }

    _saveTodos();
    emit(
      ToggleTodoState(
        todos[index].name,
        todos[index].apiKey,
        todos[index].isDone,
      ),
    );
  }

  void removeTodo(int index, BuildContext context) {
    todos.removeAt(index);
    _saveTodos();
    loadTodos(context);
    emit(RemoveTodoState(todos));
  }

  void updateTodoProgress(
    double cupIndex,
    Todo todo, {
    int? subTaskIndex,
    bool subTaskIsDone = false,
  }) {
    todo.progress = cupIndex;
    if (subTaskIndex != null) {
      todo.subtasks[subTaskIndex].isDone = subTaskIsDone;
    }
    _saveTodos();
    emit(
      UpdateTodoProgressState(
        todo,
        cupIndex,
        subTaskIsDone,
        subTaskIndex ?? 0,
      ),
    );
  }

  void updateEditableTodoText(String progress, Todo todo) {
    todo.editableHint = progress;
    emit(UpdateEditableTodoProgressState(todo, progress));
  }

  void addTodoTarget(Todo todo) {
    todo.target += 1;
    _saveTodos();
    emit(AddTodoTargetState(todo, todo.target));
  }
}
