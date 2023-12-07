import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/data/dtos/lessons/lessons_history_learn.dart';
import 'package:kidora/src/domain/repositories/lesson_repository.dart';
part './lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());

  callHistoryLearnLesson(CourseDto currentCourse, String email) async {
    state.currentCourse = currentCourse;
    List<LessonsHistoryLearnDto> currentHistoryCourse;
    if (email == '') {
      if (UserLocalStorge.store.getString('user_learn_local') != null) {
        List<dynamic> listLearnLocal = jsonDecode(
            UserLocalStorge.store.getString('user_learn_local') ?? '');
        currentHistoryCourse = listLearnLocal
            .map((e) => LessonsHistoryLearnDto.fromJson(e))
            .toList();
      } else {
        currentHistoryCourse = [];
      }
    } else {
      List<LessonsHistoryLearnDto> data = await LessonRepository()
          .getResultUser({"email": email, "courseId": currentCourse.id});
      // call api

      currentHistoryCourse = data;
    }
    currentHistoryCourse = currentHistoryCourse
        .where((LessonsHistoryLearnDto courseHistory) =>
            courseHistory.courses == currentCourse.id)
        .toList();

    final List<InfoProcess> learnHistory = [];
    for (var lesson in currentCourse.lessons) {
      double sameResult;

      try {
        sameResult = currentHistoryCourse.firstWhere((lessonHistory) {
          return lessonHistory.lessons == lesson.id;
        }).process;
      } catch (err) {
        sameResult = 0;
      }
      learnHistory
          .add(InfoProcess(process: sameResult, isDone: sameResult >= 90));
    }
    await Future.delayed(const Duration(microseconds: 50));
    emit(FinallyUpdateLessons(state)..progressLessons = learnHistory);
  }

  changeLesson(int newIndexLessonId, [bool isCallFromCLose = false]) async {
    if (!isCallFromCLose) emit(LessonChangeIng(state));
  
   

    if (state.currentProcessLearnLessons * 100 >
        state.progressLessons[state.currentLessonIdx].process) {
      state.progressLessons[state.currentLessonIdx].process =
          state.currentProcessLearnLessons;
      String accessToken = UserLocalStorge.store.getString('accessToken') ?? '';
      if (accessToken != '') {
        LessonRepository().saveLearnUser(
            state.currentCourse!.id,
            state.currentCourse!.lessons[state.currentLessonIdx].id,
            [state.currentProcessLearnLessons * 100],
            accessToken);
      } else {
        String learnLocal =
            UserLocalStorge.store.getString("user_learn_local") ?? '';
        if (learnLocal != '') {
          List<dynamic> dataLocal = json.decode(
              (UserLocalStorge.store.getString("user_learn_local") ?? ''));
          String idLessonNeedFind =
              state.currentCourse!.lessons[state.currentLessonIdx].id;
          int indexSameLearn = dataLocal
              .indexWhere((element) => element['lessons'] == idLessonNeedFind);

          if (indexSameLearn != -1) {
            double oldLearn = dataLocal[indexSameLearn]['process'];
            double newLearn = state.currentProcessLearnLessons * 100;
            if (oldLearn < newLearn) {
              dataLocal[indexSameLearn]['process'] = newLearn;
            }
          } else {
            dataLocal.add({
              "courses": state.currentCourse!.id,
              "lessons":
                  state.currentCourse!.lessons[state.currentLessonIdx].id,
              "process": state.currentProcessLearnLessons * 100
            });
          }
          UserLocalStorge.store
              .setString('user_learn_local', jsonEncode(dataLocal));
        } else {

          UserLocalStorge.store.setString(
            "user_learn_local",
            json.encode(
              [
                {
                  "courses": state.currentCourse!.id,
                  "lessons":
                      state.currentCourse!.lessons[state.currentLessonIdx].id,
                  "process": state.currentProcessLearnLessons * 100
                }
              ],
            ),
          );
        }
      }
    }

    state.currentProcessLearnLessons = 0;
    state.currentLessonIdx = newIndexLessonId;

    if (!isCallFromCLose) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(LessonChange(state));
    }
  }

  updateProcessCurrentLesson(double value) {
    state.currentProcessLearnLessons = value;
    if (value >= 0.9 &&
        state.progressLessons[state.currentLessonIdx].isDone == false) {
      state.progressLessons[state.currentLessonIdx].isDone = true;
      emit(UpdateDoneLesson(state));
    }
  }

  @override
  Future<void> close() {
    changeLesson(0, true);
    // Được gọi khi widget được dispose.
    // Thực hiện các hành động cần thiết trước khi dispose, ví dụ: đóng kết nối, giải phóng tài nguyên, v.v.
    return super.close();
  }
}
