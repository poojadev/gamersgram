// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagsPOJO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameTagsPOJO _$GameTagsPOJOFromJson(Map<String, dynamic> json) {
  return GameTagsPOJO(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : TagResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameTagsPOJOToJson(GameTagsPOJO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

TagResult _$TagResultFromJson(Map<String, dynamic> json) {
  return TagResult(
    json['id'] as int,
    json['name'] as String,
    json['image_background'] as String,
  )..games = (json['games'] as List)
      ?.map((e) =>
          e == null ? null : TagGames.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$TagResultToJson(TagResult instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_background': instance.image_background,
      'games': instance.games,
    };

TagGames _$TagGamesFromJson(Map<String, dynamic> json) {
  return TagGames(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$TagGamesToJson(TagGames instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
