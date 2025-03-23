import 'package:json_annotation/json_annotation.dart';

part 'resend_response.g.dart';

@JsonSerializable()
class ResendResponse {
  @JsonKey(name: 'userResendOtp')
  UserResendResponse? userResend;

  ResendResponse();

  factory ResendResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResendResponseToJson(this);
}

@JsonSerializable()
class UserResendResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'otp_length')
  int? otpLength;
  @JsonKey(name: 'otp_expired_seconds')
  int? otpExpiredSeconds;
  @JsonKey(name: 'otp')
  String? otp;
  @JsonKey(name: '__typename')
  String? typeName;

  UserResendResponse();

  factory UserResendResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResendResponseToJson(this);
}
