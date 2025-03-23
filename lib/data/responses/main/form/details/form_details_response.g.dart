// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormDetailsResponse _$FormDetailsResponseFromJson(Map<String, dynamic> json) =>
    FormDetailsResponse()
      ..transactionDetails = json['transactionDetails'] == null
          ? null
          : TransactionDetails.fromJson(
              json['transactionDetails'] as Map<String, dynamic>)
      ..transactionCompanies = json['transactionCompanies'] == null
          ? null
          : TransactionCompanies.fromJson(
              json['transactionCompanies'] as Map<String, dynamic>)
      ..transactionWIRActionButtons =
          json['transactionWIRActionButtons'] == null
              ? null
              : TransactionWIRActionButtons.fromJson(
                  json['transactionWIRActionButtons'] as Map<String, dynamic>)
      ..transactionAttachments = json['transactionAttachments'] == null
          ? null
          : TransactionAttachments.fromJson(
              json['transactionAttachments'] as Map<String, dynamic>)
      ..transactionNotes = json['transactionNotes'] == null
          ? null
          : TransactionNotes.fromJson(
              json['transactionNotes'] as Map<String, dynamic>)
      ..transactionRecords = json['transactionRecords'] == null
          ? null
          : TransactionRecords.fromJson(
              json['transactionRecords'] as Map<String, dynamic>)
      ..transactionPersons = json['transactionPersons'] == null
          ? null
          : TransactionPersons.fromJson(
              json['transactionPersons'] as Map<String, dynamic>)
      ..transactionWIRFormData = json['transactionWIRFormData'] == null
          ? null
          : TransactionWIRFormData.fromJson(
              json['transactionWIRFormData'] as Map<String, dynamic>)
      ..transactionTechnicalAssistance =
          json['transactionTechnicalAssistance'] == null
              ? null
              : TransactionTechnicalAssistance.fromJson(
                  json['transactionTechnicalAssistance']
                      as Map<String, dynamic>)
      ..transactionUnitsWorkLocations =
          json['transactionUnitsWorkLocations'] == null
              ? null
              : TransactionUnitsWorkLocations.fromJson(
                  json['transactionUnitsWorkLocations'] as Map<String, dynamic>)
      ..transactionStages = json['transactionStages'] == null
          ? null
          : TransactionStages.fromJson(
              json['transactionStages'] as Map<String, dynamic>);

Map<String, dynamic> _$FormDetailsResponseToJson(
        FormDetailsResponse instance) =>
    <String, dynamic>{
      'transactionDetails': instance.transactionDetails,
      'transactionCompanies': instance.transactionCompanies,
      'transactionWIRActionButtons': instance.transactionWIRActionButtons,
      'transactionAttachments': instance.transactionAttachments,
      'transactionNotes': instance.transactionNotes,
      'transactionRecords': instance.transactionRecords,
      'transactionPersons': instance.transactionPersons,
      'transactionWIRFormData': instance.transactionWIRFormData,
      'transactionTechnicalAssistance': instance.transactionTechnicalAssistance,
      'transactionUnitsWorkLocations': instance.transactionUnitsWorkLocations,
      'transactionStages': instance.transactionStages,
    };
