// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_approval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerApprovalResponse _$OwnerApprovalResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerApprovalResponse()
      ..noSetupWirOwnerApproval = json['noSetupWIROwnerApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['noSetupWIROwnerApproval'] as Map<String, dynamic>)
      ..wirOwnerApproval = json['wirOwnerApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirOwnerApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$OwnerApprovalResponseToJson(
        OwnerApprovalResponse instance) =>
    <String, dynamic>{
      'noSetupWIROwnerApproval': instance.noSetupWirOwnerApproval,
      'wirOwnerApproval': instance.wirOwnerApproval,
    };
