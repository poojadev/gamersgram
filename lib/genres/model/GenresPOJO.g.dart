// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenresPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenresPOJO _$GenresPOJOFromJson(Map<String, dynamic> json) {
  return GenresPOJO(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : GenresResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GenresPOJOToJson(GenresPOJO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

GenresResult _$GenresResultFromJson(Map<String, dynamic> json) {
  return GenresResult(
    json['name'] as String,
    json['id'] as int,
    json['games_count'] as int,
    json['image_background'] as String,
    (json['games'] as List)
        ?.map((e) =>
            e == null ? null : GenresGames.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GenresResultToJson(GenresResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'games_count': instance.games_count,
      'image_background': instance.image_background,
      'games': instance.games,
    };

GenresGames _$GenresGamesFromJson(Map<String, dynamic> json) {
  return GenresGames(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$GenresGamesToJson(GenresGames instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

GameGenresDetails _$GameGenresDetailsFromJson(Map<String, dynamic> json) {
  return GameGenresDetails(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$GameGenresDetailsToJson(GameGenresDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
      'description': instance.description,
    };
