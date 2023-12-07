// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_history_learn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonsHistoryLearnDto _$LessonsHistoryLearnDtoFromJson(
        Map<String, dynamic> json) =>
    LessonsHistoryLearnDto(
      json['courses'] as String,
      json['lessons'] as String,
      (json['process'] as num).toDouble(),
    );

Map<String, dynamic> _$LessonsHistoryLearnDtoToJson(
        LessonsHistoryLearnDto instance) =>
    <String, dynamic>{
      'course': instance.courses,
      'lessons': instance.lessons,
      'process': instance.process,
    };
