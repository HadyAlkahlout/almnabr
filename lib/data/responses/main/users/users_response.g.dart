// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersResponse _$UsersResponseFromJson(Map<String, dynamic> json) =>
    UsersResponse()
      ..users = json['searchUsersOnConstruction'] == null
          ? null
          : Users.fromJson(
              json['searchUsersOnConstruction'] as Map<String, dynamic>);

Map<String, dynamic> _$UsersResponseToJson(UsersResponse instance) =>
    <String, dynamic>{
      'searchUsersOnConstruction': instance.users,
    };

Users _$UsersFromJson(Map<String, dynamic> json) => Users()
  ..status = json['status'] as bool?
  ..message = json['message'] as String?
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData()
  ..id = json['id'] as String?
  ..title = json['title'] as String?
  ..email = json['email'] as String?
  ..mobile = json['mobile'] as String?
  ..photo = json['photo'] as String?;

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'email': instance.email,
      'mobile': instance.mobile,
      'photo': instance.photo,
    };
