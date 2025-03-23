import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'userLogin')
  UserLoginResponse? userLogin;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserLoginResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'is_exists')
  bool? isExists;
  @JsonKey(name: 'otp_length')
  int? otpLength;
  @JsonKey(name: 'otp_expired_seconds')
  int? otpExpiredSeconds;
  @JsonKey(name: 'otp')
  String? otp;
  @JsonKey(name: '__typename')
  String? typeName;

  UserLoginResponse();

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}
