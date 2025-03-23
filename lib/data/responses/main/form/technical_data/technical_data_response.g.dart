// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TechDataResponse _$TechDataResponseFromJson(Map<String, dynamic> json) =>
    TechDataResponse()
      ..response = json['getWIRTechnicalAssistanceData'] == null
          ? null
          : TechnicalDataResponse.fromJson(
              json['getWIRTechnicalAssistanceData'] as Map<String, dynamic>);

Map<String, dynamic> _$TechDataResponseToJson(TechDataResponse instance) =>
    <String, dynamic>{
      'getWIRTechnicalAssistanceData': instance.response,
    };

TechnicalDataResponse _$TechnicalDataResponseFromJson(
        Map<String, dynamic> json) =>
    TechnicalDataResponse()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => TechnicalData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TechnicalDataResponseToJson(
        TechnicalDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

TechnicalData _$TechnicalDataFromJson(Map<String, dynamic> json) =>
    TechnicalData()
      ..id = (json['id'] as num?)?.toInt()
      ..formSetupType = json['form_setup_type'] as String?
      ..yesCodeResult = json['yes_code_result'] as String?
      ..noCodeResult = json['no_code_result'] as String?
      ..titleEn = json['title_en'] as String?
      ..titleAr = json['title_ar'] as String?
      ..descriptionEn = json['description_en'] as String?
      ..descriptionAr = json['description_ar'] as String?
      ..status = json['status'] as String?;

Map<String, dynamic> _$TechnicalDataToJson(TechnicalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'form_setup_type': instance.formSetupType,
      'yes_code_result': instance.yesCodeResult,
      'no_code_result': instance.noCodeResult,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'status': instance.status,
    };
