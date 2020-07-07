// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GamePublisherPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamePublisherPOJO _$GamePublisherPOJOFromJson(Map<String, dynamic> json) {
  return GamePublisherPOJO(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : GamePublisherResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GamePublisherPOJOToJson(GamePublisherPOJO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

GamePublisherResult _$GamePublisherResultFromJson(Map<String, dynamic> json) {
  return GamePublisherResult(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
    (json['games'] as List)
        ?.map((e) => e == null
            ? null
            : PublisherGames.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GamePublisherResultToJson(
        GamePublisherResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
      'games': instance.games,
    };

PublisherGames _$PublisherGamesFromJson(Map<String, dynamic> json) {
  return PublisherGames(
    json['id'] as int,
    json['name'] as String,
    json['added'] as int,
  );
}

Map<String, dynamic> _$PublisherGamesToJson(PublisherGames instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'added': instance.added,
    };

GamePublisherDetails _$GamePublisherDetailsFromJson(Map<String, dynamic> json) {
  return GamePublisherDetails(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$GamePublisherDetailsToJson(
        GamePublisherDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
      'description': instance.description,
    };
