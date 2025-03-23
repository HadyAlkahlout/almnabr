import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'pmc_approval_response.g.dart';

@JsonSerializable()
class PMCApprovalResponse {
  @JsonKey(name: 'wirPMCApproval')
  GenericResponse? wirPMCApproval;

  PMCApprovalResponse();

  factory PMCApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$PMCApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PMCApprovalResponseToJson(this);
}
