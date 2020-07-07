// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlatformListPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformList _$PlatformListFromJson(Map<String, dynamic> json) {
  return PlatformList(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : PlatformListDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlatformListToJson(PlatformList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

PlatformListDetails _$PlatformListDetailsFromJson(Map<String, dynamic> json) {
  return PlatformListDetails(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
  );
}

Map<String, dynamic> _$PlatformListDetailsToJson(
        PlatformListDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
    };

PlatformDescription _$PlatformDescriptionFromJson(Map<String, dynamic> json) {
  return PlatformDescription(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$PlatformDescriptionToJson(
        PlatformDescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
      'description': instance.description,
    };
