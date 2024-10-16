import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/shared/extentions.dart';

import '../../../../blocs/todo/todo_cubit.dart';
import '../../../../models/todo_model.dart';

class AddTodoDialog extends StatefulWidget {
  final TodoCubit todoCubit;

  const AddTodoDialog({
    super.key,
    required this.todoCubit,
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _nameController = TextEditingController();
  TodoIcon _selectedIcon = TodoIcon.workout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.todoCubit,
      child: AlertDialog(
        title:  Text('addTodo'.getLocale(context)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration:  InputDecoration(labelText: 'taskName'.getLocale(context)),
            ),
            DropdownButton<TodoIcon>(
              value: _selectedIcon,
              onChanged: (TodoIcon? newValue) {
                setState(() {
                  _selectedIcon = newValue!;
                });
              },
              items: const <DropdownMenuItem<TodoIcon>>[
                DropdownMenuItem(
                  value: TodoIcon.workout,
                  child: Icon(Icons.fitness_center),
                ),
                DropdownMenuItem(
                  value: TodoIcon.restaurant,
                  child: Icon(Icons.restaurant),
                ),
                DropdownMenuItem(
                  value: TodoIcon.other,
                  child: Icon(Icons.alarm),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'.getLocale(context),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('add'.getLocale(context),
            style: const TextStyle(
              color: Colors.white,
            ),
            ),
            onPressed: () {
              final name = _nameController.text;
              if (name.isNotEmpty) {
                final todo = Todo(
                  name: name,
                  localeName: name,
                  icon: _selectedIcon,
                  dateTime: widget.todoCubit.selectedDay,
                  apiKey: '',
                );
                widget.todoCubit.addTodo(todo);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
