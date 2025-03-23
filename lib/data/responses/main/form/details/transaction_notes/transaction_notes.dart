import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_notes.g.dart';

@JsonSerializable()
class TransactionNotes {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<Note>? data;

  TransactionNotes();

  factory TransactionNotes.fromJson(Map<String, dynamic> json) =>
      _$TransactionNotesFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionNotesToJson(this);
}

@JsonSerializable()
class Note {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'transaction_step_name')
  String? transactionStepName;
  @JsonKey(name: 'notes')
  String? notes;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'writer')
  Writer? writer;

  Note();

  factory Note.fromJson(Map<String, dynamic> json) =>
      _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}