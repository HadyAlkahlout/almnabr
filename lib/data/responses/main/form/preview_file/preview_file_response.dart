import 'package:json_annotation/json_annotation.dart';

part 'preview_file_response.g.dart';

@JsonSerializable()
class PreviewFileResponse {
  @JsonKey(name: 'previewWIRTransaction')
  PreviewWirTransaction? previewWirTransaction;

  PreviewFileResponse();

  factory PreviewFileResponse.fromJson(Map<String, dynamic> json) =>
      _$PreviewFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewFileResponseToJson(this);

}

@JsonSerializable()
class PreviewWirTransaction {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  FileData? data;

  PreviewWirTransaction();

  factory PreviewWirTransaction.fromJson(Map<String, dynamic> json) =>
      _$PreviewWirTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewWirTransactionToJson(this);

}

@JsonSerializable()
class FileData{
  @JsonKey(name: 'export_type')
  String? exportType;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'mime_type')
  String? mimeType;
  @JsonKey(name: 'content')
  String? content;

  FileData();

  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataToJson(this);

}
