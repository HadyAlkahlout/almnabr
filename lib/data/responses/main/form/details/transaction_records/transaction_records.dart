import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_records.g.dart';

@JsonSerializable()
class TransactionRecords {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<TransactionRecord>? data;

  TransactionRecords();

  factory TransactionRecords.fromJson(Map<String, dynamic> json) =>
      _$TransactionRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRecordsToJson(this);
}

@JsonSerializable()
class TransactionRecord {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'transaction_step_name')
  String? transactionStepName;
  @JsonKey(name: 'notes')
  String? notes;
  @JsonKey(name: 'writer')
  Writer? writer;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  TransactionRecord();

  factory TransactionRecord.fromJson(Map<String, dynamic> json) =>
      _$TransactionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRecordToJson(this);
}