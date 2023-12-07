

part 'accountD.g.dart';

class AccountDtos {
  final String id;
  final String email;
  final List<String> courses;
  final List<ResultDtos> resultUser;

  AccountDtos(
    this.id,
    this.email,
    this.courses,
    this.resultUser,
  );

  factory AccountDtos.fromJson(Map<String, dynamic> json) =>
      _$AccountDtosFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDtosToJson(this);
}

class ResultDtos {
  final String courses;
  final String lessons;
  final double process;
  ResultDtos(this.courses, this.lessons, this.process);

  factory ResultDtos.fromJson(Map<String, dynamic> json) =>
      _$ResultDtosFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDtosToJson(this);
}

class AccountLoginDtos {
  final String accessToken;
  final String refreshToken;
  AccountLoginDtos(this.accessToken, this.refreshToken);
  factory AccountLoginDtos.fromJson(Map<String, dynamic> json) =>
      _$AccountLoginDtosFromJson(json);
  Map<String, dynamic> toJson() => _$AccountLoginDtosToJson(this);
}
