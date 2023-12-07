import 'package:json_annotation/json_annotation.dart';
part 'lessons_history_learn.g.dart';

// @JsonSerializable()
class LessonsHistoryLearnDto {
  final String courses;
  final String lessons;
  final double process;
  LessonsHistoryLearnDto(this.courses, this.lessons, this.process);
 
    factory LessonsHistoryLearnDto.fromJson(Map<String, dynamic> json) {
    return  _$LessonsHistoryLearnDtoFromJson(json);
  }
  Map<String, dynamic> toJson() => _$LessonsHistoryLearnDtoToJson(this);

}
