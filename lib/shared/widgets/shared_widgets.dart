import 'package:flutter/material.dart';
import 'package:gym/shared/constants.dart';

import '../../style/colors.dart';

Widget defaultLoading({
  Color color = AppColors.mainBlack,
}) {
  return CircularProgressIndicator(
    color: color,
  );
}

class DefaultButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Function() function;
  final double height;
  final double width;
  final double borderRadius;
  final double marginTop;
  final double marginBottom;
  final double marginRight;
  final double marginLeft;
  final bool loading;
  final String text;
  final Border? border;
  final Widget? textWidget;
  const DefaultButton({
    super.key,
    required this.function,
    this.color = AppColors.oldMainColor,
    this.textColor = Colors.white,
    this.height = 44,
    this.width = double.infinity,
    this.marginTop = 40,
    this.marginBottom = 24,
    this.text = 'Login',
    this.border,
    this.borderRadius = 8,
    this.marginRight = 36,
    this.marginLeft = 36,
    this.loading = false,
    this.textWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        top: marginTop,
        bottom: marginBottom,
        right: marginRight,
        left: marginLeft,
      ),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: function,
        child: Center(
          child: loading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: defaultLoading(color: Colors.white),
                )
              : textWidget ??
                  Text(
                    text,
                    style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                          color: textColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.screenTitle,
  });

  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      title: Text(
        screenTitle,
        style: AppConstants.textTheme(context).titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DefaultWhiteContainer extends StatelessWidget {
  const DefaultWhiteContainer({
    super.key,
    required this.child,
    this.height,
    this.margin = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 30,
    ),
  });
  final Widget child;
  final double? height;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: AppConstants.screenSize(context).width - 40,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Shadow color
            blurRadius: 8.0, // Blur radius
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      color: AppColors.lightGrey,
      thickness: 1,
    );
  }
}

class DefaultAppBarWithRadius extends StatelessWidget {
  const DefaultAppBarWithRadius({
    super.key,
    required this.screenTitle,
    this.withBackArrow = true,
    this.suffixIcon,
    this.titleWidget,
    this.onBackTapped,
    this.prefixIcon,
    this.height = 90,
  });

  final double height;
  final String screenTitle;
  final bool withBackArrow;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? titleWidget;
  final void Function()? onBackTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Stack(
          children: [
            if (prefixIcon != null)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: prefixIcon,
              ),
            if (withBackArrow)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: onBackTapped ??
                      () {
                        Navigator.pop(context);
                      },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 19,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: titleWidget ??
                  Text(
                    screenTitle,
                    style:
                        AppConstants.textTheme(context).titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                  ),
            ),
            if (suffixIcon != null)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: suffixIcon!,
              ),
          ],
        ),
      ),
    );
  }
}

class DefaultContainerWithAppBar extends StatelessWidget {
  const DefaultContainerWithAppBar({
    super.key,
    required this.children,
    required this.screenTitle,
    this.withBackArrow = true,
    this.containerColor = Colors.white,
    this.child,
    this.headerIcon,
    this.onBackTapped,
  });
  final List<Widget> children;
  final Widget? child;
  final Widget? headerIcon;
  final String screenTitle;
  final bool withBackArrow;
  final Color containerColor;
  final void Function()? onBackTapped;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.screenSize(context).width,
      height: AppConstants.screenSize(context).height,
      child: Stack(
        children: [
          DefaultAppBarWithRadius(
            onBackTapped: onBackTapped,
            suffixIcon: headerIcon,
            screenTitle: screenTitle,
            withBackArrow: withBackArrow,
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            margin: const EdgeInsets.only(top: 70.0),
            width: AppConstants.screenSize(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: containerColor,
            ),
            child: child ??
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: children,
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
