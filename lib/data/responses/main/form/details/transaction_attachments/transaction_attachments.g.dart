// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_attachments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionAttachments _$TransactionAttachmentsFromJson(
        Map<String, dynamic> json) =>
    TransactionAttachments()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..paging = json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>)
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionAttachmentsToJson(
        TransactionAttachments instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'paging': instance.paging,
      'data': instance.data,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment()
  ..id = (json['id'] as num?)?.toInt()
  ..transactionStepName = json['transaction_step_name'] as String?
  ..filePath = json['file_path'] as String?
  ..fileSize = json['file_size'] as String?
  ..fileExtension = json['file_extension'] as String?
  ..titleEn = json['title_en'] as String?
  ..titleAr = json['title_ar'] as String?
  ..createdAt = json['created_at'] as String?
  ..updatedAt = json['updated_at'] as String?
  ..writer = json['writer'] == null
      ? null
      : Writer.fromJson(json['writer'] as Map<String, dynamic>);

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_step_name': instance.transactionStepName,
      'file_path': instance.filePath,
      'file_size': instance.fileSize,
      'file_extension': instance.fileExtension,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'writer': instance.writer,
    };
