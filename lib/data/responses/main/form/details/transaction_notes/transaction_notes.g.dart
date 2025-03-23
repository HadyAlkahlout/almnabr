// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionNotes _$TransactionNotesFromJson(Map<String, dynamic> json) =>
    TransactionNotes()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..paging = json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>)
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionNotesToJson(TransactionNotes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'paging': instance.paging,
      'data': instance.data,
    };

Note _$NoteFromJson(Map<String, dynamic> json) => Note()
  ..id = (json['id'] as num?)?.toInt()
  ..transactionStepName = json['transaction_step_name'] as String?
  ..notes = json['notes'] as String?
  ..createdAt = json['created_at'] as String?
  ..updatedAt = json['updated_at'] as String?
  ..writer = json['writer'] == null
      ? null
      : Writer.fromJson(json['writer'] as Map<String, dynamic>);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'transaction_step_name': instance.transactionStepName,
      'notes': instance.notes,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'writer': instance.writer,
    };
