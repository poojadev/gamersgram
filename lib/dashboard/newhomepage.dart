//import 'dart:async';
//import 'dart:collection';
//import 'dart:convert';
//import 'dart:io';
//import 'dart:ui';
//import 'package:flare_flutter/flare_actor.dart';
//import 'dart:typed_data';
//import 'package:dio/dio.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:planetgamers/categories/publisher/model/publisheui/mostpopular.dart';
//import 'package:planetgamers/creators/ui/CreatorHomePage.dart';
//import 'package:planetgamers/creators/ui/CreatorsWidget.dart';
//import 'package:planetgamers/creators/model/GameCreatorsPOJO.dart';
//import 'package:planetgamers/game/GameData/GameDetails.dart';
//import 'package:planetgamers/game/gamedashboard/gamesdashboard.dart';
//import 'package:planetgamers/game/gamedashboard/newgamesdashboard.dart';
//import 'package:planetgamers/game/gamelist/GameListPOJO.dart';
//import 'package:planetgamers/genres/model/GenresPOJO.dart';
//import 'package:planetgamers/genres/ui/GenerWidget.dart';
//import 'package:planetgamers/genres/ui/GenresHomePage.dart';
//import 'package:planetgamers/navigtion/runningtournaments.dart';
//import 'package:planetgamers/navigtion/upcomingtournaments.dart';
//import 'package:planetgamers/network/restApiClient.dart';
//import 'package:planetgamers/platforms/model/PlatformListPOJO.dart';
//import 'package:planetgamers/platforms/ui/PlatformHomePage.dart';
//import 'package:planetgamers/platforms/ui/PlatformListWidget.dart';
//import 'package:planetgamers/publishers/detail/PublisherDetails.dart';
//import 'package:planetgamers/publishers/model/GamePublisherPOJO.dart';
//import 'package:planetgamers/publishers/ui/GamePublisherHomePage.dart';
//import 'package:planetgamers/publishers/ui/PublisherHomePage.dart';
//import 'package:planetgamers/publishers/ui/PublisherWidget.dart';
//import 'package:planetgamers/stores/ui/StoreWidget.dart';
//import 'package:planetgamers/stores/model/GameStores.dart';
//import 'package:planetgamers/stores/ui/StoresHomePage.dart';
//import 'package:planetgamers/tags/TagsPOJO.dart';
//import 'package:planetgamers/tags/ui/AllTagsHomePage.dart';
//import 'package:planetgamers/tags/ui/TagListWidget.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:planetgamers/util/PageTransitionType.dart';
//import 'package:connectivity/connectivity.dart';
//import 'package:planetgamers/util/Router.dart';
//
//import 'package:planetgamers/util/constants.dart';
//import 'package:http/http.dart' as http;
//import 'package:planetgamers/util/ui/ConnectionStatusSingleton.dart';
//import 'package:planetgamers/util/ui/NoBackButton.dart';
//import 'package:planetgamers/util/ui/sizeConfig.dart';
//import 'package:video_player/video_player.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:planetgamers/util/ui/AppTheme.dart';
//import 'package:planetgamers/util/ui/sizeConfig.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flare_flutter/flare_actor.dart';
//import 'package:flutter_offline/flutter_offline.dart';
//
//var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
//RestApiClient restApiClient = new RestApiClient(dio);
//AppConstants appConstants = new AppConstants();
//SizeConfig sizeConfig = new SizeConfig();
//
//class Homepage extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//
//      home: HomepageState(),
//    );
//  }
//}
//
//class HomepageState extends StatefulWidget {
//  HomepageState({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  HomepageStateState createState() => HomepageStateState();
//}
//
//class HomepageStateState extends State<HomepageState> {
//  VideoPlayerController _controller;
//
//  GamePublisherPOJO publisherList;
//  GenresPOJO genresList;
//  PlatformList platformList;
//  GameList allGameList;
//  GameList popularGameList;
//  GameStores storeList;
//  var currentSelectedValue;
//  StreamSubscription _connectionChangeStream;
//
//  bool isOffline = false;
//
//  GameCreatorsPOJO creatorsList;
//  GameTagsPOJO tagList;
//  //var startDate;
////  var endDate;
//  int pageCount = 1;
//  Future<void> _initializeVideoPlayerFuture;
//  StreamSubscription subscription;
//  List<String> filterStringList = new List();
//
//
//  static String startDate = AppConstants.changeDateFormat(
//      DateTime.now().subtract(Duration(days: 7)).toString(), ("yyyy-MM-dd"));
//  static String endDate =
//  AppConstants.changeDateFormat(DateTime.now().toString(), ("yyyy-MM-dd"));
//
//  @override
//  void initState() {
//    // TODO: implement initState
////    restApiClient
////        .showWeeklyRelease(now1,now).then((GameList responses) {
////      gameList = responses;
////      print("OOOsss");
////    });
//    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton
//        .getInstance();
//    _connectionChangeStream =
//        connectionStatus.connectionChange.listen(connectionChanged);
//
//    filterStringList.add("New");
//    filterStringList.add("Rating");
//    filterStringList.add("Name");
////    restApiClient.showPlatformList().then((PlatformList responses) {
////      platformList = responses;
////
////      PlatformListNames.addAll(responses.results);
////
////
////
////      print("Length" + PlatformListNames.length.toString());
////    });
//    // print(new DateFormat("yyyy-MM-dd hh:mm:ss").format(now)); // => 2019-04-21 02:38:40
//
////    print("date :" +now.day.toString() + " "+ now.month.toString() + " "+ now.year.toString());
////    startDate =now.day '-' + now.month + now.year.toString();
//    // var newDate = new DateTime(now.year , now.month , now.day+7);
//
////print("next date"+newDate.toString());
//    // var prevMonth = new DateTime(date.year, date.month - 1, date.day);
//
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    // Ensure disposing of the VideoPlayerController to free up resources.
//    //  _controller.dispose();
//
//    super.dispose();
//  }
//
//  void connectionChanged(dynamic hasConnection) {
//    setState(() {
//      isOffline = !hasConnection;
//    });
//  }
//
////  void connectionChanged(dynamic hasConnection) async*{
//////    setState(() {
//////      isOffline = !hasConnection;
////
////      var connectivityResult = await (Connectivity().checkConnectivity());
////      if (connectivityResult == ConnectivityResult.mobile) {
////        print("Connected to Mobile Network");
////      } else if (connectivityResult == ConnectivityResult.wifi) {
////        print("Connected to WiFi");
////      } else {
////        print("Unable to connect. Please Check Internet Connection");
////      }
////  //  });
////  }
//
//  /*
//         pagination footer this will show page numbers
//         logic : get total count of the result ,then
//    */
//
//  //var now=DateTime.now();
////
////    DateTime dateTime=AppConstants.changeDateFormat( DateTime.now().add(Duration(days: 7)).toString(),("yyyy-MM-dd"));
////  var one = 2019 - 12 - 01;
////  var two = 2019 - 12 - 07;
//
////    restApiClient
////        .shoeGameStores().then((GameStores responses) {
////      storeList = responses;
////      print("PPOJa" +storeList.results.length.toString());
////    });
////DateTime dd=DateTime.now();
////print("start date"
////    +AppConstants.changeDateFormat(now);
//  static DateTime date = DateTime.now();
//  var result = "${date.year}-${date.month}-${date.day}";
//
//  // DateTime dd=  DateTime.parse(result);
//
//
//  checkInternetConnectivity() async {
//    var result = await Connectivity().checkConnectivity();
//    if (result == ConnectivityResult.none) {
//      _showDialog(
//          'No internet',
//          "You're not connected to a network"
//      );
//    } else if (result == ConnectivityResult.mobile) {
//      _showDialog(
//          'Internet access',
//          "You're connected over mobile data"
//      );
//    } else if (result == ConnectivityResult.wifi) {
//      _showDialog(
//          'Internet access',
//          "You're connected over wifi"
//      );
//    }
//  }
//
//  _showDialog(title, text) {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text(title),
//            content: Text(text),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        }
//    );
//  }
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
//      "User-agent": "techigirl.gamerszone/1"
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
//
////
////  Future<GameList> popularGamesInTheYear() async {
////    //  print(two);
////    print(now);
////    print(now1);
//////    String url = 'https://api.rawg.io/api/games?dates='+ now1 + "," + now ;
////    String popularGames="https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-addedd&page=1";
////    final response =
////    await http.get(popularGames, headers: {"Accept": "application/json"});
////    if (response.statusCode == 200) {
////      popularGameList=GameList.fromJson(json.decode(response.body));
////      print("OOO"+popularGameList.results[0].name);
////      return popularGameList;
////
////    } else {
////      throw Exception('Failed to load post');
////    }
////  }
//
//  Widget popularGamesOfTheYearWidget(BuildContext context) {
//    return
//      //User input pauses carousels automatic playback
//
//      CarouselSlider(
//        viewportFraction: 1.0,
//        height: SizeConfig.heightMultiplier * 45,
//        aspectRatio: MediaQuery
//            .of(context)
//            .size
//            .aspectRatio,
//        autoPlay: true,
//        enlargeCenterPage: true,
//        pauseAutoPlayOnTouch: Duration(seconds: 3),
//        items: popularGameList.results.map(
//              (index) {
//            return Column(
//              children: <Widget>[
//                Expanded(
//                    child: Stack(
//                      alignment: Alignment.bottomCenter,
//
//                      children: <Widget>[
//                        Container(
//
//                          child: GestureDetector(
//                            onTap: () {
//                              index.clip == null
//                                  ? Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                          GameDetailsStates(
//                                            gameId: index.id,
//                                            screenShots:
//                                            index.short_screenshots,
//                                            gameName: index.name,
//                                            released: index.released,
//                                            rating: index.rating,
//                                            stores: index.stores,
//                                            clip: "no",
//                                            genres: index.genres,
//                                            platforms: index.platforms,
//                                            flag: 1,
//                                          )))
//                                  : Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                          GameDetailsStates(
//                                            clips:
//                                            index.clip.clips.full,
//                                            gameId: index.id,
//                                            screenShots:
//                                            index.short_screenshots,
//                                            gameName: index.name,
//                                            released: index.released,
//                                            rating: index.rating,
//                                            stores: index.stores,
//                                            clip: index.clip.clip,
//                                            genres: index.genres,
//                                            platforms: index.platforms,
//                                            flag: 1,
//                                          )));
//                            },
//
//                            child: index
//                                .background_image != null ? CachedNetworkImage(
//                              imageUrl:
//                              index
//                                  .background_image,
//                              imageBuilder: (context,
//                                  imageProvider) =>
//                                  Container(
//
//                                    decoration:
//                                    BoxDecoration(
//                                      image:
//                                      DecorationImage(
//                                        image:
//                                        imageProvider,
//                                        fit: BoxFit.cover,
//                                        //  colorFilter:
//                                        //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                                      ),
//                                    ),
//                                  ),
//                              placeholder: (context,
//                                  url) =>
//                                  Center(
//                                      child: FlareActor('assets/loader.flr',
//                                        //  animation:
////              "circle"
//
//                                      )),
//                              errorWidget: (context,
//                                  url, error) =>
//                                  Icon(Icons.error),
//                            ) : Text("No mage found"),
//                          ),
//                        ),
//
//                        Row(
//                          children: <Widget>[
////          Card(
////            elevation: 11,
////            //color: Color.fromRGBO(32, 32, 34, 40),
////            color: Color.fromRGBO(32, 32, 34, 40),
//
//                            // child:
//
//                            Expanded(
//                              flex: 1,
//                              child:
////
//                              Container(
//                                alignment: Alignment.topLeft,
//                                padding: EdgeInsets.only(
//                                    left: 20, right: 20, top: 18),
//                                decoration: new BoxDecoration(
//                                    color: Color.fromRGBO(32, 32, 34, 30),
//                                    borderRadius: new BorderRadius.only(
//                                        topRight: const Radius.circular(40.0),
//                                        topLeft: const Radius.circular(40.0))),
//                                height: SizeConfig.heightMultiplier * 8,
//                                //  color: Color.fromRGBO(32, 32, 34, 40),
//                                child: Text(
//                                  index.name,
//                                  style: AppTheme.subTitleLights,
//                                ),
//                              ),
//                            ),
//
//                            //  )
//                            // )
//
//                            // )
//                          ],
//                        )
//                      ],)),
//
//
//              ],
//            );
//          },
//        ).toList(),
//      );
//  }
//
//
//  Widget weeklyReleaseGamesWidget() {
//    print(SizeConfig.heightMultiplier * 24);
//    return Align(
//        alignment: Alignment.topCenter,
//        child: Directionality(
//            textDirection: TextDirection.ltr,
//            child: new Container(
//                height: SizeConfig.heightMultiplier * 24,
//                //   width: SizeConfig.widthMultiplier*6,
//                child: ListView.builder(
//                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                  // physics: const NeverScrollableScrollPhysics(),
//
//                  scrollDirection: Axis.horizontal,
//                  shrinkWrap: true,
//                  itemCount: allGameList == null ? 0 : allGameList.results
//                      .length,
//                  itemBuilder: (context, index) {
//                    return new GestureDetector(
//                        onTap: () {
//                          /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//
//                          allGameList.results[index].clip == null
//                              ? Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) =>
//                                  GameDetailsStates(
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
//                        },
//                        child: AnimationConfiguration.staggeredGrid(
//                            position: index,
//                            duration: const Duration(milliseconds: 375),
//                            columnCount: allGameList.results.length,
//                            child: ScaleAnimation(
//                                child: FadeInAnimation(
////                                    child: Stack(children: <Widget>[
////                                      Container(
////
////
//////                              height: animation.value,
//////                              width: animation.value,
////
////                                          padding: EdgeInsets.only(
////                                              right: 5.0, top: 0.5),
////                                          child: Card(
////                                              shape: RoundedRectangleBorder(
////
////                                                  borderRadius:
////                                                  BorderRadius.circular(3)),
////                                              semanticContainer: true,
////                                              color: Color.fromRGBO(
////                                                  32, 32, 32, 5),
////                                              elevation: 10.0,
////                                              child: Container(
////                                                decoration: BoxDecoration(
////                                                    border: Border.all(
////                                                        color: Colors
////                                                            .white30)),
////                                                height: SizeConfig
////                                                    .heightMultiplier * 15,
////                                                width: SizeConfig
////                                                    .widthMultiplier * 33,
////                                                child:
////
//
//                                  child: Container(
//
//                                      padding: EdgeInsets.only(
//                                          left: 1 * SizeConfig.heightMultiplier,
//                                          right: 1 *
//                                              SizeConfig.heightMultiplier,
//                                          bottom: 1 *
//                                              SizeConfig.heightMultiplier),
//                                      child: Column(
//                                        //mainAxisSize: MainAxisSize.min,
//                                        children: <Widget>[
//                                          allGameList.results[index]
//                                              .background_image !=
//                                              null
//                                              ? Container(
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    color: Colors
//                                                        .white30)),
////                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
////                                                      bottom: 1 * SizeConfig.heightMultiplier),
//
//                                            height: SizeConfig
//                                                .heightMultiplier *
//                                                17,
//                                            width: SizeConfig
//                                                .widthMultiplier *
//                                                34,
//
//                                            child:
//
//
//                                            CachedNetworkImage(
//                                              imageUrl: allGameList
//                                                  .results[index]
//                                                  .background_image,
//                                              imageBuilder: (context,
//                                                  imageProvider) =>
//                                                  Container(
//                                                    decoration: BoxDecoration(
//                                                      image: DecorationImage(
//                                                        image: imageProvider,
//                                                        fit: BoxFit
//                                                            .cover,
//                                                        //  colorFilter:
//                                                        //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                                                      ),
//                                                    ),
//                                                  ),
//                                              placeholder: (context,
//                                                  url) =>
//                                                  Container(
//
//                                                      alignment: Alignment
//                                                          .center,
//                                                      child:
//
//                                                      FlareActor(
//                                                          'assets/loader.flr',
//                                                          alignment: Alignment
//                                                              .center,
//                                                          fit: BoxFit
//                                                              .contain,
//                                                          animation: "loader"
//
//
//                                                      )),
//                                              errorWidget: (context,
//                                                  url, error) =>
//                                                  Icon(Icons.error),
//                                            ),
//                                          )
//                                              : Container(
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    color: Colors
//                                                        .white30)),
////                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
////                                                      bottom: 1 * SizeConfig.heightMultiplier),
//
//                                            height: SizeConfig
//                                                .imageSizeMultiplier *
//                                                17,
//                                            width: SizeConfig
//                                                .widthMultiplier *
//                                                34,
//                                            child: Center(child: Text(
//                                              "No Image avaliable",
//                                              style: AppTheme.subTitleLights,
//                                              textScaleFactor: 0.9,)),
//                                          ),
////                                              Expanded(
////                                                  flex: 1,
////                                                  child:
//
//                                          Expanded(
//                                            child:
//                                            Container(
//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                      color: Colors
//                                                          .white30)),
//                                              height: SizeConfig
//                                                  .heightMultiplier *
//                                                  7.8,
//                                              width: SizeConfig
//                                                  .widthMultiplier *
//                                                  34,
//                                              padding: EdgeInsets.only(left: 1 *
//                                                  SizeConfig.heightMultiplier,
//                                                  top: 2),
//                                              child: Text(
//                                                allGameList.results[index].name,
//                                                style: AppTheme.subTitleLights,
//                                                //  textAlign: TextAlign.center,
//                                              ),
//                                            ),),
//                                          //),
//                                        ],
//                                      )),
////                                              ))
////
////                                      )
////                                    ])
//
//                                ))));
//                  },
//                ))));
//  }
//
//
//  Widget footerWidget() {
//    print("INSIDE Footer");
//    //   print("wee" +pages.length.toString());
//
////      return FractionallySizedBox(
////          widthFactor: 1,
//    //child:Container(
//    //   padding: EdgeInsets.only(left: 20,right: 20),
////              decoration: new BoxDecoration(
////                  color: Color.fromRGBO(32, 32, 34, 40),
////                  borderRadius: new BorderRadius.only(
////                      topLeft: const Radius.circular(40.0),
////                      topRight: const Radius.circular(40.0))),
//    //  child:
//
//    return Card(
//      elevation: 11,
//      //color: Color.fromRGBO(32, 32, 34, 40),
//      color: Colors.blue,
//      shape: RoundedRectangleBorder(
//          borderRadius: const BorderRadius.only(
//              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
//      // height: 60.0,
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              // padding: EdgeInsets.only(left: 18,right: 18),
//              color: Color.fromRGBO(32, 32, 34, 40),
//              child: IconButton(
//                  icon: new Icon(Icons.home),
//                  color: Colors.white,
//                  onPressed: () {}),
//            ),
//          ),
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.only(left: 18, right: 18),
//              color: Color.fromRGBO(32, 32, 34, 40),
//              child: IconButton(
//                  icon: new Icon(Icons.home),
//                  color: Colors.white,
//                  onPressed: () {}),
//            ),
//          ),
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.only(left: 18, right: 18),
//              decoration: BoxDecoration(
//                color: Color.fromRGBO(32, 32, 34, 40),
//                // border: Border.all(color: Colors.black),
//              ),
//              child: IconButton(
//                  icon: new Icon(Icons.home),
//                  color: Colors.white,
//                  onPressed: () {}),
//            ),
//          ),
//        ],
//      ),
//
//      //  )
//      // )
//    );
//  }
//
//
//  Widget headerWidget() {
//    // print("INSIDE Footer");
//    //   print("wee" +pages.length.toString());
//
//    return FractionallySizedBox(
//        widthFactor: 1,
//        child: Container(
//            padding: EdgeInsets.only(left: 20, right: 20),
//            decoration: new BoxDecoration(
//                color: Color.fromRGBO(32, 32, 34, 30),
//                borderRadius: new BorderRadius.only(
//                    bottomRight: const Radius.circular(40.0),
//                    bottomLeft: const Radius.circular(40.0))),
//            child: Row(
//              children: <Widget>[
////          Card(
////            elevation: 11,
////            //color: Color.fromRGBO(32, 32, 34, 40),
////            color: Color.fromRGBO(32, 32, 34, 40),
//
//                // child:
//
//                Expanded(
//                  flex: 1,
//                  child: Container(
//                    alignment: Alignment.topLeft,
//                    height: SizeConfig.heightMultiplier * 7,
//                    padding: EdgeInsets.only(left: 18, right: 18, top: 10),
//                    //  color: Color.fromRGBO(32, 32, 34, 40),
//                    child: Text(
//                      "Weekly Release",
//                      style: AppTheme.subTitleLights,
//                    ),
//                  ),
//                ),
//
//                //  )
//                // )
//
//                // )
//              ],
//            )));
//  }
//
//  var _SelectdType = "Order By";
//
//  Widget filtersWidget() {
//    return new Row(children: <Widget>[
//      new Text("Currency: "),
//      new Container(
//        color: Colors.white,
//        padding: EdgeInsets.all(5),
////          elevation: 11,
////          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.elliptical(90, 90))),
//
//        // padding: new EdgeInsets.all(16.0),
//
//        child: DropdownButtonHideUnderline(
//          child: new DropdownButton<String>(
//            style:
//            TextStyle(color: Colors.white, decorationColor: Colors.white),
//
//            items: filterStringList.map((String val) {
//              return DropdownMenuItem<String>(
//                value: val,
//                child: new Container(
//                  padding: EdgeInsets.only(right: 5, left: 5),
//                  color: Colors.white,
//                  child: Text(
//                    val,
//                    style: TextStyle(color: Colors.black),
//                  ),
//                ),
//              );
//            }).toList(),
//            // hint:Text("Sort By"),
//            hint: Text(_SelectdType),
//            value: currentSelectedValue,
//
//            isDense: true,
//            onChanged: (newValue) {
//              setState(() {
//                currentSelectedValue = newValue;
//              });
//              print(currentSelectedValue);
//            },
//          ),
//        ),
//
////
////          DropdownButton<String>(
////            hint: Text("Select Device"),
////            value: currentSelectedValue,
////            isDense: true,
////            onChanged: (newValue) {
////              setState(() {
////                currentSelectedValue = newValue;
////              });
////              print(currentSelectedValue);
////            },
////            items: filterStringList.map((String value) {
////              return DropdownMenuItem<String>(
////                value: value,
////                child: Text(value),
////              );
////            }).toList(),
////          ),
//      )
//    ]);
//  }
//
//
//    Future<bool> onBackPressed() {
//      return showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              title: Text('Are you sure?'),
//              content: Text('You are going to exit the application!!'),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('NO'),
//                  onPressed: () {
//                    Navigator.of(context).pop(false);
//                  },
//                ),
//                FlatButton(
//                  child: Text('YES'),
//                  onPressed: () {
//                    Navigator.of(context).pop(true);
//                  },
//                ),
//              ],
//            );
//          });
//    }
//  String weeklyDate = startDate + "," + endDate;
//
//  // (isOffline)? new Text("Not connected") :
//
//
//  bool isOpen = false;
//
//
//  Widget drwaer() {
//    print("Inside drawer");
//    return Container(
//      height: SizeConfig.heightMultiplier * 100,
//      width: SizeConfig.widthMultiplier * 60,
//      color: Colors.red,
//      child: Stack(children: <Widget>[
//
//        Text("OK"),
//        Text("OK 1")
//
//
//      ],),
//    );
//  }
//
//
//  Widget sideNav() {
//    return
//      Container(
//          width: SizeConfig.widthMultiplier * 60,
//          color: Colors.black54,
//          child:
//          Drawer(
//              child: Stack(
//                  children: <Widget>[
//                    //first child be the blur background
////          BackdropFilter(
////          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), //this is dependent ,on the import statment above
////          child: Container(
////              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5))
////          )
////      ),
//                    ListView(
//                        padding: EdgeInsets.zero,
//                        children: <Widget>[
//                          DrawerHeader(
//                              child: Column(children: <Widget>[
//
//                                Container(
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
//                                    child: Image.asset("assets/images/gz.png",
//                                      height: SizeConfig.heightMultiplier * 5,
//                                    )),
//
//
//                                AutoSizeText(
//                                  "Gamers Zone",
//                                  style: AppTheme.descText,
//                                  textScaleFactor: 1.3,
//                                  softWrap: true,
//
//                                ),
//                              ],)
//                          ),
//
//
//                          ListTile(
//                            //    leading: Icon(Icons.info, color: Colors.white),
//                              title: AutoSizeText(
//                                "About",
//                                style: AppTheme.descText,
//                                textScaleFactor: 1.3,
//                                softWrap: true,
//
//                              ),
//
//                              onTap: () {
//
//                              }
//                          ),
//                          ListTile(
//                            //   leading: Icon(Icons.message, color: Colors.white),
//                              title: AutoSizeText(
//                                "Suggestions",
//                                style: AppTheme.descText,
//                                textScaleFactor: 1.3,
//                                softWrap: true,
//
//                              ),
//
//                              onTap: () {
//
//                              }
//                          ),
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
//                        ]),
//
//
//                  ]
////      )
////      ]
//              )
//          ));
//  }
//
//
////    Widget gameClips() {
////      return Align(
////          alignment: Alignment.topCenter,
////          child: Directionality(
////              textDirection: TextDirection.ltr,
////              child: new Container(
////                  height: 200.0,
////                  child: ListView.builder(
////                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
////                    // physics: const NeverScrollableScrollPhysics(),
////
////                    scrollDirection: Axis.horizontal,
////                    shrinkWrap: true,
////                    itemCount: gameList == null ? 0 : gameList.results.length,
////                    itemBuilder: (context, index) {
////                      print(gameList.results[index].clip != null
////                          ? gameList.results[index].clip.clip
////                          : "not ok");
////                      gameList.results[index].clip != null
////                          ? _controller = VideoPlayerController.network(
////                          gameList.results[index].clip.clip)
////                          : _controller = VideoPlayerController.network(
////                          "https://media.rawg.io/media/stories-640/1ad/1adba4d856c0db20117f927fadbcf185.mp4");
////                      _initializeVideoPlayerFuture = _controller.initialize();
////                      _controller.setLooping(true);
////                      return AnimationConfiguration.staggeredGrid(
////                          position: index,
////                          duration: const Duration(milliseconds: 375),
////                          columnCount: gameList.results.length,
////                          child: ScaleAnimation(
////                              child: FadeInAnimation(
////                                  child: Container(
////                                      height: 200,
////                                      width: 170,
//////                              height: animation.value,
//////                              width: animation.value,
////
////                                      padding: EdgeInsets.only(
////                                          left: 5.0, right: 5.0, top: 0.5),
////                                      child: Card(
////                                          shape: RoundedRectangleBorder(
////                                              borderRadius:
////                                              BorderRadius.circular(3)),
////                                          semanticContainer: true,
////                                          color: Color.fromRGBO(32, 32, 32, 5),
////                                          elevation: 10.0,
////                                          child: Container(
////                                            child: Column(
////                                              children: <Widget>[
////                                                FutureBuilder(
////                                                  future:
////                                                  _initializeVideoPlayerFuture,
////                                                  builder: (context, snapshot) {
////                                                    if (snapshot
////                                                        .connectionState ==
////                                                        ConnectionState.done) {
////                                                      // If the VideoPlayerController has finished initialization, use
////                                                      // the data it provides to limit the aspect ratio of the video.
////
////                                                      return AspectRatio(
////                                                        aspectRatio: _controller
////                                                            .value.aspectRatio,
////                                                        // Use the VideoPlayer widget to display the video.
////
////                                                        child: VideoPlayer(
////                                                            _controller),
////                                                      );
////                                                    } else {
////                                                      // If the VideoPlayerController is still initializing, show a
////                                                      // loading spinner.
////                                                      return Center(
////                                                          child:
////                                                          FlareActor(
////                                                              'assets/loader.flr',
////                                                              alignment: Alignment
////                                                                  .center,
////                                                              fit: BoxFit
////                                                                  .contain,
////                                                              animation: "loader"
////
////
////                                                          ));
////                                                    }
////                                                  },
////                                                ),
////                                                SizedBox(
////                                                  height: 20.0,
////                                                ),
////                                                Text(
////                                                  gameList.results[index].name,
////                                                  style: TextStyle(
////                                                      fontSize: 18,
////                                                      color: Colors.white),
////                                                ),
////                                                SizedBox(
////                                                  height: 20.0,
////                                                ),
////                                                Stack(
////                                                  children: <Widget>[
////                                                    Container(
////                                                        alignment: Alignment
////                                                            .bottomCenter,
////                                                        child: ButtonTheme(
////                                                            child: RaisedButton(
////                                                              padding:
////                                                              EdgeInsets.all(
////                                                                  10.0),
////                                                              color: Colors
////                                                                  .transparent,
////                                                              textColor:
////                                                              Colors.white,
////                                                              onPressed: () {
////                                                                // Wrap the play or pause in a call to `setState`. This ensures the
////                                                                // correct icon is shown.
////                                                                setState(() {
////                                                                  // If the video is playing, pause it.
////                                                                  if (_controller
////                                                                      .value
////                                                                      .isPlaying) {
////                                                                    _controller
////                                                                        .pause();
////                                                                  } else {
////                                                                    // If the video is paused, play it.
////                                                                    _controller
////                                                                        .play();
////                                                                  }
////                                                                });
////                                                              },
////                                                              child: Icon(
////                                                                _controller
////                                                                    .value
////                                                                    .isPlaying
////                                                                    ? Icons
////                                                                    .pause
////                                                                    : Icons
////                                                                    .play_arrow,
////                                                                size: 30.0,
////                                                              ),
////                                                            )))
////                                                  ],
////                                                )
////                                              ],
////                                            ),
////                                          ))))));
////                    },
////                  ))));
////    }
//
//  // Color textColor =Colors.computeLuminance() > 0.5 ? Colors.black : Colors.white;
//
//   String publisherRoute = 'PublisherHomePage';
//
//  @override
//  Widget build(BuildContext context) {
//    // Internet Present Case
//    /*
//    weekly release games
//     */
//
//    /*
//         pagination footer this will show page numbers
//         logic : get total count of the result ,then
//    */
//
//
//    /*
//         pagination footer this will show page numbers
//         logic : get total count of the result ,then
//    */
//    List<GamePublisherResult>passArgu=new List();
//
//
//    return
//
//
//
//
//
//      (isOffline) ? new Container(
//        height: SizeConfig.heightMultiplier * 30,
//
//        alignment: Alignment
//            .center,
//        child:
//
//        FlareActor(
//            'assets/nointernet.flr',
//            alignment: Alignment
//                .center,
//            fit: BoxFit
//                .contain,
//            animation: "nointernet"
//
//
//        )) :
//
//    // print("Connected to Mobile Network");
//      new WillPopScope(
//        onWillPop: () async {
//          onBackPressed();
//      // You can do some work here.
//      // Returning true allows the pop to happen, returning false prevents it.
//      return true;
//    },
//    child:
//
//    new LayoutBuilder(builder: (context, constraints) {
//      print("connected");
//      return OrientationBuilder(
//
//
//        builder: (context, orientation) {
//          SizeConfig().init(constraints, orientation);
//          return
////            MaterialApp(
////
//////                routes:<String,WidgetBuilder> {
//////
//////                  //PublisherHomePage.routeName: (context) => PublisherHomePage(),
//////                  publisherRoute: (context) =>  PublisherHomePage(
//////                    //    publisherId:  args.publisherId,
//////                    // publisherName:  args.publisherName,
//////
//////
//////
//////                  ),
//////
//////                },
////
//////
////                onGenerateRoute: Router.generateRoute,
////                routes: <String, WidgetBuilder>{
////                  //  '/PublisherHomePage': (BuildContext context) => new PublisherHomePage( ),
////
////                  '/PublisherHomePage': (BuildContext context) => new PublisherHomePage( ),
////                },
////
////                home:
//
//
//                Scaffold(
//
//                  appBar: AppBar(
//                    backgroundColor: Color.fromRGBO(21, 21, 21, 5),
//                    elevation: 0.0,
//
//                  ),
//
//
//                  drawer: Theme(
//                      data: Theme.of(context).copyWith(
//                        // Set the transparency here
//                        canvasColor: Colors.black.withOpacity(
//                            0.5), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
//                      ),
//                      child: sideNav()),
//
//
//                  //this will just add the Navigation Drawer Icon
//                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
//                  //    bottomNavigationBar: footerWidget(),
//
//                  body:
//
//                  CustomScrollView(
//                    slivers: <Widget>[
////                    SliverAppBar(
////                      pinned: true,
////                      expandedHeight: 256.0,
//////                      flexibleSpace: FlexibleSpaceBar(
//////                        title: Text('Title'),
//////                      ),
////                    ),
//
//
//                      SliverList(
//                        delegate: SliverChildListDelegate([
//
//                          Column(
//                            children: <Widget>[
//
////
////                            Container(
////                                alignment: Alignment.topLeft,
////                                padding: EdgeInsets.only(top: 20),
////
////                                child:
////                                Text("Weekly Release", softWrap: true,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
//////                            Expanded(
//////                              flex: 1,
//////                                child:
////                            FutureBuilder(
//////
////                                future:  getWeeklyRelease()
////                                ,
////
////                                builder: (BuildContext context, AsyncSnapshot snapshot) {
////                                  if (snapshot.hasData == null) {
////                                    return Container(
////                                        child: CircularProgressIndicator(
////                                            valueColor: AlwaysStoppedAnimation<Color>(
////                                                Colors.green)));
////                                  }
////                                  return ();
////                                }),
//
//
//                              Stack(children: <Widget>[
//
//
//                                FutureBuilder(
////
//                                    future: restApiClient
//                                        .showWeeklyRelease(weeklyDate)
//                                        .then((GameList responses) {
//                                      popularGameList = responses;
//                                      print(popularGameList.results[0]
//                                          .background_image);
//                                    }),
//
//                                    builder: (BuildContext context,
//                                        AsyncSnapshot snapshot) {
//                                      if (popularGameList == null) {
//                                        return Container(
//                                            height: SizeConfig
//                                                .heightMultiplier * 10,
//                                            child: FlareActor(
//                                                'assets/loader.flr',
//                                                alignment: Alignment.center,
//                                                fit: BoxFit.contain,
//                                                animation: "loader"
//
//
//                                            ));
//                                      }
//                                      return popularGameList == null
//                                          ? Container()
//                                          : popularGamesOfTheYearWidget(
//                                          context);
//                                    }),
//
//                                headerWidget(),
//
//
//                              ],),
//
//
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
//                              /*
//                            weekly release games
//                             */
//
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
////                                            Navigator.push(
////                                                context,
////                                                MaterialPageRoute(
////                                                    builder: (context) =>
////                                                        Dashboard()));
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: GameNewsDashboard()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            AutoSizeText(
//                                              "All Games",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//                                                ))
//
//
//                                          ],)))),
////                            Expanded(
////                              flex: 1,
////                                child:
//                              FutureBuilder(
////
//                                  future: restApiClient
//                                      .showListOfGames(
//                                      "techigirl.gamerszone/1", 1, "-added",
//                                      4)
//                                      .then((GameList responses) {
//                                    allGameList = responses;
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return weeklyReleaseGamesWidget();
//                                  }),
//
//
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
///*
//  Publishers widget
// */
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => PublisherHomePage() ));
//                                          Navigator.pushNamed(context, '/publisherhomepage');
//                                         //   Navigator.push(context, PublisherHomePage());
//                                           // Navigator.pushNamed(context, publisherRoute, arguments: 'Data from home');
//
//
////                                            Navigator.pushReplacement(context,
////                                                PageTransition(type:
////                                                PageTransitionType
////                                                    .rightToLeft,
////                                                    child: PublisherHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            AutoSizeText(
//                                              "Publishers",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
//
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .showPublisherList(1)
//                                      .then((GamePublisherPOJO responses) {
//                                    publisherList = responses;
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return publisherGalleryWidget(
//                                        publisherList);
//                                  }),
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
//                              //Divider(color: Colors.red,thickness: 1,),
//
//                              /*
//             Genres widget
//             */
//
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: GenresHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            Text(
//                                              "Genres",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
////                            Expanded(
////                              flex: 1,
////                                child:
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .showGenresList(1)
//                                      .then((GenresPOJO responses) {
//                                    genresList = responses;
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return genresGalleryWidget(genresList);
//                                  }),
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
///*
//Platform widget
// */
//
////                            RaisedButton(onPressed: (){
////                              Navigator.push(context,
////                                  MaterialPageRoute(
////                                      builder: (context) => GamePublisherList()));
////                            },child: Text("ok"),),
//
////                            Builder(
////                              builder: (context) => RaisedButton(
////                                onPressed: () {
////                                  Navigator.push(context,
////                                      MaterialPageRoute(
////                                          builder: (context) => GamePublisherList()));
////                                },
////                                child: Text('Registrese'),
////                              ),
////                            ),
////
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
//
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: PlatformHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            Text(
//                                              "Platforms",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
////                            Expanded(
////                              flex: 1,
////                                child:
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .showPlatformList(pageCount)
//                                      .then((PlatformList responses) {
//                                    platformList = responses;
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return platformListWidget(platformList);
//                                  }),
//
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: StoresHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            Text(
//                                              "Stores",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
////                            Expanded(
////                              flex: 1,
////                                child:
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .shoeGameStores(pageCount)
//                                      .then((GameStores responses) {
//                                    storeList = responses;
//                                    print("Response n class" +
//                                        storeList.results[0].domain);
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return gamesStoreWidget(storeList);
//                                  }),
//
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: AllTagsHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            Text(
//                                              "Tags",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .showGameTags(pageCount)
//                                      .then((GameTagsPOJO responses) {
//                                    tagList = responses;
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return tagListWidget(tagList);
//                                  }),
//
//                              Container(padding: EdgeInsets.only(top: 10),
//                                  child: Divider(
//                                    color: Colors.white30,
//                                    thickness: 1,
//                                  )),
//
//                              Container(
//                                  alignment: Alignment.topLeft,
//                                  padding: EdgeInsets.only(left: 15,
//                                      top: 10, bottom: 10),
//                                  child: Builder(
//                                      builder: (context) =>
//                                      new GestureDetector(
//                                          onTap: () {
////                                      Navigator.of(context).push(MaterialPageRoute(
////                                          builder: (context) => GamePublisherList() ));
//
//
//                                            Navigator.push(context,
//                                                PageTransition(type:
//                                                PageTransitionType
//                                                    .rightToLeft,
//                                                    child: CreatorHomePage()));
//                                          },
//                                          child: Row(children: <Widget>[
//                                            AutoSizeText(
//                                              "Creators",
//                                              softWrap: true,
//                                              style: AppTheme.mainTitles,
//                                              textScaleFactor: 1.5,
//
//                                            ),
//
//                                            Container(
//
//                                                padding: EdgeInsets.all(5),
//
//
//                                                child:
//
//                                                Text(
//
//                                                  "(show more)",
//                                                  softWrap: true,
//                                                  style: AppTheme
//                                                      .subTitleLights,
//
//
//                                                ))
//
//
//                                          ],)))),
////                            Expanded(
////                              flex: 1,
////                                child:
//
//                              FutureBuilder(
//                                  future: restApiClient
//                                      .showGameCreators(pageCount)
//                                      .then((GameCreatorsPOJO responses) {
//                                    creatorsList = responses;
//                                    print("Response n class" +
//                                        creatorsList.results[0].image);
//                                  }),
//                                  builder:
//                                      (BuildContext context,
//                                      AsyncSnapshot snapshot) {
//                                    if (snapshot.hasData == null) {
//                                      return Container(
//                                          child: FlareActor(
//                                              'assets/loader.flr',
//                                              alignment: Alignment.center,
//                                              fit: BoxFit.contain,
//                                              animation: "loader"
//
//
//                                          ));
//                                    }
//                                    return gameCreatorsWidget(creatorsList);
//                                  }),
//
//                            ],
//                          ),
//                        ]),
//                      )
//                    ],
//                  ),
//               // )
//
//              //)
//
//            );
//        },
//      );
//    }));
//  }
//}
//
