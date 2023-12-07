import 'package:dio/dio.dart';
import 'package:kidora/src/data/api/app-client.dart';
import 'package:kidora/src/data/api/endpoint.dart';
import 'package:kidora/src/data/baseDataSource/base_data_source.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/data/dtos/courses/courses.dart';

class CoursesDataSource extends BaseDataSource {
  Future<List<CoursesSameCategoryDto>> getCourse(
      Map<String, dynamic> query) async {
    Response response = await AppClient().getDio(
        endPoint: Endpoint.getInfoCoursesLessonsVideo,
        queryParameters: {"all": true, ...query});

    final List<dynamic> data = (response.data['data'] as List<dynamic>);
    final List<CoursesSameCategoryDto> convertData = data
        .map(
          (jsonCategory) => CoursesSameCategoryDto.fromJson(jsonCategory),
        )
        .toList();

    return convertData;
  }
}
