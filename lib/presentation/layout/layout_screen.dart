import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/home/home_cubit.dart';
import 'package:gym/blocs/layout/layout_cubit.dart';
import 'package:gym/presentation/main_screens/tracking/tracking_screen.dart';
import 'package:gym/presentation/main_screens/workouts/workout_screen.dart';
import 'package:gym/services/notifications_service.dart';
import 'package:gym/shared/constants.dart';

import '../../services/local_storage/cache_helper.dart';
import '../../style/colors.dart';
import '../main_screens/home/home_screen.dart';
import '../main_screens/todo/todo_screen.dart';
import 'layout_widgets/nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    createWaterNotification();
    createNewNotifications();
    super.initState();
  }

  void createNewNotifications() async {
    if (await CacheHelper.getData(key: 'newNotifications') == null ||
        await CacheHelper.getData(key: 'newNotifications2') == null) {
      if (await AwesomeNotifications().isNotificationAllowed()) {
        await AwesomeNotifications()
            .cancelNotificationsByChannelKey("questions_channel");
        await NotificationsServices.createQuestionsReminderNotification().then(
          (value) {
            CacheHelper.setData(key: 'newNotifications', value: false);
            CacheHelper.setData(key: 'newNotifications2', value: false);
          },
        );
      }
    }
  }

  void createWaterNotification() async {
    if (await CacheHelper.getData(key: 'firstTime') == null) {
      AwesomeNotifications().requestPermissionToSendNotifications().then(
        (value) {
          if (value) {
            NotificationsServices.createWaterReminderNotification();
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
          CacheHelper.setData(key: 'firstTime', value: false);
          AppConstants.isFirstTime = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.mainColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.darkHeader,
      systemNavigationBarColor: AppColors.darkHeader,
    ));

    final List<Widget> screens = [
      BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
      const WorkoutScreen(),
      const TodoInitScreen(),
      const TrackingScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepositoryProvider.value(
              value: AppConstants.workoutsRepository
                ..getWorkoutsPlan(userId: AppConstants.authRepository.user.id),
              child: BlocBuilder<LayoutCubit, LayoutState>(
                buildWhen: (previous, current) =>
                    current is ChangeNavBarValueState,
                builder: (context, state) {
                  return Expanded(
                    child: screens[context.read<LayoutCubit>().navbarIndex],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
