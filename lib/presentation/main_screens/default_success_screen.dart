import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym/shared/extentions.dart';

import '../../blocs/localization/cubit/localization_cubit.dart';
import '../../shared/constants.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../authentications/login/login_screen.dart';

class DefaultSuccessScreen extends StatelessWidget {
  const DefaultSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: AppConstants.screenSize(context).height,
          width: AppConstants.screenSize(context).width,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height:
                      AppConstants.screenSize(context).height < 600 ? 40 : 150,
                ),
                SvgPicture.asset(
                  "assets/images/icons/success_img.svg",
                ),
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
                        ? "مرحبا بك في Team Salama!"
                        : "Thanks for signing up with \nTeam Salama",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
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
                        ? "حسابك حاليًا قيد المراجعة لضمان تجربة رائعة. بمجرد تفعيله، سيتواصل معك أحد أعضاء فريقنا لبدء رحلة اللياقة البدنية الخاصة بك."
                        : "Your account is currently being reviewed to ensure a great fit. Once activated, a member of our team will reach out to you to get you started on your fitness journey.",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                DefaultButton(
                  color: Colors.black,
                  function: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  text: "done".getLocale(context),
                  marginLeft: 41,
                  marginRight: 41,
                  marginBottom: 37,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
