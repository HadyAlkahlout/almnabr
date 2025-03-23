// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse()
      ..userLogin = json['userLogin'] == null
          ? null
          : UserLoginResponse.fromJson(
              json['userLogin'] as Map<String, dynamic>);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'userLogin': instance.userLogin,
    };

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..isExists = json['is_exists'] as bool?
      ..otpLength = (json['otp_length'] as num?)?.toInt()
      ..otpExpiredSeconds = (json['otp_expired_seconds'] as num?)?.toInt()
      ..otp = json['otp'] as String?
      ..typeName = json['__typename'] as String?;

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'is_exists': instance.isExists,
      'otp_length': instance.otpLength,
      'otp_expired_seconds': instance.otpExpiredSeconds,
      'otp': instance.otp,
      '__typename': instance.typeName,
    };
