import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/ui/CreatorHomePage.dart';
import 'package:gamersgram/creators/ui/CreatorsWidget.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/genres/model/GenresPOJO.dart';
import 'package:gamersgram/genres/ui/GenerWidget.dart';
import 'package:gamersgram/genres/ui/GenresHomePage.dart';
import 'package:gamersgram/navigtion/About.dart';
import 'package:gamersgram/navigtion/suggestions.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/platforms/ui/PlatformHomePage.dart';
import 'package:gamersgram/platforms/ui/PlatformListWidget.dart';
import 'package:gamersgram/publishers/detail/PublisherDetails.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:gamersgram/publishers/ui/GamePublisherHomePage.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/publishers/ui/PublisherWidget.dart';
import 'package:gamersgram/stores/ui/StoreWidget.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/stores/ui/StoresHomePage.dart';
import 'package:gamersgram/tags/TagsPOJO.dart';
import 'package:gamersgram/tags/ui/AllTagsHomePage.dart';
import 'package:gamersgram/tags/ui/TagListWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';

import 'package:gamersgram/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:gamersgram/util/ui/ConnectionStatusSingleton.dart';
import 'package:gamersgram/util/ui/NoBackButton.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:store_redirect/store_redirect.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
SizeConfig sizeConfig = new SizeConfig();

class Homepage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      debugShowCheckedModeBanner: false,
//
//       home: HomepageState(),
    body: HomepageState(),
    );
  }
}

class HomepageState extends StatefulWidget {
  HomepageState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  HomepageStateState createState() => HomepageStateState();
}

class HomepageStateState extends State<HomepageState> {

  GamePublisherPOJO publisherList;
  GenresPOJO genresList;
  PlatformList platformList;
  GameList allGameList;
 GameList popularGameList;
  GameStores storeList;
  var currentSelectedValue;
  StreamSubscription _connectionChangeStream;


  GameCreatorsPOJO creatorsList;
  GameTagsPOJO tagList;
  //var startDate;
//  var endDate;
  int pageCount = 1;
  Future<void> _initializeVideoPlayerFuture;
 // StreamSubscription subscription;
//  List<String> filterStringList = new List();


  static String startDate = AppConstants.changeDateFormat(
      DateTime.now().subtract(Duration(days: 7)).toString(), ("yyyy-MM-dd"));
  static String endDate =
  AppConstants.changeDateFormat(DateTime.now().toString(), ("yyyy-MM-dd"));

  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton
        .getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    //  _controller.dispose();

    super.dispose();
    _connectionChangeStream.cancel();
  }
  bool isOffline = false;

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

//  void connectionChanged(dynamic hasConnection) async*{
////    setState(() {
////      isOffline = !hasConnection;
//
//      var connectivityResult = await (Connectivity().checkConnectivity());
//      if (connectivityResult == ConnectivityResult.mobile) {
//        print("Connected to Mobile Network");
//      } else if (connectivityResult == ConnectivityResult.wifi) {
//        print("Connected to WiFi");
//      } else {
//        print("Unable to connect. Please Check Internet Connection");
//      }
//  //  });
//  }

  /*
         pagination footer this will show page numbers
         logic : get total count of the result ,then
    */

  //var now=DateTime.now();
//
//    DateTime dateTime=AppConstants.changeDateFormat( DateTime.now().add(Duration(days: 7)).toString(),("yyyy-MM-dd"));
//  var one = 2019 - 12 - 01;
//  var two = 2019 - 12 - 07;

//    restApiClient
//        .shoeGameStores().then((GameStores responses) {
//      storeList = responses;
//      print("PPOJa" +storeList.results.length.toString());
//    });
//DateTime dd=DateTime.now();
//print("start date"
//    +AppConstants.changeDateFormat(now);
  static DateTime date = DateTime.now();
  var result = "${date.year}-${date.month}-${date.day}";

  // DateTime dd=  DateTime.parse(result);


  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(
          'No internet',
          "You're not connected to a network"
      );
    } else if (result == ConnectivityResult.mobile) {
      _showDialog(
          'Internet access',
          "You're connected over mobile data"
      );
    } else if (result == ConnectivityResult.wifi) {
      _showDialog(
          'Internet access',
          "You're connected over wifi"
      );
    }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
//  Future<GameList> getWeeklyRelease() async {
//    var _client = new HttpClient();
//    _client.badCertificateCallback =
//        (X509Certificate cert, String host, int port) => true;
//    //  print(two);
//    print(startDate);
//    print(endDate);
//    String url = 'https://api.rawg.io/api/games?dates=' + endDate + "," +
//        startDate;
//    final response =
//    await http.get(url, headers: {
//      "Accept": "application/json",
//      "User-agent": "techigirl.gamers_gamersgramt/1"
//    },);
//    if (response.statusCode == 200) {
//      // print(System.getProperty("http.agent"));
//      print("Using hearde tme");
//      popularGameList = GameList.fromJson(json.decode(response.body));
//      print("OOO" + allGameList.results[0].name);
//      return popularGameList;
//    } else {
//      throw Exception('Failed to load post');
//    }
//  }


//
//  Future<GameList> popularGamesInTheYear() async {
//    //  print(two);
//    print(now);
//    print(now1);
////    String url = 'https://api.rawg.io/api/games?dates='+ now1 + "," + now ;
//    String popularGames="https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-addedd&page=1";
//    final response =
//    await http.get(popularGames, headers: {"Accept": "application/json"});
//    if (response.statusCode == 200) {
//      popularGameList=GameList.fromJson(json.decode(response.body));
//      print("OOO"+popularGameList.results[0].name);
//      return popularGameList;
//
//    } else {
//      throw Exception('Failed to load post');
//    }
//  }

  Widget popularGamesOfTheYearWidget(BuildContext context) {
    return
      //User input pauses carousels automatic playback

      CarouselSlider(
        viewportFraction: 1.0,
        height: SizeConfig.heightMultiplier * 45,
        aspectRatio: MediaQuery
            .of(context)
            .size
            .aspectRatio,
        autoPlay: true,
        enlargeCenterPage: true,
        pauseAutoPlayOnTouch: Duration(seconds: 3),
        items: popularGameList.results.map(
              (index) {
            return Column(
              children: <Widget>[
                Expanded(
                    child:GestureDetector(
                      onTap: ()
                        {

                        },
                    child: Stack(
                      alignment: Alignment.bottomCenter,

                      children: <Widget>[
                        Container(

                          child: GestureDetector(
                            onTap: ()
            {



              print(index.stores);
              print(index.id);
              print(index.genres);
              YoutubeArguments  sliderArguments = new YoutubeArguments(
                gameName:index.name!=null? index.name:AppConstants.noInfo
                ,gameId: index.id!=null?index.id:AppConstants.noInfo,

                screenShots: index.short_screenshots!=null?
                index.short_screenshots:AppConstants.noInfo,
                released: index.released!=null? index.released:AppConstants.noInfo,

                stores: index.stores!="Null"?index.stores:AppConstants.noInfo,
                // clip:index.clip.clip!=null?index.clip.clip:AppConstants.noInfo,
                description: index.description!=null? index.description:AppConstants.noInfo,
                genres: index.genres!=null?index.genres:AppConstants.noInfo,
                platforms: index.platforms!=null?index.platforms:AppConstants.noInfo,
                rating: index.rating!=null? index.rating:AppConstants.noInfo,
                website: index.website!=null?index.website:AppConstants.noInfo,

              );
              Navigator.pushNamed(context, GameDetails.routeName,arguments: sliderArguments);

            },

                            child: index
                                .background_image != null ? CachedNetworkImage(
                              imageUrl:
                              index
                                  .background_image,
                              imageBuilder: (context,
                                  imageProvider) =>
                                  Container(

                                    decoration:
                                    BoxDecoration(
                                      image:
                                      DecorationImage(
                                        image:
                                        imageProvider,
                                        fit: BoxFit.cover,
                                        //  colorFilter:
                                        //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                      ),
                                    ),
                                  ),
                              placeholder: (context,
                                  url) =>

                              Container(
                                  height: SizeConfig.heightMultiplier*20,
                                  child:
                                  Center(
                                      child: FlareActor('assets/loader.flr',
                                        //  animation:
//              "circle"

                                      ))),
                              errorWidget: (context,
                                  url, error) =>
                                  Icon(Icons.error),
                            ) : Text("No Image found"),
                          ),
                        ),

                        Row(
                          children: <Widget>[
//          Card(
//            elevation: 11,
//            //color: Color.fromRGBO(32, 32, 34, 40),
//            color: Color.fromRGBO(32, 32, 34, 40),

                            // child:

                            Expanded(
                              flex: 1,
                              child:
//
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 18),
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(32, 32, 34, 30),
                                    borderRadius: new BorderRadius.only(
                                        topRight: const Radius.circular(40.0),
                                        topLeft: const Radius.circular(40.0))),
                                height: SizeConfig.heightMultiplier * 8,
                                //  color: Color.fromRGBO(32, 32, 34, 40),
                                child: Text(
                                  index.name,
                                  style: AppTheme.subTitleLights,
                                  textScaleFactor: 1.2,

                                ),
                              ),
                            ),

                            //  )
                            // )

                            // )
                          ],
                        )
                      ],))),


              ],
            );
          },
        ).toList(),
      );
  }


  Widget weeklyReleaseGamesWidget() {
    print(SizeConfig.heightMultiplier * 24);
    return Align(
        alignment: Alignment.topCenter,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: new Container(
                height: SizeConfig.heightMultiplier * 24,
                //   width: SizeConfig.widthMultiplier*6,
                child: ListView.builder(
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  // physics: const NeverScrollableScrollPhysics(),

                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: allGameList == null ? 0 : allGameList.results
                      .length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                        onTap: () {
                          /*
                              Switching and  passing data to TvShowDetailsPage

                            */


                          YoutubeArguments allGamesArguments = new YoutubeArguments(
                            gameName:allGameList.results[index].name!=null? allGameList.results[index].name:AppConstants.noInfo
                            ,gameId: allGameList.results[index].id!=null?allGameList.results[index].id:AppConstants.noInfo,

                            screenShots: allGameList.results[index].short_screenshots!=null?
                            allGameList.results[index].short_screenshots:AppConstants.noInfo,
                            //clip:allGameList.results[index].clip.clip!=null?allGameList.results[index].clip.clip:AppConstants.noInfo,
                            description: allGameList.results[index].description!=null? allGameList.results[index].description:AppConstants.noInfo,
                            genres: allGameList.results[index].genres!=null? allGameList.results[index].genres:AppConstants.noInfo,
                            platforms: allGameList.results[index].platforms!=null?allGameList.results[index].platforms:AppConstants.noInfo,
                            rating: allGameList.results[index].rating!=null? allGameList.results[index].rating:AppConstants.noInfo,
                            website: allGameList.results[index].website!=null?allGameList.results[index].website:AppConstants.noInfo,
                            released: allGameList.results[index].released!=null? allGameList.results[index].released:AppConstants.noInfo,
                          //  stores: allGameList.results[index].stores!=null?allGameList.results[index].stores:AppConstants.noInfo,
                            stores:  allGameList.results[index].stores!="Null"? allGameList.results[index].stores:AppConstants.noInfo,

                          );
                          Navigator.pushNamed(context, GameDetails.routeName,arguments: allGamesArguments);

//                          allGameList.results[index].clip == null
//                              ? Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) =>
//                           bbbb       GameDetailsStates(
//                                    gameId: allGameList.results[index].id,
//                                    screenShots: allGameList
//                                        .results[index].short_screenshots,
//                                    gameName:
//                                    allGameList.results[index].name,
//                                    released:
//                                    allGameList.results[index].released,
//                                    rating:
//                                    allGameList.results[index].rating,
//                                    stores:
//                                    allGameList.results[index].stores,
//                                    clip: "no",
//                                    genres:
//                                    allGameList.results[index].genres,
//                                    platforms:
//                                    allGameList.results[index].platforms,
//                                    flag: 1,
//                                  )))
//                              : Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) =>
//                                  GameDetailsStates(
//                                    gameId: allGameList.results[index].id,
//
//                                    screenShots: allGameList
//                                        .results[index].short_screenshots,
//                                    gameName:
//                                    allGameList.results[index].name,
//                                    released:
//                                    allGameList.results[index].released,
//                                    rating:
//                                    allGameList.results[index].rating,
//                                    stores:
//                                    allGameList.results[index].stores,
//                                    clip:
//                                    allGameList.results[index].clip.clip,
//                                    genres:
//                                    allGameList.results[index].genres,
//                                    platforms:
//                                    allGameList.results[index].platforms,
//                                    flag: 1,
//                                  )));
                        },
                        child: AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: allGameList.results.length,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
//                                    child: Stack(children: <Widget>[
//                                      Container(
//
//
////                              height: animation.value,
////                              width: animation.value,
//
//                                          padding: EdgeInsets.only(
//                                              right: 5.0, top: 0.5),
//                                          child: Card(
//                                              shape: RoundedRectangleBorder(
//
//                                                  borderRadius:
//                                                  BorderRadius.circular(3)),
//                                              semanticContainer: true,
//                                              color: Color.fromRGBO(
//                                                  32, 32, 32, 5),
//                                              elevation: 10.0,
//                                              child: Container(
//                                                decoration: BoxDecoration(
//                                                    border: Border.all(
//                                                        color: Colors
//                                                            .white30)),
//                                                height: SizeConfig
//                                                    .heightMultiplier * 15,
//                                                width: SizeConfig
//                                                    .widthMultiplier * 33,
//                                                child:
//

                                  child: Container(

                                      padding: EdgeInsets.only(
                                          left: 1 * SizeConfig.heightMultiplier,
                                          right: 1 *
                                              SizeConfig.heightMultiplier,
                                          bottom: 1 *
                                              SizeConfig.heightMultiplier),
                                      child: Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          allGameList.results[index]
                                              .background_image !=
                                              null
                                              ? Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                            height: SizeConfig
                                                .heightMultiplier *
                                                17,
                                            width: SizeConfig
                                                .widthMultiplier *
                                                34,

                                            child:


                                            CachedNetworkImage(
                                              imageUrl: allGameList
                                                  .results[index]
                                                  .background_image,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit
                                                            .cover,
                                                        //  colorFilter:
                                                        //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  Container(

                                                      alignment: Alignment
                                                          .center,
                                                      child:

                                                      FlareActor(
                                                          'assets/loader.flr',
                                                          alignment: Alignment
                                                              .center,
                                                          fit: BoxFit
                                                              .contain,
                                                          animation: "loader"


                                                      )),
                                              errorWidget: (context,
                                                  url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          )
                                              : Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                            height: SizeConfig
                                                .imageSizeMultiplier *
                                                17,
                                            width: SizeConfig
                                                .widthMultiplier *
                                                34,
                                            child: Center(child: Text(
                                              "No Image avaliable",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 0.9,)),
                                          ),
//                                              Expanded(
//                                                  flex: 1,
//                                                  child:

                                          Expanded(
                                            child:
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .white30)),
                                              height: SizeConfig
                                                  .heightMultiplier *
                                                  7.8,
                                              width: SizeConfig
                                                  .widthMultiplier *
                                                  34,
                                              padding: EdgeInsets.only(left: 1 *
                                                  SizeConfig.heightMultiplier,
                                                  top: 2),
                                              child: Text(
                                                allGameList.results[index].name,
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.2,

                                                //  textAlign: TextAlign.center,
                                              ),
                                            ),),
                                          //),
                                        ],
                                      )),
//                                              ))
//
//                                      )
//                                    ])

                                ))));
                  },
                ))));
  }


  Widget footerWidget() {
    print("INSIDE Footer");
    //   print("wee" +pages.length.toString());

//      return FractionallySizedBox(
//          widthFactor: 1,
    //child:Container(
    //   padding: EdgeInsets.only(left: 20,right: 20),
//              decoration: new BoxDecoration(
//                  color: Color.fromRGBO(32, 32, 34, 40),
//                  borderRadius: new BorderRadius.only(
//                      topLeft: const Radius.circular(40.0),
//                      topRight: const Radius.circular(40.0))),
    //  child:

    return Card(
      elevation: 11,
      //color: Color.fromRGBO(32, 32, 34, 40),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      // height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(left: 18,right: 18),
              color: Color.fromRGBO(32, 32, 34, 40),
              child: IconButton(
                  icon: new Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {}),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              color: Color.fromRGBO(32, 32, 34, 40),
              child: IconButton(
                  icon: new Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {}),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 34, 40),
                // border: Border.all(color: Colors.black),
              ),
              child: IconButton(
                  icon: new Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {}),
            ),
          ),
        ],
      ),

      //  )
      // )
    );
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Widget headerWidget() {
    // print("INSIDE Footer");
    //   print("wee" +pages.length.toString());

    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: new BoxDecoration(
                color: Color.fromRGBO(32, 32, 34, 30),
                borderRadius: new BorderRadius.only(
                    bottomRight: const Radius.circular(40.0),
                    bottomLeft: const Radius.circular(40.0))),
            child: Row(
              children: <Widget>[
//          Card(
//            elevation: 11,
//            //color: Color.fromRGBO(32, 32, 34, 40),
//            color: Color.fromRGBO(32, 32, 34, 40),

                // child:

                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: SizeConfig.heightMultiplier * 7,
                    padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                    //  color: Color.fromRGBO(32, 32, 34, 40),
                    child: Text(
                      "Weekly Release",
                      style: AppTheme.subTitleLights,
                      textScaleFactor: 1.2,

                    ),
                  ),
                ),

                //  )
                // )

                // )
              ],
            )));
  }

  var _SelectdType = "Order By";




  Future<bool> _onWillPop() async {
    if (_key.currentState.isDrawerOpen) {
      Navigator.of(context).pop();
      return false;
    }
    return (


        await

    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.black87,
        title: Text('Are you sure?',style: AppTheme.textGridTitle,),
        content: Text('You are going to exit the application!!',style: AppTheme.mainTitles,),
        actions: <Widget>[
      FlatButton(
      child: Text('NO',style: AppTheme.descText,),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    ),
        FlatButton(
        child: Text('YES',style:AppTheme.descText,),
    onPressed: () {
    Navigator.of(context).pop(true);
    })
        ],
      ),
    )) ;
  }
//    Future<bool> onBackPressed() {
//      return showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              backgroundColor: Colors.black87,
//              title: Text('Are you sure?',style: AppTheme.textGridTitle,),
//              content: Text('You are going to exit the application!!',style: AppTheme.mainTitles,),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('NO',style: AppTheme.descText,),
//                  onPressed: () {
//                    Navigator.of(context).pop(false);
//                  },
//                ),
//                FlatButton(
//                  child: Text('YES',style:AppTheme.descText,),
//                  onPressed: () {
//                    Navigator.of(context).pop(true);
//                  },
//                ),
//              ],
//            );
//          });
//    }
  String weeklyDate = startDate + "," + endDate;

  // (isOffline)? new Text("Not connected") :


  //bool isOpen = false;





  Widget sideNav() {
    return
      Container(
          width: SizeConfig.widthMultiplier * 60,
          color: Colors.black54,

          child:
          Drawer(
              child: Stack(
                  children: <Widget>[
                    //first child be the blur background
//          BackdropFilter(
//          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), //this is dependent ,on the import statment above
//          child: Container(
//              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5))
//          )
//      ),

//
//                    Container(
////      height: SizeConfig
////          .heightMultiplier *
////        10,
////
////        decoration:
////        BoxDecoration(
////            border: Border.all(color:Colors.white30,width: 2),
////            shape: BoxShape.circle,),
//
//
//                        child: Image.asset("assets/images/gz.png",
//                          height: SizeConfig.heightMultiplier * 15,
//      )),
                    ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          DrawerHeader(
                              child: Column(children: <Widget>[

                                Container(
//      height: SizeConfig
//          .heightMultiplier *
//        10,
//
//        decoration:
//        BoxDecoration(
//            border: Border.all(color:Colors.white30,width: 2),
//            shape: BoxShape.circle,),


                                    child: Image.asset("assets/gz.png",
                                      height: SizeConfig.heightMultiplier * 12,
                                    )),


                                Text(
                                  "Gamers Gram",
                                  style: AppTheme.descText,
                                  textScaleFactor: 1.3,
                                  softWrap: true,

                                ),

                                SizedBox(height: 5,),


                                Divider(height: 2,color: Colors.white12,thickness: 2,),
                              ],)
                          ),


                          ListTile(
                            //    leading: Icon(Icons.info, color: Colors.white),
                              title: Text(
                                "About",
                                style: AppTheme.descText,
                                textScaleFactor: 1.2,
                                softWrap: true,

                              ),

                              onTap: () {
                                // Then close the drawer.
                                Navigator.of(context, rootNavigator: true).pop(context);

                                Navigator.pushNamed(context, About.routeName);
                              //  Navigator.pushReplacementNamed(context, About.routeName);

                              }
                          ),
                          ListTile(
                            //   leading: Icon(Icons.message, color: Colors.white),
                              title: Text(
                                "Suggestions",
                                style: AppTheme.descText,
                                textScaleFactor: 1.2,
                                softWrap: true,

                              ),

                              onTap: () {
                                // Then close the drawer.
                                Navigator.of(context, rootNavigator: true).pop(context);

                               // Navigator.push(context, Suggestions.routeName);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Homepage(),
                                    ),
                                    ModalRoute.withName(Suggestions.routeName));
                                //  Navigator.pushReplacementNamed(context, Suggestions.routeName);

                              }
                          ),
//                          ExpansionTile(
//                              initiallyExpanded: true,
//                              //   leading: Icon(Icons.history, color: Colors.white),
//
//                              title: AutoSizeText(
//                                "Tournaments",
//                                style: AppTheme.descText,
//                                textScaleFactor: 1.3,
//                                softWrap: true,
//
//                              ),
//                              children: <Widget>[
//
//                                Container(padding: EdgeInsets.all(7),
//                                  child: GestureDetector(
//                                    onTap: () {
////                                      Navigator.push(context,
////                                          PageTransition(type:
////                                          PageTransitionType.leftToRight,
////                                              child: GamingRunningTournaments(
////                                              )));
//                                    },
//
//                                    child: AutoSizeText(
//                                      "Running",
//                                      style: AppTheme.descText,
//                                      textScaleFactor: 1.2,
//                                      softWrap: true,
//
//                                    ),
//                                  ),
//
//                                ),
//
//                                Container(padding: EdgeInsets.all(7),
//                                  child: GestureDetector(
//                                    onTap: () {
////                                      Navigator.push(context,
////                                          PageTransition(type:
////                                          PageTransitionType.leftToRight,
////                                              child: GamingUpComingTournaments(
////                                              )));
//                                    },
//
//                                    child: AutoSizeText(
//                                      "Upcoming",
//                                      style: AppTheme.descText,
//                                      textScaleFactor: 1.2,
//                                      softWrap: true,
//
//                                    ),
//                                  ),
//
//                                ),
//
//
//                              ])
                        ]),


                  ]
//      )
//      ]
              )
          ));
  }


//    Widget gameClips() {
//      return Align(
//          alignment: Alignment.topCenter,
//          child: Directionality(
//              textDirection: TextDirection.ltr,
//              child: new Container(
//                  height: 200.0,
//                  child: ListView.builder(
//                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                    // physics: const NeverScrollableScrollPhysics(),
//
//                    scrollDirection: Axis.horizontal,
//                    shrinkWrap: true,
//                    itemCount: gameList == null ? 0 : gameList.results.length,
//                    itemBuilder: (context, index) {
//                      print(gameList.results[index].clip != null
//                          ? gameList.results[index].clip.clip
//                          : "not ok");
//                      gameList.results[index].clip != null
//                          ? _controller = VideoPlayerController.network(
//                          gameList.results[index].clip.clip)
//                          : _controller = VideoPlayerController.network(
//                          "https://media.rawg.io/media/stories-640/1ad/1adba4d856c0db20117f927fadbcf185.mp4");
//                      _initializeVideoPlayerFuture = _controller.initialize();
//                      _controller.setLooping(true);
//                      return AnimationConfiguration.staggeredGrid(
//                          position: index,
//                          duration: const Duration(milliseconds: 375),
//                          columnCount: gameList.results.length,
//                          child: ScaleAnimation(
//                              child: FadeInAnimation(
//                                  child: Container(
//                                      height: 200,
//                                      width: 170,
////                              height: animation.value,
////                              width: animation.value,
//
//                                      padding: EdgeInsets.only(
//                                          left: 5.0, right: 5.0, top: 0.5),
//                                      child: Card(
//                                          shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(3)),
//                                          semanticContainer: true,
//                                          color: Color.fromRGBO(32, 32, 32, 5),
//                                          elevation: 10.0,
//                                          child: Container(
//                                            child: Column(
//                                              children: <Widget>[
//                                                FutureBuilder(
//                                                  future:
//                                                  _initializeVideoPlayerFuture,
//                                                  builder: (context, snapshot) {
//                                                    if (snapshot
//                                                        .connectionState ==
//                                                        ConnectionState.done) {
//                                                      // If the VideoPlayerController has finished initialization, use
//                                                      // the data it provides to limit the aspect ratio of the video.
//
//                                                      return AspectRatio(
//                                                        aspectRatio: _controller
//                                                            .value.aspectRatio,
//                                                        // Use the VideoPlayer widget to display the video.
//
//                                                        child: VideoPlayer(
//                                                            _controller),
//                                                      );
//                                                    } else {
//                                                      // If the VideoPlayerController is still initializing, show a
//                                                      // loading spinner.
//                                                      return Center(
//                                                          child:
//                                                          FlareActor(
//                                                              'assets/loader.flr',
//                                                              alignment: Alignment
//                                                                  .center,
//                                                              fit: BoxFit
//                                                                  .contain,
//                                                              animation: "loader"
//
//
//                                                          ));
//                                                    }
//                                                  },
//                                                ),
//                                                SizedBox(
//                                                  height: 20.0,
//                                                ),
//                                                Text(
//                                                  gameList.results[index].name,
//                                                  style: TextStyle(
//                                                      fontSize: 18,
//                                                      color: Colors.white),
//                                                ),
//                                                SizedBox(
//                                                  height: 20.0,
//                                                ),
//                                                Stack(
//                                                  children: <Widget>[
//                                                    Container(
//                                                        alignment: Alignment
//                                                            .bottomCenter,
//                                                        child: ButtonTheme(
//                                                            child: RaisedButton(
//                                                              padding:
//                                                              EdgeInsets.all(
//                                                                  10.0),
//                                                              color: Colors
//                                                                  .transparent,
//                                                              textColor:
//                                                              Colors.white,
//                                                              onPressed: () {
//                                                                // Wrap the play or pause in a call to `setState`. This ensures the
//                                                                // correct icon is shown.
//                                                                setState(() {
//                                                                  // If the video is playing, pause it.
//                                                                  if (_controller
//                                                                      .value
//                                                                      .isPlaying) {
//                                                                    _controller
//                                                                        .pause();
//                                                                  } else {
//                                                                    // If the video is paused, play it.
//                                                                    _controller
//                                                                        .play();
//                                                                  }
//                                                                });
//                                                              },
//                                                              child: Icon(
//                                                                _controller
//                                                                    .value
//                                                                    .isPlaying
//                                                                    ? Icons
//                                                                    .pause
//                                                                    : Icons
//                                                                    .play_arrow,
//                                                                size: 30.0,
//                                                              ),
//                                                            )))
//                                                  ],
//                                                )
//                                              ],
//                                            ),
//                                          ))))));
//                    },
//                  ))));
//    }

  // Color textColor =Colors.computeLuminance() > 0.5 ? Colors.black : Colors.white;

   String publisherRoute = 'PublisherHomePage';

  @override
  Widget build(BuildContext context) {
    // Internet Present Case
    /*
    weekly release games
     */

    /*
         pagination footer this will show page numbers
         logic : get total count of the result ,then
    */


    /*
         pagination footer this will show page numbers
         logic : get total count of the result ,then
    */
    List<GamePublisherResult>passArgu=new List();


    return





      (isOffline) ? new Container(
        height: SizeConfig.heightMultiplier * 100,
width: SizeConfig.widthMultiplier*100,
          color:Colors.black26,
          child:Container(
              height: SizeConfig.heightMultiplier * 30,
        alignment: Alignment
            .center,
        child:

        FlareActor(
            'assets/nointernet.flr',
            alignment: Alignment
                .center,
            fit: BoxFit
                .contain,
            animation: "nointernet"


        )) ):

    // print("Connected to Mobile Network");

    new LayoutBuilder(builder: (context, constraints) {
      print("connected");
      return OrientationBuilder(


        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return
//            MaterialApp(
//
////                routes:<String,WidgetBuilder> {
////
////                  //PublisherHomePage.routeName: (context) => PublisherHomePage(),
////                  publisherRoute: (context) =>  PublisherHomePage(
////                    //    publisherId:  args.publisherId,
////                    // publisherName:  args.publisherName,
////
////
////
////                  ),
////
////                },
//
////
//                onGenerateRoute: Router.generateRoute,
//                routes: <String, WidgetBuilder>{
//                  //  '/PublisherHomePage': (BuildContext context) => new PublisherHomePage( ),
//
//                  '/PublisherHomePage': (BuildContext context) => new PublisherHomePage( ),
//                },
//
//                home:

            new WillPopScope(
              onWillPop:_onWillPop,
              child:

                Scaffold(
                  key: _key,

                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                    elevation: 0.0,
                    title: const Text('Gamers Gram', softWrap: true,
       style:   TextStyle(color: Colors.white),textScaleFactor: 1.0,
                    ),
                    actions: <Widget>[
                      // action button
                      IconButton(
                        icon: Icon(Icons.share,color: Colors.white,),
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: "com.gamersgram",
                              //iOSAppId: "585027354"

                          );
                        },
                      ),
                      // action button


                    ],
                  ),


                  drawer: Theme(
                      data: Theme.of(context).copyWith(
                        // Set the transparency here
                        canvasColor: Colors.black.withOpacity(
                            0.5), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
                      ),
                      child: sideNav()),


                  //this will just add the Navigation Drawer Icon
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  //    bottomNavigationBar: footerWidget(),

                  body:

                  CustomScrollView(
                    slivers: <Widget>[
//                    SliverAppBar(
//                      pinned: true,
//                      expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//                    ),


                      SliverList(
                        delegate: SliverChildListDelegate([

                          Column(
                            children: <Widget>[

//
//                            Container(
//                                alignment: Alignment.topLeft,
//                                padding: EdgeInsets.only(top: 20),
//
//                                child:
//                                Text("Weekly Release", softWrap: true,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
////                            Expanded(
////                              flex: 1,
////                                child:
//                            FutureBuilder(
////
//                                future:  getWeeklyRelease()
//                                ,
//
//                                builder: (BuildContext context, AsyncSnapshot snapshot) {
//                                  if (snapshot.hasData == null) {
//                                    return Container(
//                                        child: CircularProgressIndicator(
//                                            valueColor: AlwaysStoppedAnimation<Color>(
//                                                Colors.green)));
//                                  }
//                                  return ();
//                                }),


                              Stack(children: <Widget>[


                                FutureBuilder(
//
                                    future: restApiClient
                                        .showWeeklyRelease("com.gamersgram/1",weeklyDate)
                                        .then((GameList responses) {
                                      popularGameList = responses;
                                      print(popularGameList.results[0]
                                          .background_image);
                                    }),

                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (popularGameList == null) {
                                        return Container(
                                            height: SizeConfig
                                                .heightMultiplier * 20,
                                            child: Center(child:FlareActor(
                                                'assets/loader.flr',
                                                alignment: Alignment.center,
                                                fit: BoxFit.contain,
                                                animation: "loader"


                                            )));
                                      }
                                      return popularGameList == null
                                          ? Container()
                                          : popularGamesOfTheYearWidget(
                                          context);
                                    }),

                                headerWidget(),


                              ],),


                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),

                              /*
                            weekly release games
                             */


                              Container(
                                width: SizeConfig.widthMultiplier*98,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));
//                                            Navigator.push(
//                                                context,
//                                                MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        Dashboard()));

                                            Navigator.pushNamed(context,
                                                 GameNewsDashboard.routeName);
                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "All Games",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  textScaleFactor: 1.3,
                                                  style: AppTheme
                                                      .subTitleLights,

                                                ))


                                          ],)))),
//                            Expanded(
//                              flex: 1,
//                                child:
                              FutureBuilder(
//
                                  future: restApiClient
                                      .showListOfGames(
                                      "com.gamersgram/1", 1, "-added",
                                      4)
                                      .then((GameList responses) {
                                    allGameList = responses;
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return weeklyReleaseGamesWidget();
                                  }),


                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),

/*
  Publishers widget
 */

                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => PublisherHomePage() ));
                                          Navigator.pushNamed(context, PublisherHomePage.routeName);


                                         //   Navigator.push(context, PublisherHomePage());
                                           // Navigator.pushNamed(context, publisherRoute, arguments: 'Data from home');


//                                            Navigator.pushReplacement(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: PublisherHomePage()));
                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Publishers",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,


                                                ))


                                          ],)))),

                              FutureBuilder(
                                  future: restApiClient
                                      .showPublisherList("com.gamersgram/1",1)
                                      .then((GamePublisherPOJO responses) {
                                    publisherList = responses;
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return publisherGalleryWidget(
                                        publisherList);
                                  }),
                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),

                              //Divider(color: Colors.red,thickness: 1,),

                              /*
             Genres widget
             */


                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));
                                            Navigator.pushNamed(context, GenresHomePage.routeName);

                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Genres",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,

                                                ))


                                          ],)))),
//                            Expanded(
//                              flex: 1,
//                                child:
                              FutureBuilder(
                                  future: restApiClient
                                      .showGenresList("com.gamersgram/1",1)
                                      .then((GenresPOJO responses) {
                                    genresList = responses;
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return genresGalleryWidget(genresList);
                                  }),
                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),

/*
Platform widget
 */

//                            RaisedButton(onPressed: (){
//                              Navigator.push(context,
//                                  MaterialPageRoute(
//                                      builder: (context) => GamePublisherList()));
//                            },child: Text("ok"),),

//                            Builder(
//                              builder: (context) => RaisedButton(
//                                onPressed: () {
//                                  Navigator.push(context,
//                                      MaterialPageRoute(
//                                          builder: (context) => GamePublisherList()));
//                                },
//                                child: Text('Registrese'),
//                              ),
//                            ),
//
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));
                                        //  Navigator.pushNamed(context, "/platformhomepage");

                                            Navigator.pushNamed(context, PlatformHomePage.routeName);

//                                          Navigator.push(context,
//                                              PageTransition(type:
//                                              PageTransitionType.leftToRight,
//                                                  child: CreatorDetailsState(
//                                                      id: creatorsList.results[index].id,
//                                                      creatorImageUrl: creatorsList
//                                                          .results[index].image,
//                                                      creatorName: creatorsList.results[index]
//                                                          .name
//                                                  ) ));



//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: PlatformHomePage()));
                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Platforms",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,


                                                ))


                                          ],)))),
//                            Expanded(
//                              flex: 1,
//                                child:
                              FutureBuilder(
                                  future: restApiClient
                                      .showPlatformList("com.gamersgram/1",pageCount)
                                      .then((PlatformList responses) {
                                    platformList = responses;
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return platformListWidget(platformList);
                                  }),

                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),


                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));

                                            Navigator.pushNamed(context, StoresHomePage.routeName);

                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Stores",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,


                                                ))


                                          ],)))),
//                            Expanded(
//                              flex: 1,
//                                child:
                              FutureBuilder(
                                  future: restApiClient
                                      .shoeGameStores("com.gamersgram/1",pageCount)
                                      .then((GameStores responses) {
                                    storeList = responses;
                                    print("Response n class" +
                                        storeList.results[0].domain);
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return gamesStoreWidget(storeList);
                                  }),

                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),


                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));
                                            Navigator.pushNamed(context, AllTagsHomePage.routeName);

                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Tags",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,


                                                ))


                                          ],)))),
                              FutureBuilder(
                                  future: restApiClient
                                      .showGameTags("com.gamersgram/1",pageCount)
                                      .then((GameTagsPOJO responses) {
                                    tagList = responses;
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return tagListWidget(tagList);
                                  }),

                              Container(padding: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    color: Colors.white30,
                                    thickness: 1,
                                  )),

                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.heightMultiplier+5,

                                      left: SizeConfig.heightMultiplier+5,top: SizeConfig.heightMultiplier),
                                  child: Builder(
                                      builder: (context) =>
                                      new GestureDetector(
                                          onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context) => GamePublisherList() ));


                                            Navigator.pushNamed(context,
                                               CreatorHomePage.routeName);
                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "Creators",
                                              softWrap: true,
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.5,

                                            ),

                                            Container(

                                                padding: EdgeInsets.all(5),


                                                child:

                                                Text(

                                                  "(show more)",
                                                  softWrap: true,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor: 1.3,


                                                ))


                                          ],)))),
//                            Expanded(
//                              flex: 1,
//                                child:

                              FutureBuilder(
                                  future: restApiClient
                                      .showGameCreators("com.gamersgram/1",pageCount)
                                      .then((GameCreatorsPOJO responses) {
                                    creatorsList = responses;
                                    print("Response n class" +
                                        creatorsList.results[0].image);
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == null) {
                                      return Container(
                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }
                                    return gameCreatorsWidget(creatorsList);
                                  }),

                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
               // )

              //)

            ));
        },
      );
    });
  }
}

