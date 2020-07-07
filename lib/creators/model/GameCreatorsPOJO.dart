import 'package:json_annotation/json_annotation.dart';
part 'GameCreatorsPOJO.g.dart';

/*

	"count": 23714,
	"next": "https://api.rawg.io/api/creators?page=4",
	"previous": "https://api.rawg.io/api/creators?page=2",
	"results": [{
		"id": 248,
		"name": "Peter McConnell",
		"slug": "peter-mcconnell",
		"image": "https://media.rawg.io/media/persons_wiki/138/138a4d3b394d948619f852a5ab166e3a.jpg",
		"image_background": "https://media.rawg.io/media/games/af7/af7a831001c5c32c46e950cc883b8cb7.jpg",
		"games_count": 33,
		"positions": [{
			"id": 3,
			"name": "composer",
			"slug": "composer"
		}],
		"games": [{
			"id": 5525,
			"slug": "brutal-legend",
			"name": "Brutal Legend",
			"added": 4485
		}, {
			"id": 2361,
			"slug": "psychonauts",
			"name": "Psychonauts",
			"added": 4026
		}, {
			"id": 1774,
			"slug": "grim-fandango-remastered",
			"name": "Grim Fandango Remastered",
			"added": 3253
		}, {
			"id": 1758,
			"slug": "valiant-hearts-the-great-war",
			"name": "Valiant Hearts: The Great War",
			"added": 2628
		}, {
			"id": 3350,
			"slug": "broken-age",
			"name": "Broken Age",
			"added": 2597
		}, {
			"id": 2639,
			"slug": "day-of-the-tentacle-remastered",
			"name": "Day of the Tentacle Remastered",
			"added": 1692
		}]
	},
 */
@JsonSerializable()
class GameCreatorsPOJO
{
   int count;
   List<CreatorsResult>results;
   GameCreatorsPOJO(this.count,this.results);

   factory GameCreatorsPOJO.fromJson(Map<String, dynamic> json) =>_$GameCreatorsPOJOFromJson(json);
   Map<String, dynamic> toJson() => _$GameCreatorsPOJOToJson(this);
}

@JsonSerializable()
class CreatorsResult
{
  int id;
  String name;
  String image;
  String image_background;
  List<CreatorRole>positions;
  List<CreatorsGames>games;
  CreatorsResult(this.id,this.name,this.image,this.image_background,this.positions,this.games);
  factory CreatorsResult.fromJson(Map<String, dynamic> json) =>_$CreatorsResultFromJson(json);
  Map<String, dynamic> toJson() => _$CreatorsResultToJson(this);


}


@JsonSerializable()
class CreatorRole
{
   int id;
   String name;
   CreatorRole(this.id,this.name);
   factory CreatorRole.fromJson(Map<String, dynamic> json) =>_$CreatorRoleFromJson(json);
   Map<String, dynamic> toJson() => _$CreatorRoleToJson(this);

}

@JsonSerializable()
class CreatorsGames
{
   int id;
   String name;
   CreatorsGames(this.id,this.name);
   factory CreatorsGames.fromJson(Map<String, dynamic> json) =>_$CreatorsGamesFromJson(json);
   Map<String, dynamic> toJson() => _$CreatorsGamesToJson(this);

}


/*
{
	"id": 22699,
	"name": "Viktor Antonov",
	"slug": "viktor-antonov",
	"image": "https://media.rawg.io/media/persons/dc6/dc63df6ed60009f8a15bb57ccd62f096.jpg",
	"image_background": "https://media.rawg.io/media/games/b8c/b8c243eaa0fbac8115e0cdccac3f91dc.jpg",
	"description": "<p>Viktor Antonov is a games artist who started the games industry career in 1900. Since then, Antonov has been working with Arkane Studios, Bethesda Softworks, Valve Software and Xatrix Entertainment. Antonov started as the artist of The Crossing. After that, Viktor Antonov took part as the artist of Redneck Rampage. Later, Antonov also was part of the team who developed Dark Messiah of Might &amp; Magic published by Ubisoft Entertainment for PC and Xbox 360. Most lately, Viktor Antonov worked on Dishonored Definitive Edition.</p>",
	"games_count": 12,
	"reviews_count": 4639,
	"rating": "4.17",
	"rating_top": 5,
	"updated": "2020-01-04T05:53:03",
	"positions": [{
		"id": 4,
		"name": "artist",
		"slug": "artist"
	}],
	"platforms": {
		"total": 9,
		"results": [{
			"count": 12,
			"percent": 40.0,
			"platform": {
				"id": 1,
				"name": "PC",
				"slug": "pc"
			}
		}, {
			"count": 6,
			"percent": 20.0,
			"platform": {
				"id": 3,
				"name": "Xbox",
				"slug": "xbox"
			}
		},
 */

@JsonSerializable()
class GamesCreatorsDetails
{
   int id;
   String name;
   String image;
   String description;
   int games_count;
   List<Positions>positions;
   CreatorPlatformList platforms;
   GamesCreatorsDetails(this.id,this.name,this.image,this.description,this.games_count,this.positions,this.platforms);
   factory GamesCreatorsDetails.fromJson(Map<String, dynamic> json) =>_$GamesCreatorsDetailsFromJson(json);
   Map<String, dynamic> toJson() => _$GamesCreatorsDetailsToJson(this);



}

@JsonSerializable()
class Positions
{
  int id;
  String name;
  Positions(this.id,this.name);
  factory Positions.fromJson(Map<String, dynamic> json) =>_$PositionsFromJson(json);
  Map<String, dynamic> toJson() => _$PositionsToJson(this);

}

@JsonSerializable()
class CreatorPlatformList
{
   int total;
   List<PlatformResults>results;
   CreatorPlatformList(this.total,this.results);
   factory CreatorPlatformList.fromJson(Map<String, dynamic> json) =>_$CreatorPlatformListFromJson(json);
   Map<String, dynamic> toJson() => _$CreatorPlatformListToJson(this);


}

@JsonSerializable()
class PlatformResults
{
  int count;
  platformDetails platform;
  PlatformResults(this.count,this.platform);
  factory PlatformResults.fromJson(Map<String, dynamic> json) =>_$PlatformResultsFromJson(json);
  Map<String, dynamic> toJson() => _$PlatformResultsToJson(this);


}

@JsonSerializable()
class platformDetails
{
  int id;
  String name;
  String slug;
  platformDetails(this.id,this.name,this.slug);
  factory platformDetails.fromJson(Map<String, dynamic> json) =>_$platformDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$platformDetailsToJson(this);
}