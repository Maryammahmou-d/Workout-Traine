import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/main_screens/todo/todo_widgets/todo_cards.dart';
import 'package:gym/presentation/main_screens/todo/todo_widgets/todo_widgets.dart';
import 'package:gym/shared/extentions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../blocs/todo/todo_cubit.dart';
import '../../../models/todo_model.dart';
import '../../../shared/constants.dart';
import '../../../style/colors.dart';

class TodoInitScreen extends StatelessWidget {
  const TodoInitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..loadTodos(context),
      child: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppColors.mainColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                  top: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 38,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "todo".getLocale(context),
                              style: AppConstants.textTheme(context)
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          // const SizedBox(),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: BlocBuilder<TodoCubit, TodoState>(
                              buildWhen: (previous, current) {
                                return current is SendTodoToApisErrorState ||
                                    current is SendTodoToApisSuccessState ||
                                    current is SendTodoToApisLoadingState;
                              },
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {
                                    if (state is! SendTodoToApisLoadingState) {
                                      context
                                          .read<TodoCubit>()
                                          .sendTodoProgressToApi(
                                            context: context,
                                          );
                                    }
                                  },
                                  icon: state is SendTodoToApisLoadingState
                                      ? const Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              end: 16.0),
                                          child: CircularProgressIndicator(
                                            color: AppColors.white,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.upload_rounded,
                                          color: AppColors.white,
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    BlocBuilder<TodoCubit, TodoState>(
                      buildWhen: (previous, current) =>
                          current is ChangeSelectedDayState,
                      builder: (context, selectedDay) {
                        final TodoCubit todoCubit = context.read<TodoCubit>();
                        return TableCalendar(
                          headerStyle: const HeaderStyle(
                            titleTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: Colors.white,
                            ),
                            weekendStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          headerVisible: false,
                          rowHeight: 80,
                          startingDayOfWeek: StartingDayOfWeek.saturday,
                          calendarStyle: CalendarStyle(
                            outsideDecoration: const BoxDecoration(
                              color: AppColors.oldMainColor,
                              shape: BoxShape.circle,
                            ),
                            rangeStartTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            rangeEndTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            selectedTextStyle: const TextStyle(
                              color: AppColors.mainColor,
                            ),
                            withinRangeTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            defaultTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            weekendTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            outsideTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            rangeHighlightColor: AppColors.oldMainColor,
                            todayDecoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightGrey,
                              ),
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(todoCubit.selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            todoCubit.selectDate(selectedDay);
                          },
                          calendarFormat: CalendarFormat.week,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: todoCubit.selectedDay,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              margin: const EdgeInsets.only(top: 180.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  final TodoCubit todoCubit = context.read<TodoCubit>();
                  todoCubit.changeCurrentList();
                  List<Todo> todos = todoCubit.currentDisplayTodo;
                  return state is LoadTodoListState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 50,
                          ),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return todo.name.toLowerCase().contains("water")
                                ? WaterCard(todo: todo, todoCubit: todoCubit)
                                : TodoCard(
                                    todo: todo,
                                    index: index,
                                  );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<TodoCubit, TodoState>(
        buildWhen: (previous, current) => current is ChangeSelectedDayState,
        builder: (context, state) {
          final TodoCubit todoCubit = context.read<TodoCubit>();
          return todoCubit.selectedDay.isAfter(DateTime.now()) ||
                  (todoCubit.selectedDay.day == DateTime.now().day &&
                      todoCubit.selectedDay.month == DateTime.now().month &&
                      todoCubit.selectedDay.year == DateTime.now().year)
              ? FloatingActionButton(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: AppColors.lightGrey,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialog) {
                        return AddTodoDialog(
                          todoCubit: context.read<TodoCubit>(),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
