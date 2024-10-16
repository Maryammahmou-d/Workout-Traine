import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/authentications/login/login_screen.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/shared_widgets.dart'; // Make sure this path is correct
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/localization/cubit/localization_cubit.dart';
import '../../services/local_storage/cache_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: AppConstants.screenSize(context).height,
        width: AppConstants.screenSize(context).width,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/yousef/${currentIndex + 1}.jpeg",
              fit: BoxFit.cover,
              height: AppConstants.screenSize(context).height,
              width: AppConstants.screenSize(context).width,
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      children: [
                        OnboardingStep(
                          titleAr: "اتمرن في اي مكان لوحدك🔥",
                          titleEn: "Exercise Anywhere Alone🔥",
                          imagePath: 'assets/images/step_one.png',
                          title: 'First Screen',
                          descriptionAr:
                              " البيت او من اي جيم مهما كانت امكانياته\n\n‎- مش هتحتاج مساعدة من اي مدرب لان التمرين كابتن يوسف هيعملهولك على حسب مستواك وحسب الاجهزة والادوات المتاحة عندك",
                          descriptionEn:
                              "- Exercise anywhere alone, whether from home or any gym, no matter its capabilities.\n\n- You won't need any trainer's help because Captain Youssef will make the exercise according to your level and the available equipment and tools you have. - Each exercise comes with an exercise picture and 3 videos: a video showing the exercise, a video explaining it to you, and a video highlighting all the mistakes you might make. So, you'll never need anyone, no matter your level, even if it's your first day at the gym. - All videos are downloaded offline to show you the essential exercise tricks without getting delayed on the network or internet.",
                          currentIndex: currentIndex,
                          controller: _controller,
                        ),
                        OnboardingStep(
                          titleAr: "ازاي هعرف اتمرن صح لوحدي؟",
                          titleEn: "How do I know how to exercise properly on my own?",
                          imagePath: 'assets/images/step_one.png',
                          title: 'First Screen',
                          descriptionAr:
                              "- كل تمرينة بيكون معاها صورة التمرين و ٣ فيديوهات فيديو بيوضح شكل التمرينة وفيديو بيشرحهالك ويشرحلك ازاي تتمرنها وفيديو بيقولك على كل الاخطاء الي ممكن تقع فيها فا استحالة تحتاج لحد مهما كان مستواك حتى لو اول يوم تدخل الجيم\n\n- كل الفيديوهات بتحمل معاك اوفلاين عشان توضحلك اهم تريكات التمرين من غير متتعطل على شبكة او نت",
                          descriptionEn:
                              "- Each exercise comes with an exercise picture and 3 videos: a video showing the exercise, a video explaining it to you, and a video highlighting all the mistakes you might make. So, you'll never need anyone, no matter your level, even if it's your first day at the gym.\n\n- All videos are downloaded offline to show you the essential exercise tricks without getting delayed on the network or internet.",
                          currentIndex: currentIndex,
                          controller: _controller,
                        ),
                        OnboardingStep(
                          titleAr: "انسي الدايت الصعب الممل",
                          titleEn: "Forget about the difficult and boring diet",
                          imagePath: 'assets/images/step_two.png',
                          title: 'Second Screen',
                          currentIndex: currentIndex,
                          controller: _controller,
                          descriptionAr:
                              "- كابتن يوسف بيعملك نظامك الغذائي حسب هدفك وامكانياتك\n\n- هتلاقي عندك جمب كل صنف زرار يبدلك اكلك عشان متزهقش\n\n- هتلاقي اكتر من ١٠٠ وصفة اكل عشان تنوع فيهم براحتك لحد ما توصل لهدفك",
                          descriptionEn:
                              "- Captain Youssef makes your diet according to your goal and capabilities.\n\n- You will find a button next to each item to switch your food, so you don't get bored.\n\n- You'll find more than 100 recipes to diversify as you like until you reach your goal.",
                        ),
                        OnboardingStep(
                          titleEn: "This is a personal follow-up application with Team ",
                          titleAr: "دا ابلكيشن متابعة شخصية مع team Salama",
                          imagePath: 'assets/images/step_three.png',
                          title: 'Third Screen',
                          currentIndex: currentIndex,
                          controller: _controller,
                          descriptionAr:
                              "- لازم تكون عارف ان دا مش ابلكيشن بيشتغل مع الكمييوتر دا ابلكيشن متابعة شخصية مع كابتن يوسف انت بيكون ليك بروفايل فيه كل بياناتك وهو بيرفعلك عليه اكلك وتمرينك\n\n- بتتواصلو سوا عن طريق الشات او الفيديو كول  وبتتابع التطور بتاعك معاه وبتشرحلة اي مشاكل بتقابلك وعلى اساسها بيغيرلك في جدول تمرينك و اكلك\n\n- وكمان بتقدر تسجل اوزانك في التمرين جوا البروفايل بتاعك و يومك جوا ال to do list اليومية بتاعتك",
                          descriptionEn:
                              "- You need to know that this is not an app that works with a computer; it's a personal follow-up app with Captain Youssef. You have a profile with all your data, and he uploads your food and exercise.\n\n- You communicate together via chat or video call, track your progress with him, and explain any problems you encounter. Based on that, he changes your exercise and diet plan.\n\n- You can also record your exercise weights in your profile and your day in your daily to-do list.",
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              context
                                      .read<LocalizationCubit>()
                                      .state
                                      .locale
                                      .toString()
                                      .contains('ar')
                                  ? "اهلا بيك في Team Salama"
                                  : "Welcome to Team Salama!",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                context
                                        .read<LocalizationCubit>()
                                        .state
                                        .locale
                                        .toString()
                                        .contains('ar')
                                    ? "عشان نبدا سوا لازم تكون مشترك معانا في احدى باقات المتابعة والتدريب الاونلاين وبعد الاشتراك بنفعلك الاكونت بتاعك وبنبدا نحطلك عليه تمرينك واكلك وتبدا المتابعة"
                                    : "To get started with us, you need to subscribe to one of our online follow-up and training packages. Once you've subscribed, we'll activate your account and start setting up your personalized workout and nutrition plan.",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              context
                                      .read<LocalizationCubit>()
                                      .state
                                      .locale
                                      .toString()
                                      .contains('ar')
                                  ? "الدفع بيكون عن طريق فودافون كاش او انستا باي"
                                  : "Payment can be made via Vodafone Cash or InstaPay.",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              context
                                      .read<LocalizationCubit>()
                                      .state
                                      .locale
                                      .toString()
                                      .contains('ar')
                                  ? "اتواصل معانا من خلال"
                                  : "Contact us through",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: InkWell(
                                onTap: () {
                                  _launchUrl(
                                      "https://www.instagram.com/yousef_salama");
                                },
                                child: Container(
                                  width: AppConstants.screenSize(context).width,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/Instagram_icon.png",
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        "@yousef_salama",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: InkWell(
                                onTap: () {
                                  _launchUrl(
                                      "https://www.facebook.com/profile.php?id=100083325317164&mibextid=LQQJ4d");
                                },
                                child: Container(
                                  width: AppConstants.screenSize(context).width,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/facebook-icon.png",
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        "Youssef Salama Fitness",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: InkWell(
                                onTap: () {
                                  _launchUrl("Wa.me/+201270096399");
                                },
                                child: Container(
                                  width: AppConstants.screenSize(context).width,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/whatsapp-icon-free-png.webp",
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        "+201270096399",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: InkWell(
                                onTap: () {
                                  _launchUrl("https://youssefslama.com/");
                                },
                                child: Container(
                                  width: AppConstants.screenSize(context).width,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/web_icon.png",
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        "youssefslama.com",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24.0,
                    ),
                    child: Row(
                      mainAxisAlignment: currentIndex == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentIndex != 0)
                          DefaultButton(
                            height: 44,
                            width: 140,
                            marginTop: 20,
                            marginRight: 0,
                            marginLeft: 0,
                            marginBottom: 0,
                            function: () {
                              _controller.animateToPage(
                                currentIndex - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            },
                            text: "back".getLocale(context),
                          ),
                        DefaultButton(
                          height: 44,
                          width: 140,
                          marginTop: 20,
                          marginRight: 0,
                          marginLeft: 0,
                          marginBottom: 0,
                          function: () async {
                            if (currentIndex == 4) {
                              await CacheHelper.setData(
                                key: 'isShowingOnboarding',
                                value: false,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              _controller.animateToPage(
                                currentIndex + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            }
                          },
                          text: currentIndex == 4
                              ? "Done".getLocale(context)
                              : "next".getLocale(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String descriptionAr;
  final String descriptionEn;
  final String titleAr;
  final String titleEn;
  final int currentIndex;
  final PageController controller;

  const OnboardingStep({
    super.key,
    required this.imagePath,
    required this.title,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.titleAr,
    required this.titleEn,
    required this.currentIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                bottom: 24.0,
              ),
              child: Text(
                context
                    .read<LocalizationCubit>()
                    .state
                    .locale
                    .toString()
                    .contains('ar')
                    ? titleAr
                    : titleEn,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: Text(
                context
                    .read<LocalizationCubit>()
                    .state
                    .locale
                    .toString()
                    .contains('ar')
                    ? descriptionAr
                    : descriptionEn,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
