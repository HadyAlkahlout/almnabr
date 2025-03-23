import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class GetUsersResponse {
  @JsonKey(name: 'getStepUsersBySteps')
  GetUsers? getStepUsers;

  GetUsersResponse();

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersResponseToJson(this);
}

@JsonSerializable()
class GetUsers {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'assign_manual_user')
  String? assignManualUser;
  @JsonKey(name: 'current_step')
  String? currentStep;
  @JsonKey(name: 'current_step_name')
  String? currentStepName;
  @JsonKey(name: 'users')
  List<User>? users;
  @JsonKey(name: 'system_users')
  List<User>? systemUsers;
  @JsonKey(name: 'custom_users')
  List<User>? customUsers;

  GetUsers();

  factory GetUsers.fromJson(Map<String, dynamic> json) =>
      _$GetUsersFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'custom_user')
  String? customUser;
  @JsonKey(name: 'position')
  int? position;
  @JsonKey(name: 'position_title_en')
  String? positionTitleEn;
  @JsonKey(name: 'position_title_ar')
  String? positionTitleAr;

  User();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
