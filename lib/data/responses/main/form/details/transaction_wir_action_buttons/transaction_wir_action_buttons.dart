import 'package:json_annotation/json_annotation.dart';
part 'transaction_wir_action_buttons.g.dart';

@JsonSerializable()
class TransactionWIRActionButtons {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'view')
  View? view;
  @JsonKey(name: 'edit')
  View? edit;
  @JsonKey(name: 'data_status')
  List<DataStatus>? dataStatus;

  TransactionWIRActionButtons();

  factory TransactionWIRActionButtons.fromJson(Map<String, dynamic> json) =>
      _$TransactionWIRActionButtonsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionWIRActionButtonsToJson(this);
}

@JsonSerializable()
class View {
  @JsonKey(name: 'configurations')
  bool? configurations;
  @JsonKey(name: 'contractor_team_approval')
  bool? contractorTeamApproval;
  @JsonKey(name: 'contractor_manager_approval')
  bool? contractorManagerApproval;
  @JsonKey(name: 'contractor_qaqc_approval')
  bool? contractorQaqcApproval;
  @JsonKey(name: 'recipient_verification')
  bool? recipientVerification;
  @JsonKey(name: 'technical_assistant')
  bool? technicalAssistant;
  @JsonKey(name: 'soil_test_witness_result')
  bool? soilTestWitnessResult;
  @JsonKey(name: 'special_approval')
  bool? specialApproval;
  @JsonKey(name: 'authorized_positions_approval')
  bool? authorizedPositionsApproval;
  @JsonKey(name: 'manager_approval')
  bool? managerApproval;
  @JsonKey(name: 'owners_representative')
  bool? ownersRepresentative;
  @JsonKey(name: 'pmc_approval')
  bool? pmcApproval;
  @JsonKey(name: 'result_receiving')
  bool? resultReceiving;

  View();

  factory View.fromJson(Map<String, dynamic> json) =>
      _$ViewFromJson(json);

  Map<String, dynamic> toJson() => _$ViewToJson(this);
}

@JsonSerializable()
class DataStatus {
  @JsonKey(name: 'step_name')
  String? stepName;
  @JsonKey(name: 'data_status')
  bool? dataStatus;

  DataStatus();

  factory DataStatus.fromJson(Map<String, dynamic> json) =>
      _$DataStatusFromJson(json);

  Map<String, dynamic> toJson() => _$DataStatusToJson(this);
}