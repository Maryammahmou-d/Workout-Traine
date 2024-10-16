import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/progress/progress_cubit.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../shared/widgets/video_player.dart';
import '../../../style/colors.dart';

class MyTechniqueScreen extends StatelessWidget {
  const MyTechniqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressCubit()..getUserVideosProgress(context:context, userId: AppConstants.authRepository.user.id,),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            child: Stack(
              children: [
                 DefaultAppBarWithRadius(
                  screenTitle: "myTechnique".getLocale(context),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: BlocBuilder<ProgressCubit, ProgressState>(
                    builder: (context, state) {
                      ProgressCubit progressCubit =
                          context.read<ProgressCubit>();
                      return Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: state is GetUserVideosLoadingState
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
                                              child: DefaultVideoPlayer(
                                                  videoUrl: progressCubit
                                                      .userVideos[index]
                                                      .video),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              progressCubit
                                                  .userVideos[index]
                                                  .message,
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
                                        progressCubit.userVideos.length,
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Divider(
                                  color: AppColors.lightGrey,
                                ),
                                state is UploadUserVideosLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ProgressCubit>()
                                              .pickVideoFromGallery(
                                                  context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(140, 48),
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                AppColors.mainColor,
                                            textStyle:
                                                AppConstants.textTheme(
                                                        context)
                                                    .bodyMedium),
                                        child:  Text(
                                          'uploadVideo'.getLocale(context),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
