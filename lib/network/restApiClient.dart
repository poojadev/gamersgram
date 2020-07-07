
import 'dart:io';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/genres/model/GenresPOJO.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/tags/TagsPOJO.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:http/http.dart' as http;


import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
part 'restApiClient.g.dart';

var sd;
var eD;
@RestApi()
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String baseUrl}) = _RestApiClient;

  static String userAgent = "com.gamersgram/1";






  @GET(AppConstants.ShowPlatformList)
  Future<PlatformList> showPlatformList(@Header("User-agent") userAgent,@Path() int no);
  @GET(AppConstants.PlatformDetails)
  Future<PlatformDescription> showPlatformDetails(@Header("User-agent") userAgent,@Path()String id);
  @GET(AppConstants.PlatformWise_GameList_With_Filters)
  Future<GameList> showPlatformWiseGamesWithFilter(@Header("User-agent") userAgent,@Path() int no,@Path() int id);
  @GET(AppConstants.Platform_Search_List)
  Future<PlatformList> showSearchedPlatforms(@Header("User-agent") userAgent,@Path()String gameName);


  @GET(AppConstants.Search_Games)
  Future<GameList> showSearchedGames(@Header("User-agent") userAgent,@Path()String gameName);

  @GET(AppConstants.All_Games)
  Future<GameList> allGamesForSearch(@Header("User-agent") userAgent);
  @GET(AppConstants.Show_All_Games)
  Future<GameList> showListOfGames(@Header("User-agent") userAgent,
      @Path() int no, @Path() String ordering, @Path() int platformId);

  @GET(AppConstants.Games_Series)
  Future<GameList> showListOfGamesSeries(@Header("User-agent") userAgent,@Path() int no, @Path() int id);

  @GET(AppConstants.Games_Suggested)
  Future<GameList> showListOfGamesSuggested(@Header("User-agent") userAgent,@Path() int no, @Path() int id);

  @GET(AppConstants.Game_Release_Calender)
  Future<GameList> showMonthWiseGameRelease(@Header("User-agent") userAgent,@Path() String dates,
      @Path() int no);

  @GET(AppConstants.Games_Details)
  Future<GameListDetails> getGameDetails(@Header("User-agent") userAgent,@Path() int id);




  @GET(AppConstants.PlatformWise_GameList)
  Future<GameList> showPlatformWiseGameList(@Header("User-agent") userAgent,@Path() String id);
  @GET(AppConstants.Publishers)
  Future<GamePublisherPOJO> showPublisherList(@Header("User-agent") userAgent,@Path() int no);
  @GET(AppConstants.Publishers_Details)
  Future<GamePublisherDetails> showGamePublishersDetails(@Header("User-agent") userAgent,@Path() int id);
  @GET(AppConstants.List_Of_Games_By_Publisher)
  Future<GameList> showListOfGamesByPublishers(@Header("User-agent") userAgent,@Path() int no,@Path() int id);
  @GET(AppConstants.Publishers_Search_List)
  Future<GamePublisherPOJO> showSearchedPublisher(@Path()String publisherName);

  @GET(AppConstants.Genres)
  Future<GenresPOJO> showGenresList(@Header("User-agent") userAgent,@Path() int no,);
  @GET(AppConstants.Genres_Details)
  Future<GameGenresDetails> showGameGenresDetails(@Header("User-agent") userAgent,@Path() int id);
  @GET(AppConstants.List_Of_Games_By_Genres)
  Future<GameList> showListOfGamesByGenres(@Header("User-agent") userAgent,@Path() int no,@Path() int id);

  @GET(AppConstants.Genres_Search_List)
  Future<GenresPOJO> showSearchedGenres(@Header("User-agent") userAgent,@Path() String genresName);






  @GET(AppConstants.Game_Stores)
  Future<GameStores> shoeGameStores(@Header("User-agent") userAgent,@Path() int no);
  @GET(AppConstants.Game_Store_Details)
  Future<GameStoreDetails> showGameStoreDetails(@Header("User-agent") userAgent,@Path() int id);
  @GET(AppConstants.List_Of_Games_By_Stores)
  Future<GameList> showListOfGamesByStores(@Header("User-agent") userAgent,@Path() int no,@Path() int id);

  @GET(AppConstants.Store_Search_List)
  Future<GameStores> showSearchedStore(@Header("User-agent") userAgent,@Path() String storeName);




  @GET(AppConstants.Game_Creators)
  Future<GameCreatorsPOJO> showGameCreators(@Header("User-agent") userAgent,@Path() int no);
  @GET(AppConstants.Game_Creators_Details)
  Future<GamesCreatorsDetails> showGameCreatorsDetails(@Header("User-agent") userAgent,@Path() int id); //change
  @GET(AppConstants.List_Of_Games_By_Creators)
  Future<GameList> showListOfGamesByCreators(@Header("User-agent") userAgent,@Path() int id, @Path() no);

  @GET(AppConstants.Creator_Search_List)
  Future<GameCreatorsPOJO> showSearchedCreator(@Header("User-agent") userAgent,@Path() String creatorsName);





  @GET(AppConstants.Game_Tags)
  Future<GameTagsPOJO> showGameTags(@Header("User-agent") userAgent,@Path() int no);
  @GET(AppConstants.TagWise_GameList)
  Future<GameList> showListOfGamesByTags(@Header("User-agent") userAgent,@Path() int no,@Path() int id);
  @GET(AppConstants.Tag_Search)
  Future<GameTagsPOJO> showSearchedTags(@Header("User-agent") userAgent,@Path()String tagName);


  @GET(AppConstants.Weekly_Games)
  Future<GameList> showWeeklyRelease(@Header("User-agent") userAgent,@Path() String start);

}
