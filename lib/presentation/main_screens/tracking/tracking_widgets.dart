import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/shared/extentions.dart';

import '../../../blocs/tracking/tracking_cubit.dart';
import '../../../shared/constants.dart';
import '../../../style/colors.dart';

class LbsAndRepsValue extends StatefulWidget {
  const LbsAndRepsValue({
    super.key,
    required this.value,
    required this.workoutIndex,
    required this.index,
    this.isLbs = true,
  });

  final int value;
  final int workoutIndex;
  final int index;
  final bool isLbs;

  @override
  State<LbsAndRepsValue> createState() => _LbsAndRepsValueState();
}

class _LbsAndRepsValueState extends State<LbsAndRepsValue> {
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController repsCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 70,
      margin: const EdgeInsets.only(top: 4),
      color: AppColors.lightGrey,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 12),
            hintStyle: AppConstants.textTheme(context).bodyMedium!.copyWith(
                  color: AppColors.black.withOpacity(0.5),
                ),
            hintText: widget.isLbs
                ? context
                    .read<TrackingCubit>()
                    .selectedWorkouts[widget.workoutIndex]
                    .lbsAndReps[widget.index]
                    .lbs
                    .toString()
                : context
                    .read<TrackingCubit>()
                    .selectedWorkouts[widget.workoutIndex]
                    .lbsAndReps[widget.index]
                    .reps
                    .toString(),
          ),
          controller: widget.isLbs ? weightCtrl : repsCtrl,
          style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                color: AppColors.black,
              ),
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          onChanged: (value) {
            if (widget.isLbs) {
              context.read<TrackingCubit>().editSet(
                    index: widget.index,
                    workoutIndex: widget.workoutIndex,
                    lbs: int.tryParse(value) ?? 0,
                  );
            } else {
              context.read<TrackingCubit>().editSet(
                    index: widget.index,
                    workoutIndex: widget.workoutIndex,
                    reps: int.tryParse(value) ?? 0,
                  );
            }
          },
          onSubmitted: (value) {
            if (widget.isLbs) {
              context.read<TrackingCubit>().editSet(
                    index: widget.index,
                    workoutIndex: widget.workoutIndex,
                    lbs: int.tryParse(value) ?? 0,
                  );
            } else {
              context.read<TrackingCubit>().editSet(
                    index: widget.index,
                    workoutIndex: widget.workoutIndex,
                    reps: int.tryParse(value) ?? 0,
                  );
            }
          },
        ),
      ),
    );
  }
}

void showAddSetDialog(
  BuildContext context,
  int index,
  TrackingCubit trackingCubit,
) {
  TextEditingController lbsController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext _) {
      return AlertDialog(
        title: Text("addSet".getLocale(context)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: lbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'kg'.getLocale(context)),
            ),
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'reps'.getLocale(context)),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'.getLocale(context)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('add'.getLocale(context)),
            onPressed: () {
              // final int lbs = int.tryParse(lbsController.text) ?? 0;
              // final int reps = int.tryParse(repsController.text) ?? 0;
              //
              // context.read<TrackingCubit>().addNewSet(index, lbs, reps);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
