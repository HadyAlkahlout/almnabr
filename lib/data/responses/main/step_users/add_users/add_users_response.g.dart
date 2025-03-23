// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUsersResponse _$AddUsersResponseFromJson(Map<String, dynamic> json) =>
    AddUsersResponse()
      ..assignUsers = json['assignTransactionStepUsers'] == null
          ? null
          : GenericResponse.fromJson(
              json['assignTransactionStepUsers'] as Map<String, dynamic>);

Map<String, dynamic> _$AddUsersResponseToJson(AddUsersResponse instance) =>
    <String, dynamic>{
      'assignTransactionStepUsers': instance.assignUsers,
    };
