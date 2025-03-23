// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pmc_approval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PMCApprovalResponse _$PMCApprovalResponseFromJson(Map<String, dynamic> json) =>
    PMCApprovalResponse()
      ..wirPMCApproval = json['wirPMCApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirPMCApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$PMCApprovalResponseToJson(
        PMCApprovalResponse instance) =>
    <String, dynamic>{
      'wirPMCApproval': instance.wirPMCApproval,
    };
