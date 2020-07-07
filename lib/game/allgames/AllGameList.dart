import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';

import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/genres/model/GenresPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/platformsWidget.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter/foundation.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
//List<GameStores> storeDetailsList;
var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
int genresId;
//GameGenresDetails gameGenresDetails;


class AllGamesList extends StatelessWidget {
  static const routeName="/allgamelist";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllGamesListState(
        id: genresId,
      ),
    );
  }
}

class AllGamesListState extends StatefulWidget {
  static Map event;

  AllGamesListState({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}
TabController _controller;
int pageCount = 1;
int filterPageCount = 1;

int count;
List<int> pages = new List();
List<int> filterPages = new List();

class _CreatorDetailsState extends State<AllGamesListState> with SingleTickerProviderStateMixin{
  List<String>filterStringList=new List();
  TextEditingController editingController = TextEditingController();


//AutoCompleteTextField searchTextField;
  GameList gameListDetailsResponse;
  List<GameListDetails>gameListDetails = new List();

//Map<String, GameListDetails> searchResultGame = new HashMap();




  AutoCompleteTextField<GameListDetails> textField;

  GlobalKey<AutoCompleteTextFieldState<GameListDetails>> gamesearchkey =
  new GlobalKey();
  @override
  void initState() {
   // filterStringList.add("Name");
    filterStringList.add("Popular");
    filterStringList.add("Ratingwise");


    super.initState();

  }

  String currentText = "@#%";



  bool loading = true;






  ScrollController _rrectController = ScrollController();


  int selectedPlatformId;


  var platformSelectedValue;
  var _SelectdType = "Popular";
  var currentSelectedValue;



  List<PlatformListDetails>platformListFilter = new List();
  var selectedPlatform;
  ScrollController _controller = ScrollController();


  Widget gamePlatformWidget() {
    return new Row(children: <Widget>[
      new

      Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black54,
          ),
          child:
          Container(
            //  width: SizeConfig.widthMultiplier*50,

            color: Colors.white12,
            padding: EdgeInsets.all(5),
//          elevation: 11,
//          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.elliptical(90, 90))),


            // padding: new EdgeInsets.all(16.0),

            child:

            DropdownButtonHideUnderline(child:


            new DropdownButton<int>(
              style: TextStyle(
                  color: Colors.white, decorationColor: Colors.white),

              items: platformListFilter.map((PlatformListDetails val) {
                return DropdownMenuItem<int>(

                  value: val.id,
                  child: new Container(
                    // width: SizeConfig.widthMultiplier*50,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    // color: Colors.white12,
                    child: Text(val.name, style: AppTheme.subTitleLights,
                      textScaleFactor: 1.2,),


                  ),
                );
              }).toList(),
              // hint:Text("Sort By"),
              hint: Text("Plafrom"),
              value: platformSelectedValue,

              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  platformSelectedValue = newValue;
                  selectedPlatformId = platformSelectedValue;
                  print("platform id" + selectedPlatformId.toString());
                  pageCount = 1;
                });


                // print(currentSelectedValue);
              },),


            ),


          ))
    ]);
  }
  String ordering = "-added";


  @override
  Widget build(BuildContext context) {
    print("ordering"+ordering);

    Widget filtersWidget()
    {



      return new Row(children: <Widget>[

        Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black54,
            ),
            child:
            Container(
              //  width: SizeConfig.widthMultiplier*44,

              color: Colors.white12,
              padding: EdgeInsets.all(5),
//          elevation: 11,
//          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.elliptical(90, 90))),


              // padding: new EdgeInsets.all(16.0),

              child:

              DropdownButtonHideUnderline(child:


              new DropdownButton<String>(

                style: TextStyle(color: Colors.white, decorationColor: Colors.white),

                items:filterStringList.map((String val){
                  return DropdownMenuItem<String>(


                    value: val,
                    child: new Container(
                      // width: SizeConfig.widthMultiplier*40,

                      padding: EdgeInsets.only(left: 5),
                      // color: Colors.redAccent,
                      child: Text(val, style: AppTheme.subTitleLights,
                        textScaleFactor: 1.2,),


                    ),
                  );
                }).toList(),
                // hint:Text("Sort By"),
                hint:Text(_SelectdType),
                value: currentSelectedValue,

                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                    pageCount = 1;
                  });

                  if (currentSelectedValue == 'Ratingwise')
                  {

                    ordering="-rating";
                  }
                  else if(currentSelectedValue=="Popular")
                  {
                    ordering="-added";
                  }
                  print(currentSelectedValue);
                },),),


            )
        )
      ]);

    }
    GameList filteredGameList;
    //  GameList filteredGameList;
    Widget allGamesListWidget() {
      var mediaQuery = MediaQuery.of(context);
      return LayoutBuilder(builder: (context, boxSizing) {
//      var sizingInformation = SizingInformation(
//        orientation: mediaQuery.orientation,
//        deviceType: getDeviceType(mediaQuery),
//        screenSize: mediaQuery.size,
//        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
//      );
//   print("Size info" +sizingInformation.screenSize.toString());
//   print( SizeConfig.heightMultiplier);

        return new Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              //  color: Colors.red,
                borderRadius:
                BorderRadius
                    .all(Radius
                    .circular(
                    1)),
                border: Border.all(color:
                Colors.white30)
            ),
            height: pages.length == 0
                ? SizeConfig.heightMultiplier * 66
                : SizeConfig.heightMultiplier * 56,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),


              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: filteredGameList == null ? 0 : filteredGameList.results.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    onTap: () {
                      /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                      YoutubeArguments filteredGameListArguments = new YoutubeArguments(
                        flag: 1,
                        gameName:filteredGameList.results[index].name!=null? filteredGameList.results[index].name:AppConstants.noInfo
                        ,gameId: filteredGameList.results[index].id!=null?filteredGameList.results[index].id:AppConstants.noInfo,

                        screenShots: filteredGameList.results[index].short_screenshots!=null?
                        filteredGameList.results[index].short_screenshots:AppConstants.noInfo,
                        //clip:filteredGameList.results[index].clip.clip!=null?filteredGameList.results[index].clip.clip:AppConstants.noInfo,
                        description: filteredGameList.results[index].description!=null? filteredGameList.results[index].description:AppConstants.noInfo,
                        genres: filteredGameList.results[index].genres!=null? filteredGameList.results[index].genres:AppConstants.noInfo,
                        platforms: filteredGameList.results[index].platforms!=null?filteredGameList.results[index].platforms:AppConstants.noInfo,
                        rating: filteredGameList.results[index].rating!=null? filteredGameList.results[index].rating:AppConstants.noInfo,
                        website: filteredGameList.results[index].website!=null?filteredGameList.results[index].website:AppConstants.noInfo,
                        released: filteredGameList.results[index].released!=null? filteredGameList.results[index].released:AppConstants.noInfo,
                        stores:  filteredGameList.results[index].stores!="Null"? filteredGameList.results[index].stores:AppConstants.noInfo,
                      );
                      Navigator.pushNamed(context, GameDetails.routeName,arguments: filteredGameListArguments);
                      //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                      filteredGameList.results[index].clip == null
//                          ? Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) =>
//                              GameDetailsStates(
//                                gameId: filteredGameList.results[index].id,
//                                screenShots:
//                                filteredGameList.results[index].short_screenshots,
//                                gameName: filteredGameList.results[index].name,
//                                released: filteredGameList.results[index].released,
//                                rating: filteredGameList.results[index].rating,
//                                stores: filteredGameList.results[index].stores,
//                                clip: "no",
//                                genres: filteredGameList.results[index].genres,
//                                platforms: filteredGameList.results[index].platforms,
//                                flag: 1,
//                                website: filteredGameList.results[index].website,
//
//                              )))
//                          : Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) =>
//                              GameDetailsStates(
//                                clips:
//                                filteredGameList.results[index].clip.clips.full,
//                                gameId: filteredGameList.results[index].id,
//                                screenShots:
//                                filteredGameList.results[index].short_screenshots,
//                                gameName: filteredGameList.results[index].name,
//                                released: filteredGameList.results[index].released,
//                                rating: filteredGameList.results[index].rating,
//                                stores: filteredGameList.results[index].stores,
//                                clip: filteredGameList.results[index].clip.clip,
//                                genres: filteredGameList.results[index].genres,
//                                platforms: filteredGameList.results[index].platforms,
//                                flag: 1,
//                                website: filteredGameList.results[index].website,
//
//                              )));
                    },
                    child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: filteredGameList.results.length,
                        child: ScaleAnimation(
                            child: FadeInAnimation(

                              child: Container(

                                  padding: EdgeInsets.only(
                                      left: 1 * SizeConfig.heightMultiplier,
                                      right: 1 * SizeConfig.heightMultiplier,
                                      bottom: 1 * SizeConfig.heightMultiplier),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      filteredGameList.results[index]
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
                                            .imageSizeMultiplier *
                                            20,
                                        width: SizeConfig
                                            .widthMultiplier *
                                            34,

                                        child:


                                        CachedNetworkImage(
                                          imageUrl: filteredGameList
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
                                          : Container(decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                        height: SizeConfig
                                            .imageSizeMultiplier *
                                            20,
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
                                              6.7,
                                          width: SizeConfig
                                              .widthMultiplier *
                                              34,
                                          padding: EdgeInsets.only(left: 1 *
                                              SizeConfig.heightMultiplier,
                                              top: 2),
                                          child: Text(
                                            filteredGameList.results[index].name,
                                            style: AppTheme.subTitleLights,
                                            textScaleFactor: 0.9,
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
            ));
      });
    }


    Widget footerWidget() {
      // pages.add(pageCount);
      print("wee" + pages.length.toString());
      return FractionallySizedBox(
          widthFactor: 1,
          child: Container(
              height: SizeConfig.heightMultiplier * 9.5,
              width: SizeConfig.widthMultiplier * 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
//        gridDelegate:
//        SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 20.0),
                shrinkWrap: true,

                itemCount: pages == null ? 0 : pages.length,
                itemBuilder: (context, index) {
                  print("index" + index.toString());
                  //   print("pageCount" +pages[pageCount].toString());

                  // index=1;

                  return Container(
//                  onTap: () {
//                    Navigator.of(context).pop();
//                  },
                    child: index != 0
                        ? new Container(


                      // (foo==1)?something1():(foo==2)? something2():(foo==3)? something3(): something4();
//(i == 1) ? 1 : (i == 2) ? 2 : 0
                        color: pageCount == index
                            ? Colors.red : Colors.black,
//                      color: pageNumber == index
//                          ? Colors.red
//                          : pageNumber == 1 ? Colors.red : Colors.black,
                        //  width: 5,
                        padding:
                        EdgeInsets.only(left: 2.0, right: 2.0, top: 0.2),
                        child: Card(
                          //   color: pageCount == index ? Colors.red : Colors.black,
                            elevation: 10.0,
                            child: Container(
                              //    height: SizeConfig.heightMultiplier*1,
                              width: SizeConfig.widthMultiplier * 14,
                              child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      // index==0?index++:index;
                                      filteredGameList.results.clear();


                                      pageCount = index;
                                    });
                                    print("Pressed" + index.toString());
                                    print("pressed index" +
                                        pages[index].toString());
                                  },
                                  color: Color.fromRGBO(32, 32, 32, 5),
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 5.0, top: 0.8),
                                  child: Text(
                                    '${index}',
                                    style: TextStyle(color: Colors.white),
                                  )),

////
                            )
                        )

                      //  subtitle: Text('${games.result[index].platformDetails[0].details.id}'),
                    )
                        : Container(),
                  );
                },
              )));
    }


//    restApiClient.showSearchedGames("a")
//        .then((GameList responses) {
//      gameListDetailsResponse = responses;
//      //gameListDetails=new List();
//      gameListDetails.add(gameListDetailsResponse);
//      //    gameListDetailsResponse=responses;
//      //
//      //   gameListDetails=new List();
////
//      //   gameListDetails.addAll(responses.results);
//      print("inside widget" + gameListDetailsResponse.count.toString());
//    });
//    //  print("url"+widget.clip);
//    print("image" + pageCount.toString());
//    print("selectedPlatformId id" +platformSelectedValue.toString());
//    print("selectedPlatformId id" +ordering.toString());
    print(
        "gameListDetailsResponse lenght" + gameListDetailsResponse.toString());

    print("width" + SizeConfig.widthMultiplier.toString());
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return
            Scaffold(

                body: DefaultTabController(
                    length: 4,

                    child:
                    Scaffold(
                        backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                        bottomNavigationBar:
                         FutureBuilder(
                                future: selectedPlatformId!=null?
                                restApiClient
                                    .showListOfGames(
                                    "techigirl.gamers_planet/1", pageCount,
                                    ordering, selectedPlatformId)
                                    .then((GameList responses) {

                                  int pageCounts =
                                  (responses.count / responses.results.length)
                                      .floor();
                                  // print("printcode" + pageCount.toString());
                                  pages = new List();
                                  //  print("editingController pages" + pages.length.toString());

                                  for (int i = 1; i < pageCounts; i++) {
                                    //  print("pp"+pg.floor().toString());
                                    pages.add(i);
                                    //  i == pageCount ? pages.add(pageCount) : i;
                                    //  print("PGE COUNt" + pages.length.toString());

                                  }
                                }):

          restApiClient
              .showListOfGames(
          "techigirl.gamers_planet/1", pageCount,
          ordering, 4)
              .then((GameList responses) {

          int pageCounts =
          (responses.count / responses.results.length)
              .floor();
          // print("printcode" + pageCount.toString());
          pages = new List();
          //  print("editingController pages" + pages.length.toString());

          for (int i = 1; i < pageCounts; i++) {
          //  print("pp"+pg.floor().toString());
          pages.add(i);
          //  i == pageCount ? pages.add(pageCount) : i;
          //  print("PGE COUNt" + pages.length.toString());

          }
          })

                             ,

                                builder:
                                    (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return

                                    footerWidget();

//                            ],);
                                }),


//      drawer: Drawer(),
//      backgroundColor: Colors.orangeAccent,
//      appBar: AppBar(
//        title: Text('Bee Video'),
//        backgroundColor: Colors.black87,
//      ),
                        // Use a FutureBuilder to display a loading spinner while waiting for the
                        // VideoPlayerController to finish initializing.
                        body:

//
//
                        CustomScrollView(slivers: <Widget>[
//        SliverAppBar(
//        pinned: true,
//        expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//      ),
                          SliverList(
                            delegate: SliverChildListDelegate([

//                Stack(
//                  //mainAxisSize: MainAxisSize.max,
//
//
//
//                children: <Widget>[

                              Container(

                                  padding: EdgeInsets.only(
                                      top: SizeConfig.heightMultiplier + 10),
                                  width: SizeConfig.widthMultiplier * 100,
                                  height: SizeConfig.heightMultiplier * 12,
                                  child: Card(
                                      color: Color.fromRGBO(21, 21, 21, 2),
                                      elevation: 6,

                                      child:

                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[

                                          Container(
                                              width: SizeConfig
                                                  .widthMultiplier * 10,

                                              child: GestureDetector(
                                                child: Row(children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Icon(

                                                      Icons.arrow_back_ios,
                                                      color: Colors.white,

                                                      size: 6 * SizeConfig
                                                          .imageSizeMultiplier,
                                                    ),
                                                  )
                                                ],),
          onTap: () {
          Navigator.pushNamed(
          context,
          GameNewsDashboard.routeName);
                                                },
                                              )),
                                          Container(
                                              width: SizeConfig
                                                  .widthMultiplier * 80,

                                              alignment: Alignment.center,
                                              child:
                                              Text("All Games",
                                                style: AppTheme.mainTitles,
                                                textScaleFactor: 1.2,)),


                                        ],))),


                              //  Column(children: <Widget>[


                              Stack(children: <Widget>[



//
//                        Stack(children: <Widget>[
//
                                Container(
                                    width: SizeConfig.widthMultiplier * 100,
                                    // padding: EdgeInsets.only(top:10),
                                    height: SizeConfig.heightMultiplier * 24,
                                    decoration: BoxDecoration(
                                      //  color: Colors.red,
                                        borderRadius:
                                        BorderRadius
                                            .all(Radius
                                            .circular(
                                            1)),
                                        border: Border.all(color:
                                        Colors.white30)
                                    ),
                                    child:
                                    Column(children: <Widget>[
                                      Container(
                                          width: SizeConfig.widthMultiplier *
                                              100,
                                          height: SizeConfig.heightMultiplier *
                                              12,
                                          padding: EdgeInsets.only(left: 10),

                                          //      width: SizeConfig.widthMultiplier*55,
                                          child: Row(children: <Widget>[
                                            Container(width: SizeConfig
                                                .widthMultiplier * 30,
                                              child: Text("Select Platform",
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.2,),

                                            ),
                                            Container(width: SizeConfig
                                                .widthMultiplier * 60,

                                              child: FutureBuilder(
                                                  future: restApiClient
                                                      .showPlatformList("com.gamersgram/1",
                                                      pageCount)
                                                      .then((
                                                      PlatformList responses) {
                                                    platformListFilter =
                                                    new List();
                                                    platformListFilter.addAll(
                                                        responses.results);
                                                    print("Platform list" +
                                                        platformListFilter
                                                            .length.toString());
                                                  }),
                                                  builder:
                                                      (BuildContext context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData ==
                                                        null) {
                                                      return Container(
                                                          height: SizeConfig
                                                              .widthMultiplier *
                                                              2,
                                                          child: FlareActor(
                                                              'assets/loader.flr',
                                                              alignment: Alignment
                                                                  .center,
                                                              fit: BoxFit
                                                                  .contain,
                                                              animation: "loader"


                                                          ));
                                                    }
                                                    return gamePlatformWidget();
                                                  }),
                                            )

                                          ],)


                                      ),
                                      Container(
                                          width: SizeConfig.widthMultiplier *
                                              100,
                                          height: SizeConfig.heightMultiplier *
                                              11,
                                          padding: EdgeInsets.only(left: 10),

                                          //      width: SizeConfig.widthMultiplier*55,
                                          child: Row(children: <Widget>[
                                            Container(width: SizeConfig
                                                .widthMultiplier * 30,
                                              child: Text("Order by",
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.2,),

                                            ),
                                            Container(
                                              width: SizeConfig
                                                  .widthMultiplier * 45,

                                              //  width: SizeConfig.widthMultiplier*50,
                                              child: filtersWidget(),

                                            ),

                                          ])),


                                    ],)


                                ),


                                //  ],),


                              ],),


                              FutureBuilder(
                                  future: selectedPlatformId ==null
                                      ? restApiClient
                                      .showListOfGames(
                                      "techigirl.gamers_planet/1", pageCount,
                                      ordering, 4)
                                      .then((GameList responses) {
                                    filteredGameList = responses;
                                    ;
                                  })
                                      : restApiClient.showListOfGames(
                                      "techigirl.gamers_planet/1", 1, ordering,
                                      selectedPlatformId).then((
                                      GameList responses) {
                                    //publisherDetailsResultAc=new List();

                                    //    _platformListDetails=responses.results[0];
                                    // publisherDetailsResultAc.addAll(responses.results);
                                    //print("count" +platformListDetails.length.toString());
                                    filteredGameList = responses;


                                    //  }

                                    //    print("I"  +responses.results.length.toString());

//                "DDDDDD" + responses.results.length.toString());
                                  }),
                                  builder:
                                      (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (filteredGameList == null) {
                                      print("object");
                                      return Container(
                                          height: SizeConfig.heightMultiplier *
                                              20,
                                          child: FlareActor('assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ));
                                    }


                                    return Column(
//              scrollDirection: Axis.vertical,
//
//              shrinkWrap: true,
                                      //   padding: EdgeInsets.all(5),

                                      children: <Widget>[


                                        allGamesListWidget(),

                                      ],);
                                  }),
                              //)),


                              // Divider(color: Colors.red,thickness: 2.0,),


//                    ],
//                  ),

                            ]),
                          )
                        ],
                          // ),


                        )

                      )


                    ));
        },
      );
    });
  }
}
