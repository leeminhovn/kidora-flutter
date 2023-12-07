import 'package:dio/dio.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/api/app-client.dart';
import 'package:kidora/src/data/api/endpoint.dart';
import 'package:kidora/src/data/baseDataSource/base_data_source.dart';

import 'package:kidora/src/data/dtos/lessons/lessons_history_learn.dart';

class LessonDataSource extends BaseDataSource {
  Future<List<LessonsHistoryLearnDto>> getResultUser(
      Map<String, dynamic> query) async {
    Response response = await AppClient().getDio(
        endPoint: Endpoint.getLearnProgressUser, queryParameters: {...query});
    if (response.data['code'] == 1) {
      final List<dynamic> data = (response.data['data'] as List<dynamic>);
      final List<LessonsHistoryLearnDto> convertData = data
          .map(
            (jsonCategory) => LessonsHistoryLearnDto.fromJson(jsonCategory),
          )
          .toList();
      return convertData;
    } else {
      return [];
    }
  }

  Future<bool> saveLearnUser(String courseId, String lessonId,
      List<double> process, String token) async {
    Response response = await AppClient().postDioAuth(
        endPoint: Endpoint.saveLearnResult,
        accessToken: token,
        data: {"courseId": courseId,
         "lessonId": lessonId, 
         "process": process});



    if (response.data['code'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
