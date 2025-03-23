import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'special_approval_response.g.dart';

@JsonSerializable()
class SpecialApprovalResponse {
  @JsonKey(name: 'noSetupWIRSpecialApproval')
  GenericResponse? noSetupWirSpecialApproval;
  @JsonKey(name: 'wirSpecialApproval')
  GenericResponse? wirSpecialApproval;

  SpecialApprovalResponse();

  factory SpecialApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecialApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialApprovalResponseToJson(this);
}
