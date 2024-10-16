import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsServices {
  static awesomeNotificationInit() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for reminders',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          criticalAlerts: true,
        ),
        NotificationChannel(
          channelGroupKey: 'water_channel_group',
          channelKey: 'water_channel',
          channelName: 'Water Notifications',
          channelDescription: 'Notification channel for water notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
        NotificationChannel(
          channelGroupKey: 'questions_channel_group',
          channelKey: 'ro7tElGym',
          channelName: 'ro7tElGym Notifications',
          channelDescription:
              'Notification channel for questions notifications',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
        NotificationChannel(
          channelGroupKey: 'questions_channel_group',
          channelKey: 'MealNotification',
          channelName: 'MealNotification',
          channelDescription:
              'Notification channel for questions notifications',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
        NotificationChannel(
          channelGroupKey: 'questions_channel_group',
          channelKey: 'vitaminsNotifications',
          channelName: 'vitamins Notification',
          channelDescription:
              'Notification channel for questions notifications',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
        NotificationChannel(
          channelGroupKey: 'questions_channel_group',
          channelKey: 'GebtAkhrak',
          channelName: 'GebtAkhrak Notification',
          channelDescription:
              'Notification channel for questions notifications',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
        NotificationChannel(
          channelGroupKey: 'questions_channel_group',
          channelKey: 'todoList',
          channelName: 'todoList Notification',
          channelDescription:
              'Notification channel for questions notifications',
          defaultColor: Colors.amber,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: false,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'water_channel_group',
          channelGroupName: 'Water group',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'questions_channel_group',
          channelGroupName: 'Questions group',
        ),
      ],
    );
  }

  static Future<void> createReminderNotification(
    int id,
    String title,
    String description,
    DateTime date,
    TimeOfDay time,
  ) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: "${Emojis.time_alarm_clock} $title",
        body: description,
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: time.hour,
        minute: time.minute,
        second: 20,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
  }

  static Future<void> createWaterReminderNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1234343434,
        channelKey: 'water_channel',
        title: "🧴",
        body: "Drink water now! Your body will thank you.",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationInterval(
        interval: 7200,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
  }

  //رحت الجيم النهاردة ؟
  // كلت وجبتك الي عليها الدور ولا لسة ؟
  // خدت فيتاميناتك النهاردة ؟
  // جبت اخرك في التمرين النهاردة ولا كسلت ؟
  //  بتاعتك النهاردة ؟To-do-list كملت
  static Future<void> createQuestionsReminderNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'ro7tElGym',
        title: "🏋🏻",
        body: "رحت الجيم النهاردة ؟",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: 16,
        minute: 0,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'MealNotification',
        title: "𓎩",
        body: "كلت وجبتك الي عليها الدور ولا لسة ؟",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: 18,
        minute: 0,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'vitaminsNotifications',
        title: "💊",
        body: "خدت فيتاميناتك النهاردة ؟",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: 20,
        minute: 0,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'GebtAkhrak',
        title: "💪",
        body: "جبت اخرك في التمرين النهاردة ولا كسلت ؟",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: 22,
        minute: 0,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'todoList',
        title: "📝",
        body: "بتاعتك النهاردة ؟To-do-list كملت",
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        hour: 23,
        minute: 59,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
  }
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}
