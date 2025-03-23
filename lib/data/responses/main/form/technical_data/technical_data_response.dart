import 'package:json_annotation/json_annotation.dart';

part 'technical_data_response.g.dart';

@JsonSerializable()
class TechDataResponse {
  @JsonKey(name: 'getWIRTechnicalAssistanceData')
  TechnicalDataResponse? response;

  TechDataResponse();

  factory TechDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TechDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TechDataResponseToJson(this);
}

@JsonSerializable()
class TechnicalDataResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<TechnicalData>? data;

  TechnicalDataResponse();

  factory TechnicalDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TechnicalDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalDataResponseToJson(this);
}

@JsonSerializable()
class TechnicalData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'form_setup_type')
  String? formSetupType;
  @JsonKey(name: 'yes_code_result')
  String? yesCodeResult;
  @JsonKey(name: 'no_code_result')
  String? noCodeResult;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'description_en')
  String? descriptionEn;
  @JsonKey(name: 'description_ar')
  String? descriptionAr;
  @JsonKey(name: 'status')
  String? status;

  TechnicalData();

  factory TechnicalData.fromJson(Map<String, dynamic> json) =>
      _$TechnicalDataFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalDataToJson(this);
}