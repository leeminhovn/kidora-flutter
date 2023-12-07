part of 'courses_cubit.dart';

abstract class CoursesState {
  List<CoursesSameCategoryDto> coursesSameCategory = [];
  List<CoursesSameCategoryDto> coursesSameCategoryAll = [];
  CourseDto? currentCourse;

  copy(CoursesState state) {
    coursesSameCategory = state.coursesSameCategory;
    coursesSameCategoryAll = state.coursesSameCategoryAll;
    currentCourse = state.currentCourse;
  }
}

class CoursesInital extends CoursesState {
  CoursesInital() : super();
}

class CoursesLoading extends CoursesState {
  CoursesLoading(CoursesState state) {
    copy(state);
  }
}

class CoursesLoaded extends CoursesState {
  CoursesLoaded(CoursesState state) {
    copy(state);
  }
}

class CoursesReset extends CoursesState {
  CoursesReset(CoursesState state) {
    copy(state);
  }
}

class CoursesDoneLoadAll extends CoursesState {
  CoursesDoneLoadAll(CoursesState state) {
    copy(state);
  }
}

class coursesDonecallAllCoursesLoading extends CoursesState {
  coursesDonecallAllCoursesLoading(CoursesState state) {
    copy(state);
  }
}

class coursesDonecallAllCourses extends CoursesState {
  coursesDonecallAllCourses(CoursesState state) {
    copy(state);
  }
}
