// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendResponse _$ResendResponseFromJson(Map<String, dynamic> json) =>
    ResendResponse()
      ..userResend = json['userResendOtp'] == null
          ? null
          : UserResendResponse.fromJson(
              json['userResendOtp'] as Map<String, dynamic>);

Map<String, dynamic> _$ResendResponseToJson(ResendResponse instance) =>
    <String, dynamic>{
      'userResendOtp': instance.userResend,
    };

UserResendResponse _$UserResendResponseFromJson(Map<String, dynamic> json) =>
    UserResendResponse()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..otpLength = (json['otp_length'] as num?)?.toInt()
      ..otpExpiredSeconds = (json['otp_expired_seconds'] as num?)?.toInt()
      ..otp = json['otp'] as String?
      ..typeName = json['__typename'] as String?;

Map<String, dynamic> _$UserResendResponseToJson(UserResendResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'otp_length': instance.otpLength,
      'otp_expired_seconds': instance.otpExpiredSeconds,
      'otp': instance.otp,
      '__typename': instance.typeName,
    };
