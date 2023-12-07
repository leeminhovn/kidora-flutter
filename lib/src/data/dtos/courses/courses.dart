import 'package:json_annotation/json_annotation.dart';

part 'coursesD.g.dart';

double toDoubleFunc(String number) {
  return double.parse(number);
}

class CoursesSameCategoryDto {
  @JsonKey(name: '_id')
  final String id;

  final String category;
  final List<CourseDto> courses;
  CoursesSameCategoryDto(this.id, this.category, this.courses);
  factory CoursesSameCategoryDto.fromJson(Map<String, dynamic> json) {
    return _$CoursesSameCategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoursesSameCategoryDtoToJson(this);
}

class CourseDto {
  @JsonKey(name: '_id')
  final String id;

  final String title;
  final String description;
  final String trailer;
  final String image;
  final double rating;
  @JsonKey(defaultValue: 0)
  final int status;
  @JsonKey(defaultValue: 0)
  final int users;
  @JsonKey(defaultValue: 0)
  final int totalVideos;
  @JsonKey(defaultValue: 0)
  final int price;
  final List<LessonDto> lessons;
  // "_id": "6455c2e1e604d5b6c1855231",
  //             "title": "Khoá học vẽ hình 3D cùng Andee Xoài",
  //             "description": "Andee Xoài không chỉ ăn khỏe mà còn vẽ rất đẹp luôn nha",
  //             "trailer": "821920108?h=8bde04a443&badge=0&autopause=0&player_id=0&app_id=58479",
  //             "image": "khoa-3d.png",
  //             "rating": "4.9",
  //             "users": 1201,
  //             "totalVideos": 10,
  //             "price": null,
  CourseDto(
      this.id,
      this.title,
      this.description,
      this.trailer,
      this.image,
      this.rating,
      this.users,
      this.totalVideos,
      this.price,
      this.lessons,
      this.status);
  factory CourseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDtoToJson(this);
}

class LessonDto {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final String image;
  final List<VideoDto> videos;
  LessonDto(this.id, this.title, this.description, this.image, this.videos);
  factory LessonDto.fromJson(Map<String, dynamic> json) =>
      _$LessonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDtoToJson(this);
}

class VideoDto {
  @JsonKey(name: '_id')
  final String id;
  final String video;
  final String note;
  VideoDto(this.id, this.video, this.note);
  factory VideoDto.fromJson(Map<String, dynamic> json) =>
      _$VideoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDtoToJson(this);
}
