import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'team_approval_response.g.dart';

@JsonSerializable()
class TeamApprovalResponse {
  @JsonKey(name: 'noSetupWIRContractorTeamApproval')
  GenericResponse? noSetupWirContractorTeamApproval;
  @JsonKey(name: 'wirContractorTeamApproval')
  GenericResponse? wirContractorTeamApproval;

  TeamApprovalResponse();

  factory TeamApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeamApprovalResponseToJson(this);
}
