import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/shared/extentions.dart';

import '../../../../blocs/todo/todo_cubit.dart';
import '../../../../models/todo_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import '../../../../style/colors.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
    required this.index,
  });

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          todo.isDone ? Colors.white : AppColors.oldMainColor.withOpacity(0.3),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () async {
              if (todo.isTimeValue) {
                await buildPickTimeValue(
                  context,
                );
              }
            },
            minVerticalPadding: 0,
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            title: Text(
              todo.localeName.getLocale(context),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: todo.iconPath == null
                ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: todo.isDone
                          ? AppColors.lightGrey
                          : AppColors.mainColor,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      getIconData(todo.icon),
                      color: Colors.white,
                    ),
                  )
                : Image.asset(
                    todo.iconPath!,
                    height: 50,
                    width: 50,
                  ),
            trailing: todo.isEditable
                ? null
                : todo.subtasks.isNotEmpty
                    ? CircularProgressIndicator(
                        backgroundColor: AppColors.regularGrey,
                        color: AppColors.oldMainColor,
                        value: todo.progress / todo.target,
                      )
                    : Checkbox(
                        fillColor: const WidgetStatePropertyAll<Color>(
                            AppColors.white),
                        value: context.watch<TodoCubit>().todos[index].isDone,
                        onChanged: (value) {
                          if(value != null) {
                            context.read<TodoCubit>().toggleTodoStatus(index , value: value);
                          }
                        },
                      ),
          ),
          if (todo.isEditable)
            InkWell(
              onTap: () async {
                if (todo.isTimeValue) {
                  Duration selectedTime = Duration.zero;
                  await buildPickTimeValue(
                    context,
                    duration: todo.apiKey == "workout_duration"
                        ? selectedTime
                        : null,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 75.0, right: 10),
                child: TextField(
                  onChanged: (value) {
                    context
                        .read<TodoCubit>()
                        .updateEditableTodoText(value, todo);
                  },
                  onSubmitted: (value) {
                    context
                        .read<TodoCubit>()
                        .updateEditableTodoText(value, todo);
                  },
                  enabled: todo.isTimeValue ? false : true,
                  decoration: InputDecoration(
                    suffixIcon: todo.isTimeValue
                        ? IconButton(
                            onPressed: () async {
                              await buildPickTimeValue(context);
                            },
                            icon: const Icon(Icons.calendar_today_rounded),
                          )
                        : null,
                    hintStyle: AppConstants.textTheme(context).bodyMedium,
                    hintText: todo.editableHint?.getLocale(context) ?? "",
                  ),
                ),
              ),
            ),
          if (todo.subtasks.isNotEmpty)
            ...List.generate(
              todo.subtasks.length,
              (subIndex) => Padding(
                padding: const EdgeInsets.only(left: 75.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          todo.subtasks[subIndex].name,
                          style: TextStyle(
                            color: todo.subtasks[subIndex].isDone
                                ? Colors.grey
                                : Colors.black,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 1,
                            decoration: todo.subtasks[subIndex].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                      fillColor: const WidgetStatePropertyAll<Color>(
                        AppColors.white,
                      ),
                      value: todo.subtasks[subIndex].isDone,
                      onChanged: (value) {
                        todo.subtasks[subIndex].isDone = value ?? false;
                        if (value != null && value) {
                          context.read<TodoCubit>().updateTodoProgress(
                                todo.progress + 1,
                                todo,
                                subTaskIndex: subIndex,
                                subTaskIsDone: todo.subtasks[subIndex].isDone,
                              );
                        } else {
                          context.read<TodoCubit>().updateTodoProgress(
                                todo.progress - 1,
                                todo,
                                subTaskIndex: subIndex,
                                subTaskIsDone: todo.subtasks[subIndex].isDone,
                              );
                        }
                        if (todo.subtasks
                            .every((element) => element.isDone)) {
                          context
                              .read<TodoCubit>()
                              .toggleTodoStatus(index, value: true);
                        } else {
                          context
                              .read<TodoCubit>()
                              .toggleTodoStatus(index, value: false);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Future<Duration?> buildPickTimeValue(
    BuildContext context, {
    Duration? duration,
  }) {
    return showCupertinoModalPopup<Duration>(
      context: context,
      builder: (BuildContext bottomSheetContext) {
        TimeOfDay selectedTime = TimeOfDay.now();
        return Container(
          height: 300.0,
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (duration == null)
                Expanded(
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.black,
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
                      selectedTime = TimeOfDay.fromDateTime(value);
                    },
                  ),
                ),
              if (duration != null)
                CupertinoTimerPicker(
                  backgroundColor: Colors.black,
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: duration!,
                  onTimerDurationChanged: (Duration newTime) {
                    duration = newTime;
                  },
                ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 44.0),
                    child: TextButton(
                      onPressed: () {
                        if (context.mounted) {
                          context.read<TodoCubit>().updateEditableTodoText(
                              duration != null
                                  ? "${duration!.inHours} ${"hours".getLocale(context)}:${(duration!.inMinutes % 60).toString().padLeft(2, '0')} ${"minutes".getLocale(context)}"
                                  : "${selectedTime.hour.toString().length == 1 ? "0${selectedTime.hour}" : selectedTime.hour}:${selectedTime.minute.toString().length == 1 ? "0${selectedTime.minute}" : selectedTime.minute} ${selectedTime.period.name.toUpperCase()}",
                              todo);
                        }
                        Navigator.of(bottomSheetContext).pop();
                      },
                      child: Text(
                        "done".getLocale(context),
                        style: AppConstants.textTheme(context)
                            .titleSmall!
                            .copyWith(
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                    },
                    child: Text(
                      "cancel".getLocale(context),
                      style:
                          AppConstants.textTheme(context).titleSmall!.copyWith(
                                color: Colors.red,
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class WaterCard extends StatelessWidget {
  const WaterCard({
    super.key,
    required this.todo,
    required this.todoCubit,
  });

  final Todo todo;
  final TodoCubit todoCubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.black.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  getIconData(todo.icon),
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "myWaterIntake".getLocale(context),
                  style: AppConstants.textTheme(context).titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                const Spacer(),
                CircularProgressIndicator(
                  backgroundColor: AppColors.regularGrey,
                  color: AppColors.oldMainColor,
                  value: (todo.progress + 1) / todo.target,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                top: 8.0,
              ),
              child: Text(
                "${"dailyGoal".getLocale(context)}: ${todo.target * 250} ${"ML".getLocale(context)}",
                style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                      color: Colors.grey.withOpacity(0.8),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                top: 8.0,
              ),
              child: Text(
                "${"drunk".getLocale(context)}: ${(todo.progress + 1) * 250} ${"ML".getLocale(context)}",
                style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                      color: Colors.grey.withOpacity(0.8),
                    ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...List.generate(
                  todo.target.toInt(),
                  (cupIndex) => AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: cupIndex <= todo.progress ? 1.0 : 0.4,
                    child: InkWell(
                      onTap: () {
                        todoCubit.updateTodoProgress(
                          cupIndex.toDouble(),
                          todo,
                        );
                      },
                      child: Image.asset(
                        todo.picPath,
                        width: 30,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultButton(
                  marginTop: 0,
                  marginLeft: 0,
                  marginRight: 8,
                  marginBottom: 0,
                  width: 160,
                  height: 38,
                  function: () {
                    todoCubit.addTodoTarget(todo);
                  },
                  text: "+ ${"addCup".getLocale(context)}",
                ),
                Text(
                  "1 ${"cups".getLocale(context)} 250 ${"ML".getLocale(context)}",
                  style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
