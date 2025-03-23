import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'result_receiving_response.g.dart';

@JsonSerializable()
class ResultReceivingResponse {
  @JsonKey(name: 'noSetupWIRResultReceiving')
  GenericResponse? noSetupWirResultReceiving;
  @JsonKey(name: 'wirResultReceiving')
  GenericResponse? wirResultReceiving;

  ResultReceivingResponse();

  factory ResultReceivingResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultReceivingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResultReceivingResponseToJson(this);
}
