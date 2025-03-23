import 'package:json_annotation/json_annotation.dart';

part 'previous_versions_response.g.dart';

@JsonSerializable()
class PreviousVersionsResponse {
  @JsonKey(name: 'getWIRUnitsPreviousVersions')
  PreviousVersions? previousVersions;

  PreviousVersionsResponse();

  factory PreviousVersionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PreviousVersionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreviousVersionsResponseToJson(this);
}

@JsonSerializable()
class PreviousVersions {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<PreviousVersion>? data;

  PreviousVersions();

  factory PreviousVersions.fromJson(Map<String, dynamic> json) =>
      _$PreviousVersionsFromJson(json);

  Map<String, dynamic> toJson() => _$PreviousVersionsToJson(this);
}

@JsonSerializable()
class PreviousVersion {
  @JsonKey(name: 'transaction_id')
  String? transactionId;
  @JsonKey(name: 'form_key')
  String? formKey;
  @JsonKey(name: 'form_type')
  String? formType;
  @JsonKey(name: 'units')
  String? units;
  @JsonKey(name: 'worklevels')
  String? workLevels;
  @JsonKey(name: 'result_code')
  String? resultCode;
  @JsonKey(name: 'resubmited_transaction_id')
  int? resubmittedTransactionId;
  @JsonKey(name: 'unit_wl_version')
  String? unitWlVersion;
  @JsonKey(name: 'tbv_count')
  String? tbvCount;
  @JsonKey(name: 'pdf')
  Pdf? pdf;

  PreviousVersion();

  factory PreviousVersion.fromJson(Map<String, dynamic> json) =>
      _$PreviousVersionFromJson(json);

  Map<String, dynamic> toJson() => _$PreviousVersionToJson(this);
}

@JsonSerializable()
class Pdf{
  @JsonKey(name: 'file_path')
  String? filePath;
  @JsonKey(name: 'file_size')
  double? fileSize;
  @JsonKey(name: 'file_extension')
  String? fileExtension;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;

  Pdf();

  factory Pdf.fromJson(Map<String, dynamic> json) =>
      _$PdfFromJson(json);

  Map<String, dynamic> toJson() => _$PdfToJson(this);
}


