// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_wir_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionWIRFormData _$TransactionWIRFormDataFromJson(
        Map<String, dynamic> json) =>
    TransactionWIRFormData()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..data = json['data'] == null
          ? null
          : WIRData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$TransactionWIRFormDataToJson(
        TransactionWIRFormData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

WIRData _$WIRDataFromJson(Map<String, dynamic> json) => WIRData()
  ..id = json['id'] as String?
  ..transactionId = json['transaction_id'] as String?
  ..activityId = json['activity_id'] as String?
  ..projectId = json['project_id'] as String?
  ..templateId = json['template_id']
  ..billQuantityItemId = json['bill_quantity_item_id'] as String?
  ..bills = json['bills']
  ..sendToContractorTeam = json['send_to_contractor_team'] as String?
  ..sendToContractorManager = json['send_to_contractor_manager'] as String?
  ..soilTestRequired = json['soil_test_required'] as String?
  ..allowCustomUsers = json['allow_custom_users'] as String?
  ..allowCustomQuantities = json['allow_custom_quantities'] as String?
  ..specialApproverRequired = json['special_approver_required'] as String?
  ..sendToAuthorizedPosition = json['send_to_authorized_position'] as String?
  ..soilWitnessTestResult = json['soil_witness_test_result']
  ..soilWitnessTestReportNumber = json['soil_witness_test_report_number']
  ..soilWitnessTestReportType = json['soil_witness_test_report_type'];

Map<String, dynamic> _$WIRDataToJson(WIRData instance) => <String, dynamic>{
      'id': instance.id,
      'transaction_id': instance.transactionId,
      'activity_id': instance.activityId,
      'project_id': instance.projectId,
      'template_id': instance.templateId,
      'bill_quantity_item_id': instance.billQuantityItemId,
      'bills': instance.bills,
      'send_to_contractor_team': instance.sendToContractorTeam,
      'send_to_contractor_manager': instance.sendToContractorManager,
      'soil_test_required': instance.soilTestRequired,
      'allow_custom_users': instance.allowCustomUsers,
      'allow_custom_quantities': instance.allowCustomQuantities,
      'special_approver_required': instance.specialApproverRequired,
      'send_to_authorized_position': instance.sendToAuthorizedPosition,
      'soil_witness_test_result': instance.soilWitnessTestResult,
      'soil_witness_test_report_number': instance.soilWitnessTestReportNumber,
      'soil_witness_test_report_type': instance.soilWitnessTestReportType,
    };
