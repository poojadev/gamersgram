import 'package:json_annotation/json_annotation.dart';
part 'GameStores.g.dart';

/*

"count": 10,
	"next": null,
	"previous": null,
	"results": [{
		"id": 1,
		"name": "Steam",
		"domain": "store.steampowered.com",
		"slug": "steam",
		"games_count": 39741,
		"image_background": "https://media.rawg.io/media/games/588/588c6bdff3d4baf66ec36b1c05b793bf.jpg",
"games": [{
			"id": 1030,
			"slug": "limbo",
			"name": "Limbo",
			"added": 6989
		},
		}],
		"following": false
	},
 */

@JsonSerializable()
class GameStores
{
   int count;
   List<StoreResult>results;
   GameStores(this.count,this.results);
   factory GameStores.fromJson(Map<String, dynamic> json) =>_$GameStoresFromJson(json);
   Map<String, dynamic> toJson() => _$GameStoresToJson(this);


}

@JsonSerializable()
class StoreResult
{
  int id;
  String name;
  String domain;
  String image_background;
  List<StoreGames>games;
  String description;
  StoreResult(this.id,this.name,this.domain,this.image_background,this.games);
  factory StoreResult.fromJson(Map<String, dynamic> json) =>_$StoreResultFromJson(json);
  Map<String, dynamic> toJson() => _$StoreResultToJson(this);
}
@JsonSerializable()
class StoreGames
{
  int id;
  String name;
  StoreGames(this.id,this.name);
  factory StoreGames.fromJson(Map<String, dynamic> json) =>_$StoreGamesFromJson(json);
  Map<String, dynamic> toJson() => _$StoreGamesToJson(this);
}

@JsonSerializable()
class GameStoreDetails
{
  int id;
  String name;
  String domain;
  String image_background;
  String description;
  GameStoreDetails(this.id,this.name,this.domain,this.image_background,this.description);
  factory GameStoreDetails.fromJson(Map<String, dynamic> json) =>_$GameStoreDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GameStoreDetailsToJson(this);

}