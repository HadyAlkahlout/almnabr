import 'package:json_annotation/json_annotation.dart';

part 'positions_response.g.dart';

@JsonSerializable()
class PositionsResponse {
  @JsonKey(name: 'searchPositionsOnConstruction')
  Positions? positions;

  PositionsResponse();

  factory PositionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PositionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PositionsResponseToJson(this);

}

@JsonSerializable()
class Positions {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<PositionData>? data;

  Positions();

  factory Positions.fromJson(Map<String, dynamic> json) =>
      _$PositionsFromJson(json);

  Map<String, dynamic> toJson() => _$PositionsToJson(this);
}

@JsonSerializable()
class PositionData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  bool isSelected = false;

  PositionData();

  factory PositionData.fromJson(Map<String, dynamic> json) =>
      _$PositionDataFromJson(json);

  Map<String, dynamic> toJson() => _$PositionDataToJson(this);

}