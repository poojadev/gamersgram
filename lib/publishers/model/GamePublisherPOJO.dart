import 'package:json_annotation/json_annotation.dart';
part 'GamePublisherPOJO.g.dart';


@JsonSerializable()
class  GamePublisherPOJO
{
  int count;
  List<GamePublisherResult>results;
  GamePublisherPOJO(this.count,this.results);
  factory GamePublisherPOJO.fromJson(Map<String, dynamic> json) => _$GamePublisherPOJOFromJson(json);
  Map<String, dynamic> toJson() => _$GamePublisherPOJOToJson(this);

}
@JsonSerializable()
class GamePublisherResult
{
  int id;
  String name;
  String image_background;
  List<PublisherGames>games;

  GamePublisherResult(this.id, this.name, this.image_background, this.games);

  factory GamePublisherResult.fromJson(Map<String, dynamic> json) =>
      _$GamePublisherResultFromJson(json);

  Map<String, dynamic> toJson() => _$GamePublisherResultToJson(this);

}
@JsonSerializable()

class PublisherGames
{
  int id;
  String name;
  int added;
  PublisherGames(this.id,this.name,this.added);
  factory PublisherGames.fromJson(Map<String, dynamic> json) => _$PublisherGamesFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherGamesToJson(this);
}






@JsonSerializable()
class GamePublisherDetails
{
  int id;
  String name;
  String image_background;
  String description;
  GamePublisherDetails(this.id,this.name,this.image_background,this.description);
  factory GamePublisherDetails.fromJson(Map<String, dynamic> json) =>_$GamePublisherDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GamePublisherDetailsToJson(this);

}








/*


{
	"count": 40134,
	"next": null,
	"previous": "https://api.rawg.io/api/publishers?page=4013",
	"results": [{
		"id": 18611,
		"name": "Oh!WHATif Inc.",
		"slug": "ohwhatif-inc",
		"games_count": 1,
		"image_background": "https://media.rawg.io/media/screenshots/191/191e2cb13ab8c679641640902e7656ba.jpg",
		"games": [{
			"id": 50674,
			"slug": "battlesky-vr",
			"name": "BattleSky VR",
			"added": 0
		}]

	}]
}
 */