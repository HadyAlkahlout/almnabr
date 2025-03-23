// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_approval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialApprovalResponse _$SpecialApprovalResponseFromJson(
        Map<String, dynamic> json) =>
    SpecialApprovalResponse()
      ..noSetupWirSpecialApproval = json['noSetupWIRSpecialApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['noSetupWIRSpecialApproval'] as Map<String, dynamic>)
      ..wirSpecialApproval = json['wirSpecialApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirSpecialApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$SpecialApprovalResponseToJson(
        SpecialApprovalResponse instance) =>
    <String, dynamic>{
      'noSetupWIRSpecialApproval': instance.noSetupWirSpecialApproval,
      'wirSpecialApproval': instance.wirSpecialApproval,
    };
