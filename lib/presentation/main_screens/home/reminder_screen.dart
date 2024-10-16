import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gym/shared/extentions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/notifications_service.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [];
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadReminders();
  }

  Future<void> loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      reminders = (prefs.getStringList('reminders') ?? [])
          .map((jsonString) {
            return jsonDecode(jsonString);
          })
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  Future<void> saveReminder(
    int id,
    String task,
    String description,
    DateTime dateTime,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> reminderData = {
      'id': id,
      'task': task,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
    };
    setState(() {
      reminders.add(reminderData);
      prefs.setStringList(
          'reminders', reminders.map((data) => jsonEncode(data)).toList());
    });
  }

  Future<void> showDatePickerDialog() async {
    DateTime selectedDate = DateTime.now();
  await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white, // Header background color
            colorScheme: ColorScheme.dark(
              primary: AppColors.oldMainColor.withOpacity(0.75),
              onPrimary: AppColors.mainColor,
              surface: AppColors.mainColor,
              onSurface: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.accent,
            ),
          ),
          child: child!,
        );
      },
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    showTimePickerDialog(selectedDate);
    }

  Future<void> showTimePickerDialog(DateTime selectedDate) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white, // Header background color
            colorScheme: ColorScheme.dark(
              primary: AppColors.oldMainColor.withOpacity(0.75),
              onPrimary: AppColors.mainColor,
              surface: AppColors.mainColor,
              onSurface: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.accent,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      DateTime selectedDateUtc = selectedDate.toUtc();
      DateTime selectedDateTime = DateTime(
        selectedDateUtc.year,
        selectedDateUtc.month,
        selectedDateUtc.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      NotificationsServices.createReminderNotification(
        id,
        descriptionController.text.isNotEmpty ? taskController.text : "",
        descriptionController.text.isNotEmpty
            ? descriptionController.text
            : taskController.text,
        selectedDateUtc,
        TimeOfDay(
          hour: pickedTime.hour,
          minute: pickedTime.minute,
        ),
      );
      String task = taskController.text;
      String description = descriptionController.text;
      saveReminder(id, task, description, selectedDateTime);
      loadReminders();
      taskController.clear();
      descriptionController.clear();
      FocusManager.instance.primaryFocus?.unfocus();

      if (context.mounted) {
        _showSnackBar('reminderAddedSuccessfully'.getLocale(context));
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> deleteOneReminder(int id) async {
    AwesomeNotifications().cancelSchedule(id);
    if (reminders.isNotEmpty) {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('deleteThisReminder'.getLocale(context)),
            content: Text('areUSureYouWantToDeleteReminder'.getLocale(context)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'cancel'.getLocale(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'delete'.getLocale(context),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      );
      if (confirmDelete == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          reminders.removeWhere((element) => element['id'] == id);
          prefs.setStringList(
              'reminders', reminders.map((data) => jsonEncode(data)).toList());
        });
        loadReminders();
        if (context.mounted) {
          _showSnackBar('reminderDeleted'.getLocale(context));
        }
      }
    }
  }

  Future<void> deleteAllReminders() async {
    AwesomeNotifications().cancelAll();
    if (reminders.isNotEmpty) {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('deleteAllReminders'.getLocale(context)),
            content: Text('sureToDeleteAllReminders'.getLocale(context)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'cancel'.getLocale(context),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'delete'.getLocale(context),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          reminders.clear();
          prefs.setStringList(
              'reminders', reminders.map((data) => jsonEncode(data)).toList());
        });
        if (context.mounted) {
          _showSnackBar('allRemindersDeleted'.getLocale(context));
        }
      }
    } else {
      _showSnackBar('noReminderDeleted'.getLocale(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: 'reminderScreen'.getLocale(context),
          children: const [],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: taskController,
                  labelText: 'task'.getLocale(context),
                  suffixIcon: Icons.event_note,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: descriptionController,
                  labelText: 'desc'.getLocale(context),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      AwesomeNotifications()
                          .isNotificationAllowed()
                          .then((isAllowed) {
                        if (!isAllowed) {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications();
                        } else {
                          showDatePickerDialog();
                        }
                      });
                    } else {
                      _showSnackBar(
                          "taskFieldCannotBeEmpty".getLocale(context));
                    }
                  },
                  child: Text(
                    'pickDateAndTime'.getLocale(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${"reminders".getLocale(context)}:',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: reminders.isEmpty
                      ? Center(
                          child: Text(
                            'noReminders'.getLocale(context),
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: (context, index) {
                            return ReminderCard(
                              task: reminders[index]['task'],
                              description: reminders[index]['description'],
                              dateTime:
                                  DateTime.parse(reminders[index]['dateTime']),
                              onDelete: () {
                                deleteOneReminder(reminders[index]['id']);
                              },
                            );
                          },
                        ),
                ),
                ElevatedButton.icon(
                  onPressed: () => deleteAllReminders(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: Text(
                    'deleteAllReminders'.getLocale(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        suffixIcon:
            suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}

class ReminderCard extends StatefulWidget {
  final String task;
  final String description;
  final DateTime dateTime;
  final VoidCallback onDelete;

  const ReminderCard({
    super.key,
    required this.task,
    required this.description,
    required this.dateTime,
    required this.onDelete,
  });

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: widget.onDelete,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (widget.description.isNotEmpty)
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              const SizedBox(height: 8),
              Text(
                _formatDateTime(widget.dateTime),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }
}
