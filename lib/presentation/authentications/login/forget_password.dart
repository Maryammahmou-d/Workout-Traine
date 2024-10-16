import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/login/login_bloc.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/enums.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../shared/widgets/snack_bar_widget.dart';
import '../auth_widgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    super.key,
    required this.loginBloc,
  });
  final LoginBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: Scaffold(
        body: SizedBox(
          width: AppConstants.screenSize(context).width,
          height: AppConstants.screenSize(context).height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'resetPassword'.getLocale(context),
                      style:
                          AppConstants.textTheme(context).titleLarge!.copyWith(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "resetPasswordHeader".getLocale(context),
                    style: AppConstants.textTheme(context).bodyLarge,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        current is EmailValidationState,
                    builder: (context, state) {
                      final loginBloc = context.read<LoginBloc>();
                      return EmailTextField(
                        focusNode: loginBloc.emailNode,
                        marginTop: 8,
                        marginBottom: 0,
                        marginLeft: 0,
                        marginRight: 0,
                        textInputAction: TextInputAction.next,
                        hint: "emailAddress".getLocale(context),
                        validateText: "thisEmailIsInvalid".getLocale(context),
                        onTap: () {},
                        fieldValidation: loginBloc.emailValidationState,
                        controller: loginBloc.emailController,
                        onChange: (value) => loginBloc.isValidEmail(
                          email: loginBloc.emailController.text,
                        ),
                        onSubmit: (String value) {
                          loginBloc.isValidEmail(
                            email: loginBloc.emailController.text,
                          );
                        },
                      );
                    },
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (listenContext, state) {
                      if (state is ResetPasswordErrorState) {
                        errorSnackBar(
                          context: context,
                          message: state.error,
                        );
                      }
                      if (state is ResetPasswordSuccessState) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      final loginBloc = context.read<LoginBloc>();
                      return DefaultButton(
                        loading: state is ResetPasswordLoadingState,
                        text: "reset".getLocale(context),
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
                          if (state is! ResetPasswordLoadingState) {
                            var validationEmail =
                                (loginBloc.emailValidationState ==
                                    TextFieldValidation.valid);
                            if (validationEmail) {
                              loginBloc.resetPassword(
                                loginBloc.emailController.text,
                              );
                            } else {
                              loginBloc.isValidEmail(
                                email: loginBloc.emailController.text,
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
