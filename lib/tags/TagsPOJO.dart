import 'package:json_annotation/json_annotation.dart';
part 'TagsPOJO.g.dart';


/*
"count": 5281,
	"next": "https://api.rawg.io/api/tags?page=2",
	"previous": null,
	"results": [{
		"id": 31,
		"name": "Singleplayer",
		"slug": "singleplayer",
		"games_count": 62672,
		"image_background": "https://media.rawg.io/media/games/1d5/1d553996f8c07c06d5f5e526c65d33a4.jpg",
		"language": "eng",
		"games": [{
			"id": 3498,
			"slug": "grand-theft-auto-v",
			"name": "Grand Theft Auto V",
			"added": 9809
		}, {
]
	},
 */
@JsonSerializable()
class GameTagsPOJO
{
  int count;
  List<TagResult>results;
  GameTagsPOJO(this.count,this.results);
  factory GameTagsPOJO.fromJson(Map<String, dynamic> json) =>_$GameTagsPOJOFromJson(json);
  Map<String, dynamic> toJson() => _$GameTagsPOJOToJson(this);

}

@JsonSerializable()
class TagResult
{
  int id;
  String name;
  String image_background;
  List<TagGames>games;
  TagResult(this.id,this.name,this.image_background);
  factory TagResult.fromJson(Map<String, dynamic> json) =>_$TagResultFromJson(json);
  Map<String, dynamic> toJson() => _$TagResultToJson(this);
}

@JsonSerializable()
class TagGames
{
  int id;
  String name;
  TagGames(this.id,this.name);
  factory TagGames.fromJson(Map<String, dynamic> json) =>_$TagGamesFromJson(json);
  Map<String, dynamic> toJson() => _$TagGamesToJson(this);
}