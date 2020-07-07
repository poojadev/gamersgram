
import 'package:json_annotation/json_annotation.dart';
part 'GenresPOJO.g.dart';
/*


{
	"count": 19,
	"next": null,
	"previous": null,
	"results": [{
		"id": 4,
		"name": "Action",
		"slug": "action",
		"games_count": 77543,
		"image_background": "https://media.rawg.io/media/games/c25/c25ebb8eb08790277ae2e2dce0d62174.jpg",
		"games": [{
			"id": 3498,
			"slug": "grand-theft-auto-v",
			"name": "Grand Theft Auto V",
			"added": 9684
		}
 */
@JsonSerializable()
class GenresPOJO
{
  int count;
  List<GenresResult>results;
  GenresPOJO(this.count,this.results);
  factory GenresPOJO.fromJson(Map<String, dynamic> json) => _$GenresPOJOFromJson(json);
  Map<String, dynamic> toJson() => _$GenresPOJOToJson(this);

}
@JsonSerializable()
class GenresResult
{
   String name;
   int id;
   int games_count;
   String image_background;
   List<GenresGames>games;

   GenresResult(this.name,this.id,this.games_count,this.image_background,this.games);
   factory GenresResult.fromJson(Map<String, dynamic> json) => _$GenresResultFromJson(json);
   Map<String, dynamic> toJson() => _$GenresResultToJson(this);
}

@JsonSerializable()

class GenresGames
{
  int id;
  String name;
  GenresGames(this.id,this.name);
  factory GenresGames.fromJson(Map<String, dynamic> json) => _$GenresGamesFromJson(json);
  Map<String, dynamic> toJson() => _$GenresGamesToJson(this);

}



@JsonSerializable()
class GameGenresDetails
{
  int id;
  String name;
  String image_background;
  String description;
  GameGenresDetails(this.id,this.name,this.image_background,this.description);
  factory GameGenresDetails.fromJson(Map<String, dynamic> json) =>_$GameGenresDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GameGenresDetailsToJson(this);

}