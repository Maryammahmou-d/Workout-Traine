import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/layout/layout_cubit.dart';
import 'package:gym/presentation/authentications/login/login_screen.dart';
import 'package:gym/presentation/landing/init_select_lang_screen.dart';
import 'package:gym/presentation/layout/layout_screen.dart';
import 'package:gym/services/dio_helper.dart';
import 'package:gym/services/local_storage/cache_helper.dart';
import 'package:gym/services/notifications_service.dart';
import 'package:gym/shared/bloc_observe.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/style/theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:no_screenshot/no_screenshot.dart';

import 'blocs/localization/cubit/localization_cubit.dart';
import 'blocs/localization/localization/app_localization_setup.dart';
import 'models/user_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  // CacheHelper.clearData(key: "todos");
  // await CacheHelper.clearAll();
  UserModel? cachedUser;
  await Hive.initFlutter();
  AppConstants.box = await Hive.openBox('workouts_box');
  if (await CacheHelper.getData(key: 'user') != null) {
    cachedUser =
        UserModel.fromJson(json.decode(await CacheHelper.getData(key: 'user')));
  }
  if (cachedUser != null &&
      cachedUser.enrollmentExpireDate.isBefore(DateTime.now())) {
    await CacheHelper.clearAll();
    AppConstants.box.clear();
  }
  AppConstants.isFirstTime =
      await CacheHelper.getData(key: 'firstTime') ?? true;
  final bool isShowingOnboarding =
      await CacheHelper.getData(key: 'isShowingOnboarding') ?? true;
  await NotificationsServices.awesomeNotificationInit();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await rootBundle.load('assets/images/yousef/1.jpeg');
  await rootBundle.load('assets/images/yousef/2.jpeg');
  await rootBundle.load('assets/images/yousef/3.jpeg');
  await rootBundle.load('assets/images/yousef/4.jpeg');
  await rootBundle.load('assets/images/yousef/5.jpeg');
  const AssetImage('assets/images/yousef/1.jpeg');
  const AssetImage('assets/images/yousef/2.jpeg');
  const AssetImage('assets/images/yousef/3.jpeg');
  const AssetImage('assets/images/yousef/4.jpeg');
  const AssetImage('assets/images/yousef/5.jpeg');
  runApp(MyApp(
    user: cachedUser,
    isShowingOnboarding: isShowingOnboarding,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    this.user,
    required this.isShowingOnboarding,
  });

  final UserModel? user;
  final bool isShowingOnboarding;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _noScreenshot.screenshotOff();
        break;
      case AppLifecycleState.inactive:
        _noScreenshot.screenshotOff();

        break;
      case AppLifecycleState.paused:
        _noScreenshot.screenshotOff();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        _noScreenshot.screenshotOff();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    _noScreenshot.screenshotOff();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: AppConstants.authRepository..getInitialUserValue(widget.user),
      child: BlocProvider<LocalizationCubit>(
        create: (context) => LocalizationCubit()..onInit(),
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, state) {
            if (state.locale.languageCode.contains("ar")) {
              AppLocalizationsSetup.isLoadAr = true;
            }

            return MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              locale: state.locale,
              // builder: (context, child) => GestureDetector(
              //   onTap: () {
              //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //         overlays: [SystemUiOverlay.top]);
              //     closeKeyboard();
              //   },
              //   child: child,
              // ),
              theme: appTheme,
              home: widget.isShowingOnboarding
                  ? const FirstSelectLangScreen()
                  : widget.user == null
                      ? const LoginScreen()
                      : BlocProvider<LayoutCubit>(
                          create: (context) => LayoutCubit(),
                          child: const LayoutScreen(),
                        ),
            );
          },
        ),
      ),
    );
  }
}

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
