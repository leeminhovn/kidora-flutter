part of './lessons_cubit.dart';

abstract class LessonsState {
  int currentLessonIdx = 0;
  double currentProcessLearnLessons = 0.0;
  CourseDto? currentCourse;
  List<InfoProcess> progressLessons = [];

  copy(LessonsState state) {
    currentLessonIdx = state.currentLessonIdx;
    progressLessons = state.progressLessons;
    currentCourse = state.currentCourse;
    currentProcessLearnLessons = state.currentProcessLearnLessons;
  }
}

class LessonsInitial extends LessonsState {
  // call api lấy ra các progress đã lưu trên server của lesson
}

class FinallyUpdateLessons extends LessonsState {
  FinallyUpdateLessons(LessonsState state) {
    super.copy(state);
  }
}

class LessonChange extends LessonsState {
  //Thực hiện khi cần thay đổi current lesson

  LessonChange(LessonsState state) {
    super.copy(state);
  }
}

class LessonChangeIng extends LessonsState {
  //Thực hiện khi cần thay đổi current lesson

  LessonChangeIng(LessonsState state) {
    super.copy(state);
  }
}

class LessonsReset extends LessonsState {
  LessonsReset(LessonsState state) {
    super.copy(state);
  }
}

class UpdateDoneLesson extends LessonsState {
  UpdateDoneLesson(LessonsState state) {
    super.copy(state);
  }
}

class InfoProcess {
  double process;
  bool isDone;
  InfoProcess({required this.process, required this.isDone});
}
