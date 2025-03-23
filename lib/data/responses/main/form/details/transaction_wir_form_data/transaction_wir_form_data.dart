import 'package:json_annotation/json_annotation.dart';

part 'transaction_wir_form_data.g.dart';

@JsonSerializable()
class TransactionWIRFormData {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  WIRData? data;

  TransactionWIRFormData();

  factory TransactionWIRFormData.fromJson(Map<String, dynamic> json) =>
      _$TransactionWIRFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionWIRFormDataToJson(this);
}

@JsonSerializable()
class WIRData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'transaction_id')
  String? transactionId;
  @JsonKey(name: 'activity_id')
  String? activityId;
  @JsonKey(name: 'project_id')
  String? projectId;
  @JsonKey(name: 'template_id')
  dynamic templateId;
  @JsonKey(name: 'bill_quantity_item_id')
  String? billQuantityItemId;
  @JsonKey(name: 'bills')
  dynamic bills;
  @JsonKey(name: 'send_to_contractor_team')
  String? sendToContractorTeam;
  @JsonKey(name: 'send_to_contractor_manager')
  String? sendToContractorManager;
  @JsonKey(name: 'soil_test_required')
  String? soilTestRequired;
  @JsonKey(name: 'allow_custom_users')
  String? allowCustomUsers;
  @JsonKey(name: 'allow_custom_quantities')
  String? allowCustomQuantities;
  @JsonKey(name: 'special_approver_required')
  String? specialApproverRequired;
  @JsonKey(name: 'send_to_authorized_position')
  String? sendToAuthorizedPosition;
  @JsonKey(name: 'soil_witness_test_result')
  dynamic soilWitnessTestResult;
  @JsonKey(name: 'soil_witness_test_report_number')
  dynamic soilWitnessTestReportNumber;
  @JsonKey(name: 'soil_witness_test_report_type')
  dynamic soilWitnessTestReportType;

  WIRData();

  factory WIRData.fromJson(Map<String, dynamic> json) =>
      _$WIRDataFromJson(json);

  Map<String, dynamic> toJson() => _$WIRDataToJson(this);
}