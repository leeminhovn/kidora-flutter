import 'package:kidora/src/data/data_source/courses.dart';

class CoursesRepo {
  // handle some middleware to Response
  //   Future<Either<Failure, UserEmailDto>> getAccount() async {
  //   return ResultMiddleHandler.checkResult(() async {
  //     return await dataSource.getAccount();
  //   });
  // }
  Future getCourse([Map<String, dynamic> query = const {}]) {
    return CoursesDataSource().getCourse(query);
  }

  Future getCoursesAll([Map<String, dynamic> query = const {}]) {
    return CoursesDataSource().getCourse(query);
  }
}
