import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/authentications/auth_widgets.dart';
import 'package:gym/shared/extentions.dart';

import '../../../blocs/progress/progress_cubit.dart';
import '../../../shared/constants.dart';
import '../../../style/colors.dart';


class MeasurementTable extends StatelessWidget {
  MeasurementTable({
    super.key,
    required this.progressCubit,
  });

  final ProgressCubit progressCubit;

  final List<double> measurements = [0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Card(
        elevation: 3,
        color: AppColors.white,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'measurements'.getLocale(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  MeasurementsCard(
                      title: 'chest'.getLocale(context),
                      textEditingController: progressCubit.chestController),
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  MeasurementsCard(
                      title: "waist".getLocale(context),
                      textEditingController: progressCubit.waistController),
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  MeasurementsCard(
                      title: "thigh".getLocale(context),
                      textEditingController: progressCubit.thighController),
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  MeasurementsCard(
                      title: "arm".getLocale(context),
                      textEditingController: progressCubit.armController),
                  const Divider(
                    color: AppColors.lightGrey,
                  ),
                  MeasurementsCard(
                      title: "hips".getLocale(context),
                      textEditingController: progressCubit.hipsController),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProgressCubit, ProgressState>(
                buildWhen: (previous, current) =>
                    current is UploadMeasurementsLoadingState ||
                    current is UploadMeasurementsErrorState ||
                    current is UploadMeasurementsSuccessState,
                builder: (context, state) {
                  return Center(
                    child: state is UploadMeasurementsLoadingState
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (progressCubit.chestController.text.isNotEmpty ||
                                  progressCubit
                                      .waistController.text.isNotEmpty ||
                                  progressCubit
                                      .thighController.text.isNotEmpty ||
                                  progressCubit.armController.text.isNotEmpty ||
                                  progressCubit
                                      .hipsController.text.isNotEmpty) {
                                progressCubit.uploadMeasurementsProgress(
                                  context: context,
                                  userId: AppConstants.authRepository.user.id,
                                  chest: measurements[0],
                                  waist: measurements[1],
                                  thigh: measurements[2],
                                  arm: measurements[3],
                                  hips: measurements[4],
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              textStyle:
                                  AppConstants.textTheme(context).bodyMedium,
                            ),
                            child: Text(
                              'uploadMyMeasurements'.getLocale(context),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeasurementsCard extends StatelessWidget {
  const MeasurementsCard({
    super.key,
    required this.title,
    required this.textEditingController,
  });

  final String title;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          tileColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          trailing: SizedBox(
            width: 100,
            child: CustomTextField(
              validate: true,
              hint: "0.0",
              marginRight: 0,
              marginLeft: 0,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              textEditingController: textEditingController,
              onChange: (value) {},
              onSubmit: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
