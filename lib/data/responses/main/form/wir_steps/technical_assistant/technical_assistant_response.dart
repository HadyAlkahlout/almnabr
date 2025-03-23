import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'technical_assistant_response.g.dart';

@JsonSerializable()
class TechnicalAssistantResponse {
  @JsonKey(name: 'noSetupWIRTechnicalAssistanceTransaction')
  GenericResponse? noSetupWirTechnicalAssistant;
  @JsonKey(name: 'wirTechnicalAssistanceTransaction')
  GenericResponse? wirTechnicalAssistant;

  TechnicalAssistantResponse();

  factory TechnicalAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$TechnicalAssistantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalAssistantResponseToJson(this);
}
