import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_persons.g.dart';

@JsonSerializable()
class TransactionPersons {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<Person>? data;

  TransactionPersons();

  factory TransactionPersons.fromJson(Map<String, dynamic> json) =>
      _$TransactionPersonsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionPersonsToJson(this);
}

@JsonSerializable()
class Person {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'position')
  Chapter? position;
  @JsonKey(name: 'user')
  Writer? user;
  @JsonKey(name: 'notes')
  List<dynamic>? notes;
  @JsonKey(name: 'person_type')
  String? personType;
  @JsonKey(name: 'viewed_status')
  bool? viewedStatus;
  @JsonKey(name: 'approved_status')
  bool? approvedStatus;
  @JsonKey(name: 'step_name')
  String? stepName;

  Person();

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}