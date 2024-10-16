import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';

import '../../shared/enums.dart';
import '../../style/colors.dart';

class EmailTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  // final double validatePadding;
  final String hint;
  final String validateText;
  final bool enabled;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final Function()? onTap;
  final TextCapitalization textCapitalization;
  final TextFieldValidation fieldValidation;
  final Iterable<String>? autofill;

  const EmailTextField({
    super.key,
    this.focusNode,
    this.marginTop = 32,
    this.marginLeft = 16,
    this.marginRight = 16,
    this.marginBottom = 0,
    this.autofill,
    this.hint = "Email",
    this.textInputAction = TextInputAction.next,
    // this.validatePadding = 20,
    this.enabled = true,
    required this.controller,
    this.validateText = 'This email is invalid',
    required this.onSubmit,
    this.textInputType = TextInputType.emailAddress,
    this.onChange,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    required this.fieldValidation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(
              right: marginRight,
              left: marginLeft,
              top: marginTop,
              bottom: marginBottom,
            ),
            height: 45,
            width: AppConstants.screenSize(context).width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: TextFormField(
              cursorColor: AppColors.mainBlack,
              focusNode: focusNode,
              onChanged: onChange,
              autocorrect: false,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              onFieldSubmitted: onSubmit,
              autofillHints: autofill,
              style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                    color: AppColors.mainBlack,
                    fontSize: 18,
                  ),
              controller: enabled ? controller : TextEditingController(),
              keyboardType: textInputType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppConstants.textTheme(context).bodySmall!.copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 12,
                  top: 18,
                  bottom: 24,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.regularGrey,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    color: AppColors.mainColor,
                  ),
                ),
                fillColor: Colors.white,
                enabled: enabled,
                filled: true,
                enabledBorder: (fieldValidation == TextFieldValidation.notValid)
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.red,
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
            ),
          ),
          if (fieldValidation == TextFieldValidation.notValid)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 2,
                top: 4,
              ),
              child: Text(
                validateText,
                style: AppConstants.textTheme(context).bodySmall!.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextFieldValidation fieldValidation;

  final bool enabled;
  final bool signup;
  final double marginRight;
  final double marginLeft;
  final double marginTop;
  final double marginBottom;
  final String? validateText;
  final String? hintText;
  final Function() onIconPress;
  final Function()? onTextFieldTap;
  final FocusNode? focusNode;
  final IconData iconData;
  final double validatePadding;
  final bool isObscureText;
  final Function(String value) onSubmit;
  final Function(String value) onChange;
  final Iterable<String>? autofill;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.fieldValidation,
    required this.onIconPress,
    required this.iconData,
    this.isObscureText = false,
    this.enabled = true,
    this.marginLeft = 16,
    this.marginRight = 16,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.validateText,
    this.validatePadding = 20,
    this.signup = false,
    this.onTextFieldTap,
    this.focusNode,
    this.hintText,
    this.autofill,
    required this.onSubmit,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTextFieldTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsetsDirectional.only(
              end: marginRight,
              start: marginLeft,
              top: marginTop,
              bottom: marginBottom,
            ),
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: TextFormField(
              cursorColor: AppColors.mainBlack,
              focusNode: focusNode,
              onChanged: onChange,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: onSubmit,
              obscureText: isObscureText,
              autofillHints: autofill,
              style: AppConstants.textTheme(context).bodySmall!.copyWith(
                    color: AppColors.mainBlack,
                  ),
              controller: enabled ? controller : TextEditingController(),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(iconData, size: 20),
                    onPressed: onIconPress,
                    color: AppColors.darkGrey,
                  ),
                ),
                hintText: hintText ?? 'password'.getLocale(context),
                hintStyle: AppConstants.textTheme(context).bodySmall!.copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                contentPadding: const EdgeInsetsDirectional.only(
                  start: 20,
                  top: 16,
                  bottom: 16,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.regularGrey,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    color: AppColors.mainColor,
                  ),
                ),
                fillColor: Colors.white,
                enabled: enabled,
                filled: true,
                enabledBorder: (fieldValidation == TextFieldValidation.notValid)
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.red,
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
            ),
          ),
          if (fieldValidation == TextFieldValidation.notValid &&
              validateText != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: validatePadding,
                  top: 4,
                ),
                child: Text(
                  validateText ?? '',
                  style: AppConstants.textTheme(context).bodySmall!.copyWith(
                        color: AppColors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  final double validatePadding;
  final String hint;

  final bool validate;
  final bool isNameValid;
  final String validateText;
  final bool enabled;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final Function()? onTap;
  final Widget? icon;
  final double? height;
  final double? width;
  final Color fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.hint = "Enter",
    this.textInputAction = TextInputAction.next,
    required this.validate,
    this.isNameValid = false,
    this.validatePadding = 40,
    this.enabled = true,
    required this.textEditingController,
    this.validateText = 'This name is already in use',
    required this.onSubmit,
    this.textInputType = TextInputType.text,
    this.onChange,
    this.onTap,
    this.icon,
    this.height = 48,
    this.width,
    this.inputFormatters,
    this.fillColor = AppColors.lightColor,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: marginTop,
        bottom: marginBottom,
        start: marginLeft,
        end: marginRight,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: height,
              width: width ?? double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: TextFormField(
                cursorColor: AppColors.mainBlack,
                focusNode: focusNode,
                showCursor: focusNode?.hasFocus,
                inputFormatters: inputFormatters,
                maxLines: height! ~/ 20,
                onChanged: onChange,
                textInputAction: textInputAction,
                onFieldSubmitted: onSubmit,
                style: AppConstants.textTheme(context).bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainBlack,
                    ),
                controller: textEditingController,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  suffixIcon: icon,
                  hintText: hint,
                  hintStyle:
                      AppConstants.textTheme(context).bodySmall!.copyWith(
                            color: AppColors.darkGrey,
                          ),
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 12,
                    bottom: 16,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.regularGrey,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: const BorderSide(
                      color: AppColors.mainColor,
                    ),
                  ),
                  fillColor: fillColor,
                  enabled: enabled,
                  filled: true,
                  enabledBorder: (!validate)
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.red,
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
              ),
            ),
            if (!validate)
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                ),
                child: Text(
                  validateText,
                  style: AppConstants.textTheme(context).bodySmall!.copyWith(
                        color: AppColors.red,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
