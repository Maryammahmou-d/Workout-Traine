import 'package:animated_toggle/animated_toggle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/localization/cubit/localization_cubit.dart';
import 'package:gym/blocs/progress/progress_cubit.dart';
import 'package:gym/presentation/main_screens/progress/progress_widgets.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/shared_widgets.dart';

import '../../../shared/constants.dart';
import '../../../style/colors.dart';

class MyProgressScreen extends StatelessWidget {
  const MyProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProgressCubit>(
      create: (context) => ProgressCubit()
        ..getUserImagesProgress(
          context: context,
          userId: AppConstants.authRepository.user.id,
        )
        ..clearMeasurementsControllers(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            child: Stack(
              children: [
                DefaultAppBarWithRadius(
                  screenTitle: "myProgress".getLocale(context),
                ),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) {
                    ProgressCubit progressCubit = context.read<ProgressCubit>();
                    return Container(
                      padding: const EdgeInsets.only(top: 16),
                      margin: const EdgeInsets.only(top: 70.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: AnimatedHorizontalToggle(
                              taps: [
                                'images'.getLocale(context),
                                'measurements'.getLocale(context),
                              ],
                              width: MediaQuery.of(context).size.width - 32,
                              height: 48,
                              duration: const Duration(milliseconds: 70),
                              initialIndex: progressCubit.toggleIndex,
                              background: Colors.black.withOpacity(0.1),
                              activeColor: AppColors.black,
                              activeTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.oldMainColor,
                              ),
                              inActiveTextStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                              horizontalPadding: 4,
                              verticalPadding: 4,
                              activeHorizontalPadding: 2,
                              activeVerticalPadding: 4,
                              radius: 14,
                              activeButtonRadius: 14,
                              onChange: (int currentIndex, int targetIndex) {
                                progressCubit
                                    .changeToggleIndexValue(targetIndex);
                              },
                              showActiveButtonColor: true,
                              local: context
                                  .watch<LocalizationCubit>()
                                  .state
                                  .locale
                                  .languageCode,
                            ),
                          ),
                          if (progressCubit.toggleIndex == 0)
                            Expanded(
                              flex: 4,
                              child: state is GetUserImagesLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: CachedNetworkImage(
                                                  imageUrl: progressCubit
                                                      .userImages[index].video,
                                                  // placeholder: (context, url) {
                                                  //   return const Center(
                                                  //     child:
                                                  //         CircularProgressIndicator(),
                                                  //   );
                                                  // },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                progressCubit
                                                    .userImages[index].message,
                                                style: AppConstants.textTheme(
                                                        context)
                                                    .bodyLarge!.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 16,
                                      ),
                                      itemCount:
                                          progressCubit.userImages.length,
                                    ),
                            ),
                          if (progressCubit.toggleIndex == 0)
                            Expanded(
                              child: state is UploadUserImagesLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                progressCubit
                                                    .pickImageFromGallery(
                                                        context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  textStyle:
                                                      AppConstants.textTheme(
                                                              context)
                                                          .bodyMedium),
                                              child: Text(
                                                'uploadBodyPic'
                                                    .getLocale(context),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                progressCubit
                                                    .pickImageFromGallery(
                                                        context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  textStyle:
                                                      AppConstants.textTheme(
                                                              context)
                                                          .bodyMedium),
                                              child: Text(
                                                'uploadInBodyPic'
                                                    .getLocale(context),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          if (progressCubit.toggleIndex == 1)
                            Expanded(
                              flex: 4,
                              child: MeasurementTable(
                                progressCubit: progressCubit,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
