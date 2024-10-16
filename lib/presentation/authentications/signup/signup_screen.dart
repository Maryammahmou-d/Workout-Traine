import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/signup/signup_bloc.dart';
import 'package:gym/presentation/authentications/login/login_screen.dart';
import 'package:gym/presentation/authentications/signup/questionnaire_screen.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/enums.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/snack_bar_widget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../shared/navigate_functions.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';
import '../auth_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    Center(
                      child: Image.asset(
                        'assets/logo-main.png',
                        width: 180,
                        scale: 1,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        child: Text(
                          'joinUs'.getLocale(context),
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
                        'name'.getLocale(context),
                        style:
                            AppConstants.textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (previous, current) =>
                          current is UserNameValidationState,
                      builder: (context, state) {
                        final signupBloc = context.read<SignUpBloc>();
                        return EmailTextField(
                          focusNode: signupBloc.usernameNode,
                          marginTop: 8,
                          marginBottom: 0,
                          marginLeft: 0,
                          marginRight: 0,
                          textInputAction: TextInputAction.next,
                          hint: 'name'.getLocale(context),
                          validateText:
                              "nameCannotBeLessThan3".getLocale(context),
                          onTap: () {},
                          fieldValidation: signupBloc.userNameValidationState,
                          controller: signupBloc.usernameController,
                          onChange: (value) => signupBloc.isValidUsername(
                            username: signupBloc.usernameController.text,
                          ),
                          onSubmit: (String value) {
                            signupBloc.isValidUsername(
                              username: signupBloc.usernameController.text,
                            );
                            FocusScope.of(context).nextFocus();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8),
                      child: Text(
                        'phoneNumber'.getLocale(context),
                        style:
                            AppConstants.textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      height: 44,
                      child: BlocBuilder<SignUpBloc, SignUpState>(
                        buildWhen: (previous, current) =>
                            current is PhoneValidationState,
                        builder: (context, state) {
                          final signUpBloc = context.read<SignUpBloc>();
                          return InternationalPhoneNumberInput(
                            initialValue: PhoneNumber(
                              dialCode: "+20",
                              isoCode: "EG",
                            ),
                            //spaceBetweenSelectorAndTextField: 20,
                            selectorConfig: const SelectorConfig(
                              showFlags: false,
                              trailingSpace: false,
                              setSelectorButtonAsPrefixIcon: true,
                            ),
                            selectorTextStyle: AppConstants.textTheme(context)
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.oldMainColor,
                                ),
                            textAlignVertical: TextAlignVertical.center,
                            inputDecoration: InputDecoration(
                              hintText: 'phoneNumber'.getLocale(context),
                              hintStyle: AppConstants.textTheme(context)
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                              contentPadding: const EdgeInsets.only(
                                bottom: 4,
                              ),
                              enabledBorder: signUpBloc.phoneValidationState ==
                                      TextFieldValidation.notValid
                                  ? OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                    )
                                  : OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.regularGrey,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                              border: signUpBloc.phoneValidationState ==
                                      TextFieldValidation.notValid
                                  ? OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                    )
                                  : OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.regularGrey,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                            ),
                            textStyle: AppConstants.textTheme(context)
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.black,
                                ),
                            inputBorder: signUpBloc.phoneValidationState ==
                                    TextFieldValidation.notValid
                                ? OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  )
                                : OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.regularGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                            onInputChanged: (value) {
                              signUpBloc.isPhoneValid(
                                  phoneNumber: value.phoneNumber!);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 22,
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
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (previous, current) =>
                          current is EmailValidationState,
                      builder: (context, state) {
                        final signupBloc = context.read<SignUpBloc>();
                        return EmailTextField(
                          focusNode: signupBloc.emailNode,
                          marginTop: 8,
                          marginBottom: 0,
                          marginLeft: 0,
                          marginRight: 0,
                          textInputAction: TextInputAction.next,
                          hint: 'emailAddress'.getLocale(context),
                          validateText: "thisEmailIsInvalid".getLocale(context),
                          onTap: () {},
                          fieldValidation: signupBloc.emailValidationState,
                          controller: signupBloc.emailController,
                          onChange: (value) => signupBloc.isValidEmail(
                            email: signupBloc.emailController.text,
                          ),
                          onSubmit: (String value) {
                            signupBloc.isValidEmail(
                              email: signupBloc.emailController.text,
                            );
                            FocusScope.of(context).nextFocus();
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
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (previous, current) {
                        return (current is PasswordVisibilityState ||
                            current is PasswordValidationState);
                      },
                      builder: (context, state) {
                        final signupBloc = context.read<SignUpBloc>();
                        return PasswordTextField(
                          focusNode: signupBloc.passNode,
                          fieldValidation: signupBloc.passValidationState,
                          controller: signupBloc.passwordController,
                          marginTop: 8,
                          marginLeft: 0,
                          marginRight: 0,
                          validatePadding: 0,
                          onChange: (pass) {
                            signupBloc.isValidPassword(
                              password: pass,
                            );
                          },
                          onSubmit: (pass) => signupBloc.isValidPassword(
                            password: pass,
                          ),
                          isObscureText: !signupBloc.isPassVisible,
                          onIconPress: () {
                            signupBloc.add(const ChangePassVisibilityEvent());
                          },
                          onTextFieldTap: () {},
                          validateText:
                              "passwordMustBeAtLeast8".getLocale(context),
                          iconData: signupBloc.isPassVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        );
                      },
                    ),
                    BlocConsumer<SignUpBloc, SignUpState>(
                      listener: (listenContext, state) {
                        if (state is SignUpErrorState) {
                          errorSnackBar(
                            context: context,
                            message: state.response,
                          );
                        }
                        if (state is SignUpSuccessState) {
                          Navigate(
                            screen: QuestionnaireScreen(
                              token: state.token,
                              userId: state.userId,
                            ),
                            context: context,
                          ).off();
                        }
                      },
                      builder: (buildContext, state) {
                        final signupBloc = buildContext.read<SignUpBloc>();
                        return DefaultButton(
                          loading: state is SignUpLoadingState,
                          text: "signup".getLocale(context),
                          width: AppConstants.screenSize(context).width - 40,
                          marginTop: 30,
                          marginRight: 0,
                          marginLeft: 0,
                          marginBottom: 24,
                          borderRadius: 22,
                          function: () async {
                            var valUsername =
                                (signupBloc.userNameValidationState ==
                                    TextFieldValidation.valid);
                            var valEmail = (signupBloc.emailValidationState ==
                                TextFieldValidation.valid);
                            var valPassword = (signupBloc.passValidationState ==
                                TextFieldValidation.valid);
                            var valPhone = (signupBloc.phoneValidationState ==
                                TextFieldValidation.valid);

                            if (valUsername &&
                                valEmail &&
                                valPassword &&
                                valPhone) {
                              await signupBloc
                                  .mapSingUPEventToState(SignUpUserEvent(
                                signupBloc.usernameController.text,
                                signupBloc.emailController.text,
                                signupBloc.passwordController.text,
                                signupBloc.phoneController.text,
                              ));
                            } else {
                              signupBloc.isValidUsername(
                                username: signupBloc.usernameController.text,
                              );
                              signupBloc.isValidEmail(
                                email: signupBloc.emailController.text,
                              );
                              signupBloc.isValidPassword(
                                password: signupBloc.passwordController.text,
                              );
                              signupBloc.isPhoneValid(
                                phoneNumber: signupBloc.passwordController.text,
                              );
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
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            Navigate(
                              context: context,
                              screen: const LoginScreen(),
                            ).off();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${"alreadyHaveAnAccount".getLocale(context)} ",
                                style: AppConstants.textTheme(context)
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'login'.getLocale(context),
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
