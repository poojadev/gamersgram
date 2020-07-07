// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameListPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameList _$GameListFromJson(Map<String, dynamic> json) {
  return GameList(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : GameListDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameListToJson(GameList instance) => <String, dynamic>{
      'results': instance.results,
      'count': instance.count,
    };

GameListDetails _$GameListDetailsFromJson(Map<String, dynamic> json) {
  return GameListDetails(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['released'] as String,
    json['background_image'] as String,
    (json['rating'] as num)?.toDouble(),
    json['clip'] == null
        ? null
        : Clip.fromJson(json['clip'] as Map<String, dynamic>),
    (json['genres'] as List)
        ?.map((e) =>
            e == null ? null : Genres.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['short_screenshots'] as List)
        ?.map((e) =>
            e == null ? null : Screenshots.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['stores'] as List)
        ?.map((e) =>
            e == null ? null : Stores.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['platforms'] as List)
        ?.map((e) =>
            e == null ? null : Platforms.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['developers'] as List)
        ?.map((e) => e == null
            ? null
            : GameDevelopers.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['website'] as String,
  );
}

Map<String, dynamic> _$GameListDetailsToJson(GameListDetails instance) =>
    <String, dynamic>{
      'released': instance.released,
      'background_image': instance.background_image,
      'rating': instance.rating,
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'stores': instance.stores,
      'clip': instance.clip,
      'short_screenshots': instance.short_screenshots,
      'genres': instance.genres,
      'platforms': instance.platforms,
      'developers': instance.developers,
      'website': instance.website,
    };

Platforms _$PlatformsFromJson(Map<String, dynamic> json) {
  return Platforms(
    json['platform'] == null
        ? null
        : PlatformDetails.fromJson(json['platform'] as Map<String, dynamic>),
    json['requirements'] == null
        ? null
        : GameRequirements.fromJson(
            json['requirements'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlatformsToJson(Platforms instance) => <String, dynamic>{
      'platform': instance.platform,
      'requirements': instance.requirements,
    };

PlatformDetails _$PlatformDetailsFromJson(Map<String, dynamic> json) {
  return PlatformDetails(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$PlatformDetailsToJson(PlatformDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Screenshots _$ScreenshotsFromJson(Map<String, dynamic> json) {
  return Screenshots(
    json['id'] as int,
    json['image'] as String,
  );
}

Map<String, dynamic> _$ScreenshotsToJson(Screenshots instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
    };

Stores _$StoresFromJson(Map<String, dynamic> json) {
  return Stores(
    json['store'] == null
        ? null
        : StoreList.fromJson(json['store'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StoresToJson(Stores instance) => <String, dynamic>{
      'store': instance.store,
    };

StoreList _$StoreListFromJson(Map<String, dynamic> json) {
  return StoreList(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$StoreListToJson(StoreList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Clip _$ClipFromJson(Map<String, dynamic> json) {
  return Clip(
    json['clip'] as String,
    json['clips'] == null
        ? null
        : Clips.fromJson(json['clips'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ClipToJson(Clip instance) => <String, dynamic>{
      'clip': instance.clip,
      'clips': instance.clips,
    };

Clips _$ClipsFromJson(Map<String, dynamic> json) {
  return Clips(
    json['full'] as String,
  );
}

Map<String, dynamic> _$ClipsToJson(Clips instance) => <String, dynamic>{
      'full': instance.full,
    };

Genres _$GenresFromJson(Map<String, dynamic> json) {
  return Genres(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

GameRequirements _$GameRequirementsFromJson(Map<String, dynamic> json) {
  return GameRequirements(
    json['minimum'] as String,
    json['recommended'] as String,
  );
}

Map<String, dynamic> _$GameRequirementsToJson(GameRequirements instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
      'recommended': instance.recommended,
    };

GameDevelopers _$GameDevelopersFromJson(Map<String, dynamic> json) {
  return GameDevelopers(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$GameDevelopersToJson(GameDevelopers instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
