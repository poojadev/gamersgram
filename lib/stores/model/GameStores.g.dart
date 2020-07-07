// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameStores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStores _$GameStoresFromJson(Map<String, dynamic> json) {
  return GameStores(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : StoreResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameStoresToJson(GameStores instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

StoreResult _$StoreResultFromJson(Map<String, dynamic> json) {
  return StoreResult(
    json['id'] as int,
    json['name'] as String,
    json['domain'] as String,
    json['image_background'] as String,
    (json['games'] as List)
        ?.map((e) =>
            e == null ? null : StoreGames.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..description = json['description'] as String;
}

Map<String, dynamic> _$StoreResultToJson(StoreResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain': instance.domain,
      'image_background': instance.image_background,
      'games': instance.games,
      'description': instance.description,
    };

StoreGames _$StoreGamesFromJson(Map<String, dynamic> json) {
  return StoreGames(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$StoreGamesToJson(StoreGames instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

GameStoreDetails _$GameStoreDetailsFromJson(Map<String, dynamic> json) {
  return GameStoreDetails(
    json['id'] as int,
    json['name'] as String,
    json['domain'] as String,
    json['image_background'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$GameStoreDetailsToJson(GameStoreDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain': instance.domain,
      'image_background': instance.image_background,
      'description': instance.description,
    };
