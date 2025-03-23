import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_stages.g.dart';

@JsonSerializable()
class TransactionStages {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<StageData>? data;

  TransactionStages();

  factory TransactionStages.fromJson(Map<String, dynamic> json) =>
      _$TransactionStagesFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionStagesToJson(this);
}

@JsonSerializable()
class StageData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'position')
  Chapter? position;
  @JsonKey(name: 'writer')
  Writer? writer;
  @JsonKey(name: 'stage_text')
  String? stageText;
  @JsonKey(name: 'stage_type')
  String? stageType;
  @JsonKey(name: 'step_name')
  String? stepName;
  @JsonKey(name: 'created_at')
  String? createAt;
  @JsonKey(name: 'updated_at')
  String? updateAt;

  StageData();

  factory StageData.fromJson(Map<String, dynamic> json) =>
      _$StageDataFromJson(json);

  Map<String, dynamic> toJson() => _$StageDataToJson(this);
}