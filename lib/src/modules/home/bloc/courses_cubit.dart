import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/config/router_name.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';
import 'package:kidora/src/domain/repositories/courses_repository.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInital()) {
    initListCourse();
  }

  void initListCourse() async {
    emit(CoursesLoading(state));
  }

  Future getCoursesAll({
    required String email,
    void Function()? success,
  }) async {
    emit(coursesDonecallAllCoursesLoading(state));
    await Future.delayed(const Duration(seconds: 1));

    Map<String, dynamic> queryCoruses = {};
    queryCoruses.addAll({'email': email, 'page': 1, 'limit': 10000});

    if (success != null) {
      success();
    }
    List<CoursesSameCategoryDto> dataCourse =
        await CoursesRepo().getCourse(queryCoruses);

    if (dataCourse.isEmpty) {
      print('empty data courses');
    } else {
      state.coursesSameCategoryAll = dataCourse;
      emit(coursesDonecallAllCourses(state));
    }
  }

  openCourse(CourseDto currentCourseOpen, BuildContext context) {
    state.currentCourse = currentCourseOpen;
    context.push(ApplicationRouteName.learn);
  }

  Future getCourses({
    required String email,
    int page = 1,
    int limit = 1,
    void Function()? success,
  }) async {
    emit(CoursesLoading(state));
    await Future.delayed(const Duration(seconds: 1));

    Map<String, dynamic> queryCoruses = {};
    queryCoruses.addAll({'email': email, 'page': page, 'limit': limit});

    if (success != null) {
      success();
    }
    List<CoursesSameCategoryDto> dataCourse =
        await CoursesRepo().getCourse(queryCoruses);

    if (dataCourse.isEmpty) {
      emit(CoursesDoneLoadAll(state));
    } else {
      state.coursesSameCategory = [...state.coursesSameCategory, ...dataCourse];
      emit(CoursesLoaded(state));
    }
  }

  resetCourse() {
    state.coursesSameCategoryAll = [];
    state.coursesSameCategory = [];
    emit(CoursesReset(state));
  }
}
