import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'add_users_response.g.dart';

@JsonSerializable()
class AddUsersResponse {
  @JsonKey(name: 'assignTransactionStepUsers')
  GenericResponse? assignUsers;

  AddUsersResponse();

  factory AddUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AddUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddUsersResponseToJson(this);
}
