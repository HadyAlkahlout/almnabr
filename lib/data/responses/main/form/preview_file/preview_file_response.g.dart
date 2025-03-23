// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewFileResponse _$PreviewFileResponseFromJson(Map<String, dynamic> json) =>
    PreviewFileResponse()
      ..previewWirTransaction = json['previewWIRTransaction'] == null
          ? null
          : PreviewWirTransaction.fromJson(
              json['previewWIRTransaction'] as Map<String, dynamic>);

Map<String, dynamic> _$PreviewFileResponseToJson(
        PreviewFileResponse instance) =>
    <String, dynamic>{
      'previewWIRTransaction': instance.previewWirTransaction,
    };

PreviewWirTransaction _$PreviewWirTransactionFromJson(
        Map<String, dynamic> json) =>
    PreviewWirTransaction()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..data = json['data'] == null
          ? null
          : FileData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$PreviewWirTransactionToJson(
        PreviewWirTransaction instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

FileData _$FileDataFromJson(Map<String, dynamic> json) => FileData()
  ..exportType = json['export_type'] as String?
  ..fileName = json['file_name'] as String?
  ..mimeType = json['mime_type'] as String?
  ..content = json['content'] as String?;

Map<String, dynamic> _$FileDataToJson(FileData instance) => <String, dynamic>{
      'export_type': instance.exportType,
      'file_name': instance.fileName,
      'mime_type': instance.mimeType,
      'content': instance.content,
    };
