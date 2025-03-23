import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: 'transactionsCountAndLists')
  TransactionsLists? transactionsCountAndLists;

  DashboardResponse();

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);

}

@JsonSerializable()
class TransactionsLists {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<AppForm>? data;

  TransactionsLists();

  factory TransactionsLists.fromJson(Map<String, dynamic> json) =>
      _$TransactionsListsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsListsToJson(this);

}

@JsonSerializable()
class AppForm {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'project_id')
  int? projectId;
  @JsonKey(name: 'activity')
  ActivityClass? activity;
  @JsonKey(name: 'last_step_name')
  String? lastStepName;
  @JsonKey(name: 'last_step_name_label')
  String? lastStepNameLabel;
  @JsonKey(name: 'units')
  String? units;
  @JsonKey(name: 'evaluation_result')
  String? evaluationResult;

  AppForm();

  factory AppForm.fromJson(Map<String, dynamic> json) =>
      _$AppFormFromJson(json);

  Map<String, dynamic> toJson() => _$AppFormToJson(this);

}

@JsonSerializable()
class ActivityClass {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'activity_code')
  String? activityCode;

  ActivityClass();

  factory ActivityClass.fromJson(Map<String, dynamic> json) =>
      _$ActivityClassFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityClassToJson(this);

}