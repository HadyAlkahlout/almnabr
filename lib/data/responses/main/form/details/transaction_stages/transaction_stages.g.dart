// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_stages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionStages _$TransactionStagesFromJson(Map<String, dynamic> json) =>
    TransactionStages()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..paging = json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>)
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => StageData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionStagesToJson(TransactionStages instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'paging': instance.paging,
      'data': instance.data,
    };

StageData _$StageDataFromJson(Map<String, dynamic> json) => StageData()
  ..id = (json['id'] as num?)?.toInt()
  ..position = json['position'] == null
      ? null
      : Chapter.fromJson(json['position'] as Map<String, dynamic>)
  ..writer = json['writer'] == null
      ? null
      : Writer.fromJson(json['writer'] as Map<String, dynamic>)
  ..stageText = json['stage_text'] as String?
  ..stageType = json['stage_type'] as String?
  ..stepName = json['step_name'] as String?
  ..createAt = json['created_at'] as String?
  ..updateAt = json['updated_at'] as String?;

Map<String, dynamic> _$StageDataToJson(StageData instance) => <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'writer': instance.writer,
      'stage_text': instance.stageText,
      'stage_type': instance.stageType,
      'step_name': instance.stepName,
      'created_at': instance.createAt,
      'updated_at': instance.updateAt,
    };
