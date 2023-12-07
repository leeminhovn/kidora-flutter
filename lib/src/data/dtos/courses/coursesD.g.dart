// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesSameCategoryDto _$CoursesSameCategoryDtoFromJson(
        Map<String, dynamic> json) =>
    CoursesSameCategoryDto(
      json['_id'] as String,
      json['category'] as String,
      (json['courses'] as List<dynamic>)
          .map((e) => CourseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursesSameCategoryDtoToJson(
        CoursesSameCategoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'courses': instance.courses,
    };

CourseDto _$CourseDtoFromJson(Map<String, dynamic> json) => CourseDto(
    json['_id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['trailer'] as String,
    json['image'] as String,
    toDoubleFunc(json['rating']),
    json['users'] as int? ?? 0,
    json['totalVideos'] as int? ?? 0,
    json['price'] as int? ?? 0,
    (json['lessons'] as List<dynamic>)
        .map((e) => LessonDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['status'] as int? ?? 0);

Map<String, dynamic> _$CourseDtoToJson(CourseDto instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'trailer': instance.trailer,
      'image': instance.image,
      'rating': instance.rating,
      'users': instance.users,
      'totalVideos': instance.totalVideos,
      'price': instance.price,
      'lessons': instance.lessons,
    };

LessonDto _$LessonDtoFromJson(Map<String, dynamic> json) => LessonDto(
      json['_id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['image'] as String,
      (json['videos'] as List<dynamic>)
          .map((e) => VideoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonDtoToJson(LessonDto instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'videos': instance.videos,
    };

VideoDto _$VideoDtoFromJson(Map<String, dynamic> json) => VideoDto(
      json['_id'] as String,
      json['video'] as String,
      json['note'] as String,
    );

Map<String, dynamic> _$VideoDtoToJson(VideoDto instance) => <String, dynamic>{
      '_id': instance.id,
      'video': instance.video,
      'note': instance.note,
    };
