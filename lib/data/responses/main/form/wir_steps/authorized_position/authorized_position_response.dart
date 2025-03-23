import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'authorized_position_response.g.dart';

@JsonSerializable()
class AuthorizedPositionResponse {
  @JsonKey(name: 'noSetupWIRAuthorizedPositionApproval')
  GenericResponse? noSetupWirAuthorizedPosition;
  @JsonKey(name: 'wirAuthorizedPositionApproval')
  GenericResponse? wirAuthorizedPosition;

  AuthorizedPositionResponse();

  factory AuthorizedPositionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedPositionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizedPositionResponseToJson(this);
}
