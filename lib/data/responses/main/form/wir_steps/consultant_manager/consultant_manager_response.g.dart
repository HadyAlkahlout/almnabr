// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultant_manager_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsultantManagerResponse _$ConsultantManagerResponseFromJson(
        Map<String, dynamic> json) =>
    ConsultantManagerResponse()
      ..noSetupWirConsultantManager =
          json['noSetupWIRConsultantManagerApproval'] == null
              ? null
              : GenericResponse.fromJson(
                  json['noSetupWIRConsultantManagerApproval']
                      as Map<String, dynamic>)
      ..wirConsultantManager = json['wirConsultantManagerApproval'] == null
          ? null
          : GenericResponse.fromJson(
              json['wirConsultantManagerApproval'] as Map<String, dynamic>);

Map<String, dynamic> _$ConsultantManagerResponseToJson(
        ConsultantManagerResponse instance) =>
    <String, dynamic>{
      'noSetupWIRConsultantManagerApproval':
          instance.noSetupWirConsultantManager,
      'wirConsultantManagerApproval': instance.wirConsultantManager,
    };
