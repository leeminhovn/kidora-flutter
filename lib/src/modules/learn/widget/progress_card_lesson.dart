import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/modules/home/bloc/lessons_cubit.dart';

class ProgresCardLesson extends StatefulWidget {
  final StreamController<double> progressController;
  final double initalValue;
  const ProgresCardLesson({
    super.key,
    required this.progressController,
    required this.initalValue,
  });

  @override
  State<StatefulWidget> createState() => _ProgresCardLesson();
}

class _ProgresCardLesson extends State<ProgresCardLesson>
    with AutomaticKeepAliveClientMixin<ProgresCardLesson> {
  _ProgresCardLesson();
  double process = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        width: double.infinity,
        height: 10,
        decoration: BoxDecoration(
            color: AppColors.color_FFF4E0,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            StreamBuilder<double>(
                initialData: widget.initalValue,
                stream: widget.progressController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && process < snapshot.data!) {
                    process = snapshot.data!;
                    context
                        .read<LessonsCubit>()
                        .updateProcessCurrentLesson(snapshot.data!);
                  }
                  return Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: AppColors.color_ffd217,
                        borderRadius: BorderRadius.circular(5)),
                    width: max(constrains.maxWidth * process - 10, 10),
                  );
                }),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
                Positioned(
                  top: -5,
                  left: -10,
                  child: Image.asset("assets/icons/star_progress_lesson.png"),
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
