import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/layout/layout_cubit.dart';
import 'package:gym/blocs/login/login_bloc.dart';
import 'package:gym/presentation/authentications/login/forget_password.dart';
import 'package:gym/presentation/authentications/signup/signup_screen.dart';
import 'package:gym/presentation/landing/init_select_lang_screen.dart';
import 'package:gym/presentation/layout/layout_screen.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/snack_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/enums.dart';
import '../../../shared/navigate_functions.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';
import '../auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // const Align(
                    //     alignment: AlignmentDirectional.centerEnd,
                    //     child: SelectLangBottomSheet()),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const FirstSelectLangScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded),
                          Text(
                            "Welcome Screens",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/logo-main.png',
                        width: 180,
                        scale: 1,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        child: Text(
                          'welcomeBack'.getLocale(context),
                          style: AppConstants.textTheme(context)
                              .titleLarge!
                              .copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        'email'.getLocale(context),
                        style:
                            AppConstants.textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          current is EmailValidationState,
                      builder: (context, state) {
                        final loginBloc = context.read<LoginBloc>();
                        return EmailTextField(
                          // focusNode: loginBloc.emailNode,
                          marginTop: 8,
                          marginBottom: 0,
                          marginLeft: 0,
                          marginRight: 0,
                          textInputAction: TextInputAction.next,
                          hint: "emailAddress".getLocale(context),
                          validateText: "thisEmailIsInvalid".getLocale(context),
                          onTap: () {
                            // loginBloc.emailNode.requestFocus();
                          },
                          fieldValidation: loginBloc.emailValidationState,
                          controller: loginBloc.emailController,
                          onChange: (value) => loginBloc.isValidEmail(
                            email: loginBloc.emailController.text,
                          ),
                          onSubmit: (String value) {
                            loginBloc.isValidEmail(
                              email: loginBloc.emailController.text,
                            );
                            // FocusScope.of(context).nextFocus();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        'password'.getLocale(context),
                        style:
                            AppConstants.textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) {
                        return (current is PasswordVisibilityState ||
                            current is PasswordValidationState);
                      },
                      builder: (context, state) {
                        final loginBloc = context.read<LoginBloc>();
                        return PasswordTextField(
                          // focusNode: loginBloc.passNode,
                          fieldValidation: loginBloc.passValidationState,
                          controller: loginBloc.passwordController,
                          marginTop: 8,
                          marginLeft: 0,
                          marginRight: 0,
                          validatePadding: 0,
                          onChange: (pass) {
                            loginBloc.isValidPassword(
                              password: pass,
                            );
                          },
                          onSubmit: (pass) => loginBloc.isValidPassword(
                            password: pass,
                          ),
                          isObscureText: !loginBloc.isPassVisible,
                          onIconPress: () {
                            loginBloc.changePassVisibility();
                          },
                          onTextFieldTap: () {
                            // loginBloc.passNode.requestFocus();
                          },
                          validateText:
                              "passwordCannotBeEmpty".getLocale(context),
                          iconData: loginBloc.isPassVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () {
                              Navigate(
                                context: context,
                                screen: ForgetPasswordScreen(
                                    loginBloc: context.read<LoginBloc>()),
                              ).to();
                            },
                            child: Text(
                              "${"forgotPassword".getLocale(context)}?",
                              style: AppConstants.textTheme(context)
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.oldMainColor,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (listenContext, state) {
                        if (state is LoginErrorState) {
                          errorSnackBar(
                            context: context,
                            message: state.error,
                          );
                        }
                        if (state is LoginSuccessState) {
                          successSnackBar(
                            context: context,
                            message: "success",
                          );
                          Navigate(
                            screen: BlocProvider<LayoutCubit>(
                              create: (context) => LayoutCubit(),
                              child: const LayoutScreen(),
                            ),
                            context: context,
                          ).to();
                        }
                      },
                      // buildWhen: (previous, current) {
                      // return (current is LoginCreateAccountState ||
                      //     current is LoginLoadingState ||
                      //     current is LoginErrorState ||
                      //     current is LoginSuccessState);
                      // },
                      builder: (context, state) {
                        final loginBloc = context.read<LoginBloc>();
                        return DefaultButton(
                          loading: state is LoginLoadingState,
                          text: "login".getLocale(context),
                          width: AppConstants.screenSize(context).width - 40,
                          marginTop: 30,
                          marginRight: 0,
                          marginLeft: 0,
                          marginBottom: 24,
                          borderRadius: 22,
                          function: () {
                            // loginBloc.isValidEmail(
                            //   email: loginBloc.emailController.text,
                            // );
                            // loginBloc.isValidPassword(
                            //   password: loginBloc.passwordController.text,
                            // );
                            if (state is! LoginLoadingState) {
                              var validationPassword =
                                  (loginBloc.passValidationState ==
                                      TextFieldValidation.valid);
                              var validationEmail =
                                  (loginBloc.emailValidationState ==
                                      TextFieldValidation.valid);
                              if (validationPassword && validationEmail) {
                                loginBloc.mapLoginEventToState(
                                    loginBloc.emailController.text,
                                    loginBloc.passwordController.text);
                              } else {
                                loginBloc.isValidEmail(
                                  email: loginBloc.emailController.text,
                                );
                                loginBloc.isValidPassword(
                                  password: loginBloc.passwordController.text,
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // const Spacer(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigate(
                            context: context,
                            screen: const SignUpScreen(),
                          ).off();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${"dontHaveAnAccount".getLocale(context)} ",
                              style: AppConstants.textTheme(context)
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'signup'.getLocale(context),
                              style: AppConstants.textTheme(context)
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.oldMainColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "contactUsIssue".getLocale(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchUrl("https://wa.me/+201270096399");
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.black,
                            child: Center(
                              child: Image.asset(
                                "assets/images/icons/whatsapp-icon-free-png.webp",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            _launchUrl(
                                "https://www.instagram.com/yousef_salama");
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.black,
                            child: Center(
                              child: Image.asset(
                                "assets/images/icons/Instagram_icon.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
