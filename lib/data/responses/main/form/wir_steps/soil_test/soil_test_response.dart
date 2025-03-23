import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'soil_test_response.g.dart';

@JsonSerializable()
class SoilTestResponse {
  @JsonKey(name: 'noSetupWIRSoilTestTransactionApproval')
  GenericResponse? noSetupWirSoilTest;
  @JsonKey(name: 'wirSoilTestTransactionApproval')
  GenericResponse? wirSoilTest;

  SoilTestResponse();

  factory SoilTestResponse.fromJson(Map<String, dynamic> json) =>
      _$SoilTestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SoilTestResponseToJson(this);
}
