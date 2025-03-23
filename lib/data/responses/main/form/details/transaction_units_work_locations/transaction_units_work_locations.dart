import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_units_work_locations.g.dart';

@JsonSerializable()
class TransactionUnitsWorkLocations {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<WorkData>? data;

  TransactionUnitsWorkLocations();

  factory TransactionUnitsWorkLocations.fromJson(Map<String, dynamic> json) =>
      _$TransactionUnitsWorkLocationsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionUnitsWorkLocationsToJson(this);
}

@JsonSerializable()
class WorkData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'transaction_id')
  String? transactionId;
  @JsonKey(name: 'project_id')
  String? projectId;
  @JsonKey(name: 'form_type')
  String? formType;
  @JsonKey(name: 'activity_id')
  String? activityId;
  @JsonKey(name: 'activity')
  Activity? activity;
  @JsonKey(name: 'template_id')
  String? templateId;
  @JsonKey(name: 'template')
  Template? template;
  @JsonKey(name: 'unit_id')
  String? unitId;
  @JsonKey(name: 'unit')
  Unit? unit;
  @JsonKey(name: 'work_level_id')
  String? workLevelId;
  @JsonKey(name: 'worklevel')
  Worklevel? worklevel;
  @JsonKey(name: 'work_level_quantity')
  String? workLevelQuantity;
  @JsonKey(name: 'worklevel_price')
  String? worklevelPrice;
  @JsonKey(name: 'worklevel_total_price')
  String? worklevelTotalPrice;
  @JsonKey(name: 'work_level_ratio')
  dynamic workLevelRatio;
  @JsonKey(name: 'quantities')
  List<Quantities>? quantities;
  @JsonKey(name: 'attachment')
  List<Attachment>? attachment;

  WorkData();

  factory WorkData.fromJson(Map<String, dynamic> json) =>
      _$WorkDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDataToJson(this);
}

@JsonSerializable()
class Template {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'keyword')
  String? keyword;
  @JsonKey(name: 'notes')
  String? notes;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;

  Template();

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);

}

@JsonSerializable()
class Unit {
  @JsonKey(name: 'unit_id')
  String? unitId;
  @JsonKey(name: 'manual_unit_name')
  String? manualUnitName;
  @JsonKey(name: 'unit_custom_number')
  String? unitCustomNumber;
  @JsonKey(name: 'unit_custom_description')
  String? unitCustomDescription;
  @JsonKey(name: 'unit_zone')
  dynamic unitZone;
  @JsonKey(name: 'unit_cluster')
  dynamic unitCluster;
  @JsonKey(name: 'unit_block')
  dynamic unitBlock;
  @JsonKey(name: 'unitsextra')
  List<UnitsExtra>? unitsextra;
  @JsonKey(name: 'unitstemplates')
  List<Template>? unitstemplates;

  Unit();

  factory Unit.fromJson(Map<String, dynamic> json) =>
      _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

@JsonSerializable()
class UnitsExtra {
  @JsonKey(name: 'units_extra_given_title')
  String? unitsExtraGivenTitle;
  @JsonKey(name: 'units_extra_key')
  String? unitsExtraKey;
  @JsonKey(name: 'units_extra_value')
  String? unitsExtraValue;

  UnitsExtra();

  factory UnitsExtra.fromJson(Map<String, dynamic> json) =>
      _$UnitsExtraFromJson(json);

  Map<String, dynamic> toJson() => _$UnitsExtraToJson(this);

}

@JsonSerializable()
class Worklevel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'description_en')
  String? descriptionEn;
  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  Worklevel();

  factory Worklevel.fromJson(Map<String, dynamic> json) =>
      _$WorklevelFromJson(json);

  Map<String, dynamic> toJson() => _$WorklevelToJson(this);
}

@JsonSerializable()
class Quantities {
  @JsonKey(name: 'writer_type')
  String? writerType;
  @JsonKey(name: 'work_level_quantity')
  int? workLevelQuantity;
  @JsonKey(name: 'quantity_selected')
  bool? quantitySelected;
  @JsonKey(name: 'writer')
  Writer? writer;

  Quantities();

  factory Quantities.fromJson(Map<String, dynamic> json) =>
      _$QuantitiesFromJson(json);

  Map<String, dynamic> toJson() => _$QuantitiesToJson(this);
}