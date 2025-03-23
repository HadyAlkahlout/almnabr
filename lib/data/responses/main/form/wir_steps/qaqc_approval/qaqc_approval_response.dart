import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'qaqc_approval_response.g.dart';

@JsonSerializable()
class QaqcApprovalResponse {
  @JsonKey(name: 'noSetupWIRContractorQAQCApproval')
  GenericResponse? noSetupWirContractorQAQCApproval;
  @JsonKey(name: 'wirContractorQAQCApproval')
  GenericResponse? wirContractorQAQCApproval;

  QaqcApprovalResponse();

  factory QaqcApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$QaqcApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QaqcApprovalResponseToJson(this);
}
