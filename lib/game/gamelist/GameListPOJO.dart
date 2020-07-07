import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

import 'package:gamersgram/stores/model/GameStores.dart';
part 'GameListPOJO.g.dart';


@JsonSerializable()
class GameList
{
   List<GameListDetails>results;
   int count;

   GameList(this.count,this.results);
   factory GameList.fromJson(Map<String, dynamic> json) =>_$GameListFromJson(json);
   Map<String, dynamic> toJson() => _$GameListToJson(this);
}

@JsonSerializable()

class GameListDetails
{
  String released;
  String background_image;
  double rating;
  String name;
  int id;
  String description;
  List<Stores>stores;
  Clip clip;
  List<Screenshots>short_screenshots;
  List<Genres>genres;
  List<Platforms>platforms;
  List<GameDevelopers>developers;
  String website;

  GameListDetails(this.id, this.name, this.description, this.released,
      this.background_image, this.rating, this.clip, this.genres,
      this.short_screenshots, this.stores, this.platforms, this.developers,
      this.website);
  factory GameListDetails.fromJson(Map<String, dynamic> json) =>_$GameListDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GameListDetailsToJson(this);

}
@JsonSerializable()
class Platforms
{
  PlatformDetails platform;
  GameRequirements requirements;

  Platforms(this.platform, this.requirements);
   factory Platforms.fromJson(Map<String, dynamic> json) =>_$PlatformsFromJson(json);
   Map<String, dynamic> toJson() => _$PlatformsToJson(this);
}
@JsonSerializable()
class PlatformDetails
{
  int id;
  String name;
  PlatformDetails(this.id,this.name);
  factory PlatformDetails.fromJson(Map<String, dynamic> json) =>_$PlatformDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PlatformDetailsToJson(this);

}

@JsonSerializable()

class Screenshots
{
  int id;
  String image;
  Screenshots(this.id,this.image);
  factory Screenshots.fromJson(Map<String, dynamic> json) =>_$ScreenshotsFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenshotsToJson(this);
}

@JsonSerializable()

class Stores
{
  
  StoreList store;
  Stores(this.store);
  factory Stores.fromJson(Map<String, dynamic> json) =>_$StoresFromJson(json);
  Map<String, dynamic> toJson() => _$StoresToJson(this);

}
@JsonSerializable()

class StoreList
{
  int id;
  String name;
  StoreList(this.id,this.name);
  factory StoreList.fromJson(Map<String, dynamic> json) =>_$StoreListFromJson(json);
  Map<String, dynamic> toJson() => _$StoreListToJson(this);
}

@JsonSerializable()

class Clip
{
  String clip;
  Clips clips;

  Clip(this.clip, this.clips);
  factory Clip.fromJson(Map<String, dynamic> json) =>_$ClipFromJson(json);
  Map<String, dynamic> toJson() => _$ClipToJson(this);
}


@JsonSerializable()
class Clips {
  String full;

  Clips(this.full);

  factory Clips.fromJson(Map<String, dynamic> json) => _$ClipsFromJson(json);

  Map<String, dynamic> toJson() => _$ClipsToJson(this);
}

@JsonSerializable()

class Genres
{

  int id;
  String name;
  Genres(this.id,this.name);
  factory Genres.fromJson(Map<String, dynamic> json) =>_$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);

}

@JsonSerializable()
class GameRequirements
{
  String minimum;
  String recommended;
  GameRequirements(this.minimum,this.recommended);

  factory GameRequirements.fromJson(Map<String, dynamic> json) =>_$GameRequirementsFromJson(json);
  Map<String, dynamic> toJson() => _$GameRequirementsToJson(this);


}

@JsonSerializable()
class GameDevelopers {
  String name;

  int id;

  GameDevelopers(this.id, this.name);


  factory GameDevelopers.fromJson(Map<String, dynamic> json) =>
      _$GameDevelopersFromJson(json);

  Map<String, dynamic> toJson() => _$GameDevelopersToJson(this);

}
//"released": "2013-09-17",
//"tba": false,
//"background_image": "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg",
//"rating": 4.47,
//"rating_top": 5,
//"ratings": [{
//"id": 5,
//"title": "exceptional",
//"count": 1569,
//"percent": 58.0
//}, {
//"id": 4,
//"title": "recommended",
//"count": 928,
//"percent": 34.31
//}, {
//"id": 3,
//"title": "meh",
//"count": 168,
//"percent": 6.21
//}, {
//"id": 1,
//"title": "skip",
//"count": 40,
//"percent": 1.48
////}],
//"ratings_count": 2683,
//"stores": [{
//"store": {
//"id": 1,
//"name": "Steam",
//"slug": "steam"
//}
//}, {
//"store": {
//"id": 3,
//"name": "PlayStation Store",
//"slug": "playstation-store"
//}
//}, {
//"store": {
//"id": 2,
//"name": "Xbox Store",
//"slug": "xbox-store"
//}
//}, {
//"store": {
//"id": 7,
//"name": "Xbox 360 Store",
//"slug": "xbox360"
//}
//}],
//"clip": {
//"clip": "https://media.rawg.io/media/stories-640/5b0/5b0cfff8c606c5e4db4f74f108c4413b.mp4",
//"clips": {
//"320": "https://media.rawg.io/media/stories-320/91d/91d6b5963064a5f686f635c302095b55.mp4",
//"640": "https://media.rawg.io/media/stories-640/5b0/5b0cfff8c606c5e4db4f74f108c4413b.mp4",
//"full": "https://media.rawg.io/media/stories/f64/f64ce0b857918b0c202f2a5d3217848e.mp4"
//},
//"video": "dZubIhK-Z6w",
//"preview": "https://media.rawg.io/media/stories-previews/f65/f6593df6c8df32c7f4763f9cb112a514.jpg"
//},

//"short_screenshots": [{
//
//"genres": [{
//"id": 2,
//"name": "Shooter",
//"slug": "shooter"
//}, {
//"id": 4,
//"name": "Action",
//"slug": "action"
//}]
//}