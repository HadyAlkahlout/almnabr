// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_approval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamApprovalResponse _$TeamApprovalResponseFromJson(
        Map<String, dynamic> json) =>
    TeamApprovalResponse()
      ..noSetupWirContractorTeamApproval =
          json['noSetupWIRContractorTeamApproval'] == null
              ? null
              : GenericResponse.fromJson(
                  json['noSetupWIRContractorTeamApproval']
                      as Map<String, dynamic>)
      ..wirContractorTeamApproval = json['wirContractorTeamApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirContractorTeamApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$TeamApprovalResponseToJson(
        TeamApprovalResponse instance) =>
    <String, dynamic>{
      'noSetupWIRContractorTeamApproval':
          instance.noSetupWirContractorTeamApproval,
      'wirContractorTeamApproval': instance.wirContractorTeamApproval,
    };
