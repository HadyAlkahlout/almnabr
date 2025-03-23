import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging {
  @JsonKey(name: 'total')
  int total = 1;
  @JsonKey(name: 'currentPage')
  int currentPage = 1;
  @JsonKey(name: 'lastPage')
  int lastPage = 1;
  @JsonKey(name: 'from')
  int? from;
  @JsonKey(name: 'to')
  int? to;

  Paging();

  factory Paging.fromJson(Map<String, dynamic> json) =>
      _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);

}