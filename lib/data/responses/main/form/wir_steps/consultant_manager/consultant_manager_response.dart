import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'consultant_manager_response.g.dart';

@JsonSerializable()
class ConsultantManagerResponse {
  @JsonKey(name: 'noSetupWIRConsultantManagerApproval')
  GenericResponse? noSetupWirConsultantManager;
  @JsonKey(name: 'wirConsultantManagerApproval')
  GenericResponse? wirConsultantManager;

  ConsultantManagerResponse();

  factory ConsultantManagerResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultantManagerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultantManagerResponseToJson(this);
}
