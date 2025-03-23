// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorized_position_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizedPositionResponse _$AuthorizedPositionResponseFromJson(
        Map<String, dynamic> json) =>
    AuthorizedPositionResponse()
      ..noSetupWirAuthorizedPosition =
          json['noSetupWIRAuthorizedPositionApproval'] == null
              ? null
              : GenericResponse.fromJson(
                  json['noSetupWIRAuthorizedPositionApproval']
                      as Map<String, dynamic>)
      ..wirAuthorizedPosition = json['wirAuthorizedPositionApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirAuthorizedPositionApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$AuthorizedPositionResponseToJson(
        AuthorizedPositionResponse instance) =>
    <String, dynamic>{
      'noSetupWIRAuthorizedPositionApproval':
          instance.noSetupWirAuthorizedPosition,
      'wirAuthorizedPositionApproval': instance.wirAuthorizedPosition,
    };
