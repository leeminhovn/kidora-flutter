import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kidora/src/components/oragnisms/appBarCustom.dart';
import 'package:kidora/src/components/oragnisms/loading/loading_green.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';

import 'package:kidora/src/general/app_colors.dart';
import 'package:kidora/src/modules/home/bloc/account_cubit.dart';
import 'package:kidora/src/modules/home/bloc/courses_cubit.dart';
import 'package:kidora/src/modules/home/bloc/lessons_cubit.dart';
import 'package:kidora/src/modules/learn/components/streamControllerManager.dart';
import 'package:kidora/src/modules/learn/widget/learn_page_top.dart';
import 'package:kidora/src/modules/learn/widget/main_play_video.dart';
import 'package:kidora/src/modules/learn/widget/note_footer_video.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<StatefulWidget> createState() => _LearnPage();
}

class _LearnPage extends State<LearnPage> {
  final ManagerStreamBuilder managerStream = ManagerStreamBuilder();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentCourse =
        BlocProvider.of<CoursesCubit>(context).state.currentCourse;
    int countStreamControlelr = currentCourse!.lessons.length;

    for (int i = 0; i < countStreamControlelr; i++) {
      final StreamController<double> progressController =
          StreamController<double>.broadcast();

      managerStream.registerStreamBuilder(progressController);
    }

    final String email = context.read<AccountCubit>().state.email;
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(),
        body: Container(
          color: AppColors.color_F4F5FB,
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<LessonsCubit, LessonsState>(
              builder: (context, state) {
            if (state is LessonsInitial) {
              context
                  .read<LessonsCubit>()
                  .callHistoryLearnLesson(currentCourse, email);
              // use in this code
            }

            if (state is FinallyUpdateLessons ||
                state is LessonChange ||
                state is LessonChangeIng ||
                state is UpdateDoneLesson) {
              return SingleChildScrollView(
                child: Column(children: [
                  LearnPageTop(
                      currentCourse, managerStream, state.progressLessons),
                  (state.runtimeType != LessonChangeIng)
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: MainPlayVideo(
                              currentControllerProgressCard: managerStream
                                  .listStreamBuilder[state.currentLessonIdx]),
                        )
                      : const AspectRatio(
                          aspectRatio: 16 / 9,
                          child:
                              SizedBox(child: Center(child: LoadingGreen()))),
                  NoteFooterVideo(
                      note: currentCourse
                          .lessons[state.currentLessonIdx].videos[0].note)
                ]),
              );
            }
            return const Center(child: LoadingGreen());
          }),
        ),
      ),
    );
  }
}
