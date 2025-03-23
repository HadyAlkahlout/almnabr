import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/previous_versions/previous_versions_response.dart';

part 'related_activities_response.g.dart';

@JsonSerializable()
class RelatedActivitiesResponse {
  @JsonKey(name: 'getWIRUnitsRelatedActivities')
  PreviousVersions? relatedActivities;

  RelatedActivitiesResponse();

  factory RelatedActivitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$RelatedActivitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedActivitiesResponseToJson(this);
}
