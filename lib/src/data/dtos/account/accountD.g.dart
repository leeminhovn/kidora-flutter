// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountLoginDtos _$AccountLoginDtosFromJson(Map<String, dynamic> json) =>
    AccountLoginDtos(json["accessToken"], json["refreshToken"]);

Map<String, dynamic> _$AccountLoginDtosToJson(AccountLoginDtos instance) => {
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

AccountDtos _$AccountDtosFromJson(Map<String, dynamic> json) => AccountDtos(
      json['_id'] as String,
      json['email'] as String,
      (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
      (json['resultUser'] as List<dynamic>)
          .map((e) => ResultDtos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountDtosToJson(AccountDtos instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'courses': instance.courses,
      'resultUser': instance.resultUser,
    };

ResultDtos _$ResultDtosFromJson(Map<String, dynamic> json) => ResultDtos(
      json['courses'] as String,
      json['lessons'] as String,
      (json['process'] * 1.0) as double,
    );

Map<String, dynamic> _$ResultDtosToJson(ResultDtos instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'lessons': instance.lessons,
      'process': instance.process,
    };
