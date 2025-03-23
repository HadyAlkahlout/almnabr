import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'manager_approval_response.g.dart';

@JsonSerializable()
class ManagerApprovalResponse {
  @JsonKey(name: 'noSetupWIRContractorManagerApproval')
  GenericResponse? noSetupWirContractorManagerApproval;
  @JsonKey(name: 'wirContractorManagerApproval')
  GenericResponse? wirContractorManagerApproval;

  ManagerApprovalResponse();

  factory ManagerApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagerApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerApprovalResponseToJson(this);
}
