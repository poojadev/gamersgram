
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';

class YoutubeArguments
{


List<Screenshots> screenShots;
String released;
double rating;
List<Stores> stores;
String clip;
List<Genres> genres;
List<Platforms> platforms;
int flag;
int gameId;
int tagId;
String description;
//String clips;
String website;
String externel_id;
String tagName;
String gameName;
String imgUrl;

    YoutubeArguments({this.gameName,this.gameId,this.externel_id,this.screenShots,this.tagId,
    this.released,this.stores,this.platforms,this.description,this.website,this.tagName,this.genres,this.rating,this.flag,this.imgUrl});
}