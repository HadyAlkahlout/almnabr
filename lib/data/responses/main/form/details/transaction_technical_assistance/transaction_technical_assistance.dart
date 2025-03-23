import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

import '../transaction_attachments/transaction_attachments.dart';
import '../transaction_details/transaction_details.dart';

part 'transaction_technical_assistance.g.dart';

@JsonSerializable()
class TransactionTechnicalAssistance {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<TechnicalAssistantData>? data;

  TransactionTechnicalAssistance();

  factory TransactionTechnicalAssistance.fromJson(Map<String, dynamic> json) =>
      _$TransactionTechnicalAssistanceFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionTechnicalAssistanceToJson(this);
}

@JsonSerializable()
class TechnicalAssistantData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'step_name')
  String? stepName;
  @JsonKey(name: 'assistance_type')
  String? assistanceType;
  @JsonKey(name: 'custom_key')
  String? customKey;
  @JsonKey(name: 'custom_val')
  String? customVal;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'result')
  String? result;
  @JsonKey(name: 'attachment')
  Attachment? attachment;
  @JsonKey(name: 'writer')
  Writer? writer;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  TechnicalAssistantData();

  factory TechnicalAssistantData.fromJson(Map<String, dynamic> json) =>
      _$TechnicalAssistantDataFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalAssistantDataToJson(this);

}