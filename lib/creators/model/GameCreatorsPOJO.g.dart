// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameCreatorsPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCreatorsPOJO _$GameCreatorsPOJOFromJson(Map<String, dynamic> json) {
  return GameCreatorsPOJO(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : CreatorsResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameCreatorsPOJOToJson(GameCreatorsPOJO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

CreatorsResult _$CreatorsResultFromJson(Map<String, dynamic> json) {
  return CreatorsResult(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String,
    json['image_background'] as String,
    (json['positions'] as List)
        ?.map((e) =>
            e == null ? null : CreatorRole.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['games'] as List)
        ?.map((e) => e == null
            ? null
            : CreatorsGames.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CreatorsResultToJson(CreatorsResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'image_background': instance.image_background,
      'positions': instance.positions,
      'games': instance.games,
    };

CreatorRole _$CreatorRoleFromJson(Map<String, dynamic> json) {
  return CreatorRole(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CreatorRoleToJson(CreatorRole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CreatorsGames _$CreatorsGamesFromJson(Map<String, dynamic> json) {
  return CreatorsGames(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CreatorsGamesToJson(CreatorsGames instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

GamesCreatorsDetails _$GamesCreatorsDetailsFromJson(Map<String, dynamic> json) {
  return GamesCreatorsDetails(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String,
    json['description'] as String,
    json['games_count'] as int,
    (json['positions'] as List)
        ?.map((e) =>
            e == null ? null : Positions.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['platforms'] == null
        ? null
        : CreatorPlatformList.fromJson(
            json['platforms'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GamesCreatorsDetailsToJson(
        GamesCreatorsDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'games_count': instance.games_count,
      'positions': instance.positions,
      'platforms': instance.platforms,
    };

Positions _$PositionsFromJson(Map<String, dynamic> json) {
  return Positions(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$PositionsToJson(Positions instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CreatorPlatformList _$CreatorPlatformListFromJson(Map<String, dynamic> json) {
  return CreatorPlatformList(
    json['total'] as int,
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : PlatformResults.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CreatorPlatformListToJson(
        CreatorPlatformList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'results': instance.results,
    };

PlatformResults _$PlatformResultsFromJson(Map<String, dynamic> json) {
  return PlatformResults(
    json['count'] as int,
    json['platform'] == null
        ? null
        : platformDetails.fromJson(json['platform'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlatformResultsToJson(PlatformResults instance) =>
    <String, dynamic>{
      'count': instance.count,
      'platform': instance.platform,
    };

platformDetails _$platformDetailsFromJson(Map<String, dynamic> json) {
  return platformDetails(
    json['id'] as int,
    json['name'] as String,
    json['slug'] as String,
  );
}

Map<String, dynamic> _$platformDetailsToJson(platformDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
