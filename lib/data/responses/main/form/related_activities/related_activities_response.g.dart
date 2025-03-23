// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_activities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedActivitiesResponse _$RelatedActivitiesResponseFromJson(
        Map<String, dynamic> json) =>
    RelatedActivitiesResponse()
      ..relatedActivities = json['getWIRUnitsRelatedActivities'] == null
          ? null
          : PreviousVersions.fromJson(
              json['getWIRUnitsRelatedActivities'] as Map<String, dynamic>);

Map<String, dynamic> _$RelatedActivitiesResponseToJson(
        RelatedActivitiesResponse instance) =>
    <String, dynamic>{
      'getWIRUnitsRelatedActivities': instance.relatedActivities,
    };
