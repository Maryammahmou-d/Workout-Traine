import 'package:flutter/material.dart';
import 'package:gym/shared/extentions.dart';
import 'package:intl/intl.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';
import '../settings/settings_widgets.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: "subscription".getLocale(context),
          children: const [],
          child: Container(
            width: AppConstants.screenSize(context).width - 40,
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
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
            child: Column(
              children: [
                ProfileRow(
                  title: "subscriptionStartDate".getLocale(context),
                  value: DateFormat('EEE, dd-MM-yyyy')
                      .format(
                          AppConstants.authRepository.user.enrollmentStartDate)
                      .toString(),
                  onTap: () {},
                ),
                const Divider(
                  height: 0,
                  color: AppColors.lightGrey,
                  thickness: 1,
                ),
                ProfileRow(
                  title: "subscriptionEndDate".getLocale(context),
                  value: DateFormat('EEE, dd-MM-yyyy')
                      .format(
                          AppConstants.authRepository.user.enrollmentExpireDate)
                      .toString(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
