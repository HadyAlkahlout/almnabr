// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse()
      ..transactionsCountAndLists = json['transactionsCountAndLists'] == null
          ? null
          : TransactionsLists.fromJson(
              json['transactionsCountAndLists'] as Map<String, dynamic>);

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'transactionsCountAndLists': instance.transactionsCountAndLists,
    };

TransactionsLists _$TransactionsListsFromJson(Map<String, dynamic> json) =>
    TransactionsLists()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..paging = json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>)
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => AppForm.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionsListsToJson(TransactionsLists instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'paging': instance.paging,
      'data': instance.data,
    };

AppForm _$AppFormFromJson(Map<String, dynamic> json) => AppForm()
  ..id = (json['id'] as num?)?.toInt()
  ..projectId = (json['project_id'] as num?)?.toInt()
  ..activity = json['activity'] == null
      ? null
      : ActivityClass.fromJson(json['activity'] as Map<String, dynamic>)
  ..lastStepName = json['last_step_name'] as String?
  ..lastStepNameLabel = json['last_step_name_label'] as String?
  ..units = json['units'] as String?
  ..evaluationResult = json['evaluation_result'] as String?;

Map<String, dynamic> _$AppFormToJson(AppForm instance) => <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'activity': instance.activity,
      'last_step_name': instance.lastStepName,
      'last_step_name_label': instance.lastStepNameLabel,
      'units': instance.units,
      'evaluation_result': instance.evaluationResult,
    };

ActivityClass _$ActivityClassFromJson(Map<String, dynamic> json) =>
    ActivityClass()
      ..id = json['id'] as String?
      ..titleEn = json['title_en'] as String?
      ..titleAr = json['title_ar'] as String?
      ..activityCode = json['activity_code'] as String?;

Map<String, dynamic> _$ActivityClassToJson(ActivityClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
      'activity_code': instance.activityCode,
    };
