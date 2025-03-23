import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'owner_approval_response.g.dart';

@JsonSerializable()
class OwnerApprovalResponse {
  @JsonKey(name: 'noSetupWIROwnerApproval')
  GenericResponse? noSetupWirOwnerApproval;
  @JsonKey(name: 'wirOwnerApproval')
  GenericResponse? wirOwnerApproval;

  OwnerApprovalResponse();

  factory OwnerApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnerApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerApprovalResponseToJson(this);
}
