import 'package:json_annotation/json_annotation.dart';
import 'transaction_attachments/transaction_attachments.dart';
import 'transaction_companies/transaction_companies.dart';
import 'transaction_details/transaction_details.dart';
import 'transaction_notes/transaction_notes.dart';
import 'transaction_persons/transaction_persons.dart';
import 'transaction_records/transaction_records.dart';
import 'transaction_stages/transaction_stages.dart';
import 'transaction_technical_assistance/transaction_technical_assistance.dart';
import 'transaction_units_work_locations/transaction_units_work_locations.dart';
import 'transaction_wir_action_buttons/transaction_wir_action_buttons.dart';
import 'transaction_wir_form_data/transaction_wir_form_data.dart';

part 'form_details_response.g.dart';

@JsonSerializable()
class FormDetailsResponse {
  @JsonKey(name: 'transactionDetails')
  TransactionDetails? transactionDetails;
  @JsonKey(name: 'transactionCompanies')
  TransactionCompanies? transactionCompanies;
  @JsonKey(name: 'transactionWIRActionButtons')
  TransactionWIRActionButtons? transactionWIRActionButtons;
  @JsonKey(name: 'transactionAttachments')
  TransactionAttachments? transactionAttachments;
  @JsonKey(name: 'transactionNotes')
  TransactionNotes? transactionNotes;
  @JsonKey(name: 'transactionRecords')
  TransactionRecords? transactionRecords;
  @JsonKey(name: 'transactionPersons')
  TransactionPersons? transactionPersons;
  @JsonKey(name: 'transactionWIRFormData')
  TransactionWIRFormData? transactionWIRFormData;
  @JsonKey(name: 'transactionTechnicalAssistance')
  TransactionTechnicalAssistance? transactionTechnicalAssistance;
  @JsonKey(name: 'transactionUnitsWorkLocations')
  TransactionUnitsWorkLocations? transactionUnitsWorkLocations;
  @JsonKey(name: 'transactionStages')
  TransactionStages? transactionStages;

  FormDetailsResponse();

  factory FormDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$FormDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FormDetailsResponseToJson(this);
}
