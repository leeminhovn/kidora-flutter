import 'package:kidora/src/data/data_source/lesson.dart';
import 'package:kidora/src/data/dtos/lessons/lessons_history_learn.dart';

class LessonRepository {
  Future<List<LessonsHistoryLearnDto>> getResultUser(
      [Map<String, dynamic> query = const {}]) {
    return LessonDataSource().getResultUser(query);
  }

  Future<bool> saveLearnUser(
      String courseId, String lessonId, List<double> process, String token) {
    return LessonDataSource().saveLearnUser(courseId, lessonId, process, token);
  }
}
