import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/stores/ui/StoresHomePage.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

List<GameStores> storeDetailsList;
var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
int storeId;

int pageCount = 1;
int count;
List<int> pages = new List();
String storeName;
int pageDirection;
YoutubeArguments storeDetailsArguments;

class StoreDetails extends StatelessWidget {
  static const String routeName="/StoreDetailsState";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreDetailsState(
      storeDetailsArguments: storeDetailsArguments,

      ),
    );
  }
}

class StoreDetailsState extends StatefulWidget {
  static Map event;

  StoreDetailsState(
      {Key key, @required this.storeDetailsArguments})
      : super(key: key);

  final YoutubeArguments storeDetailsArguments;


  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}

class _CreatorDetailsState extends State<StoreDetailsState> {
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }


//  @override
//  void dispose() {
//    // Ensure disposing of the VideoPlayerController to free up resources.
//    //  _controller.dispose();
////    // pageCount=0;
////     pages.clear();
//    storeGameList.results.clear();
//    pageCount = 1;
//
//    super.dispose();
//  }

  GameStoreDetails gameStoreDetails;


  @override
  Widget build(BuildContext context) {
    //  print("url"+widget.clip);

    GameList storeGameList;
    Widget storeWiseGamesWidget() {
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
              ? SizeConfig.heightMultiplier * 46
              : SizeConfig.heightMultiplier * 36,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            //  physics: const ScrollPhysics(),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: storeGameList == null ? 0 : storeGameList.results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                    YoutubeArguments storeGameListArguments = new YoutubeArguments(
                      flag: 5,

                      gameName:storeGameList.results[index].name!=null? storeGameList.results[index].name:AppConstants.noInfo
                      ,gameId: storeGameList.results[index].id!=null?storeGameList.results[index].id:AppConstants.noInfo,

                      screenShots: storeGameList.results[index].short_screenshots!=null?
                      storeGameList.results[index].short_screenshots:AppConstants.noInfo,
                    //  clip:storeGameList.results[index].clip.clip!=null?storeGameList.results[index].clip.clip:AppConstants.noInfo,
                      description: storeGameList.results[index].description!=null? storeGameList.results[index].description:AppConstants.noInfo,
                      genres: storeGameList.results[index].genres!=null? storeGameList.results[index].genres:AppConstants.noInfo,
                      platforms: storeGameList.results[index].platforms!=null?storeGameList.results[index].platforms:AppConstants.noInfo,
                      rating: storeGameList.results[index].rating!=null? storeGameList.results[index].rating:AppConstants.noInfo,
                      website: storeGameList.results[index].website!=null?storeGameList.results[index].website:AppConstants.noInfo,
                      released: storeGameList.results[index].released!=null? storeGameList.results[index].released:AppConstants.noInfo,
                      stores:  storeGameList.results[index].stores!="Null"? storeGameList.results[index].stores:AppConstants.noInfo,
                    );
                    Navigator.pushNamed(context, GameDetails.routeName,arguments: storeGameListArguments);
//                  storeGameList.results[index].clip == null
//                      ? Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) =>
//                          GameDetailsStates(
//                            gameId: storeGameList.results[index].id,
//                            screenShots: storeGameList
//                                .results[index].short_screenshots,
//                            gameName: storeGameList.results[index].name,
//                            released:
//                            storeGameList.results[index].released,
//                            rating: storeGameList.results[index].rating,
//                            stores: storeGameList.results[index].stores,
//                                clip: "no",
//                            genres: storeGameList.results[index].genres,
//                            platforms:
//                            storeGameList.results[index].platforms,
//                                flag: 1,
//                            website: storeGameList.results[index].website,
//                              )))
//                      : Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) =>
//                          GameDetailsStates(
//                            gameId: storeGameList.results[index].id,
//                            screenShots: storeGameList
//                                .results[index].short_screenshots,
//                            gameName: storeGameList.results[index].name,
//                            released:
//                            storeGameList.results[index].released,
//                            rating: storeGameList.results[index].rating,
//                            stores: storeGameList.results[index].stores,
//                            clip: storeGameList.results[index].clip.clip,
//                            genres: storeGameList.results[index].genres,
//                            platforms:
//                            storeGameList.results[index].platforms,
//                                flag: 1,
//                            description:
//                            storeGameList.results[index].description,
//                           website: storeGameList.results[index].website,
//                           // systemRequirement: storeGameList
//                                //.results[index].platforms[index].requirements,
//                              )));
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: storeGameList.results.length,
                      child: ScaleAnimation(
                          child: FadeInAnimation(
//
                            child: Container(

                                padding: EdgeInsets.only(
                                    left: 1 * SizeConfig.heightMultiplier,
                                    right: 1 * SizeConfig.heightMultiplier,
                                    bottom: 1 * SizeConfig.heightMultiplier),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    storeGameList.results[index]
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
                                        imageUrl: storeGameList
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
                                            6.8,
                                        width: SizeConfig
                                            .widthMultiplier *
                                            34,
                                        padding: EdgeInsets.only(
                                            left: 1 * SizeConfig.heightMultiplier,
                                            top: 2),
                                        child: Text(
                                          storeGameList.results[index].name,
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
                  //     print("index" +index.toString());
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

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
                backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                   bottomNavigationBar:     FutureBuilder(
                       future: restApiClient
                           .showListOfGamesByStores("com.gamersgram/1",
                           pageCount,  widget.storeDetailsArguments.gameId)
                           .then((GameList responses) {
                         //  publisherListLv = responses;
                         //  print("PAGE COUNT IN PUBLISHER" + publisherListLv.count.toString());
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
                       }

                       ),
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
                body: CustomScrollView(slivers: <Widget>[
//        SliverAppBar(
//        pinned: true,
//        expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//      ),
                  SliverList(
                      delegate: SliverChildListDelegate([

                        Container(

                            padding: EdgeInsets.only(
                                top: SizeConfig.heightMultiplier + 10),
                            width: SizeConfig.widthMultiplier * 100,
                            height: SizeConfig.heightMultiplier * 10,
                            child: Card(
                                color: Color.fromRGBO(21, 21, 21, 2),
                                elevation: 6,

                                child:

                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                        width: SizeConfig.widthMultiplier * 10,

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
                                            YoutubeArguments storeDetailsArguments=new YoutubeArguments(gameId: widget.storeDetailsArguments.gameId,
                                            gameName: widget.storeDetailsArguments.gameName,flag: 2);
                                            widget.storeDetailsArguments.flag == 2
                                                ?

                                            Navigator.pushNamed(context,

                                                 StoresHomePage.routeName,arguments: storeDetailsArguments)
                                                  : Navigator.pushNamed(context,

                                            '/');
                                          },
                                        )),
                                    Container(
                                        width: SizeConfig.widthMultiplier * 80,

                                        alignment: Alignment.center,
                                        child:
                                        Text(widget.storeDetailsArguments.gameName,
                                          style: AppTheme.mainTitles,
                                          textScaleFactor: 1.2,)),


                                  ],))),


                        Container(

                            padding: EdgeInsets.only(top: 5),
                            height: SizeConfig.heightMultiplier * 35,
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
                            child: Container(

                              // color: Colors.yellowAccent,

                              // height: SizeConfig.heightMultiplier * 10,
                                child:

                                Column(
                                    children: <Widget>[


                                      FutureBuilder(
                                          future: restApiClient
                                              .showGameStoreDetails("com.gamersgram/1",
                                              widget.storeDetailsArguments.gameId)
                                              .then((
                                              GameStoreDetails responses) {
                                            gameStoreDetails = responses;
                                            print("GEMER NAME" +
                                                gameStoreDetails.name);
                                          }),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            return gameStoreDetails != null
                                                ? Column(
                                              children: <Widget>[
                                                gameStoreDetails != null
                                                    ? Container(
                                                    height: SizeConfig
                                                        .heightMultiplier *
                                                        28,


//                                                height: SizeConfig
//                                                        .heightMultiplier *
//                                                    15,

                                                    child:
                                                   gameStoreDetails.description.isNotEmpty? SingleChildScrollView(
                                                      scrollDirection:
                                                      Axis.vertical,

                                                      child: Text(
                                                        html2md.convert(
                                                            gameStoreDetails
                                                                .description),
                                                        style: AppTheme
                                                            .subTitleLights,
                                                        textScaleFactor:
                                                        1.1,
                                                        softWrap: true,
                                                      ),

                                                      padding: EdgeInsets
                                                          .only(left: SizeConfig
                                                          .heightMultiplier +
                                                          5, right: SizeConfig
                                                          .heightMultiplier +
                                                          5),
//
                                                    ):   Center(child:(Text("No info available :(",
                                                     style: AppTheme.subTitleLights,textScaleFactor: 1.2,))),


                                                )

                                                // style: AppTheme.subText,

                                                    : Container(),

                                                Text(
                                                  gameStoreDetails
                                                      .domain,
                                                  style: AppTheme
                                                      .subTitleLights,
                                                  textScaleFactor:
                                                  1.1,
                                                  softWrap: true,
                                                ),


                                              ],
                                            )
                                                : Container(height: SizeConfig
                                                .heightMultiplier * 10,
                                                child: FlareActor(
                                                    'assets/loader.flr',
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.contain,
                                                    animation: "loader"


                                                ));
                                          })
                                    ]))),


                        Column(children: <Widget>[
                          Container(
                              height: SizeConfig.heightMultiplier * 7,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(
                                  SizeConfig.heightMultiplier + 5),
                              child: Text(widget.storeDetailsArguments.gameName +
                                  " wise game list",
                                softWrap: true,
                                style: AppTheme.subTitleLights,
                                textScaleFactor: 1.3,

                              )),
                          FutureBuilder(
                              future: pageCount != 1
                                  ? restApiClient
                                  .showListOfGamesByStores("com.gamersgram/1",
                                  pageCount,  widget.storeDetailsArguments.gameId)
                                  .then((GameList responses) {
                                storeGameList = responses;
                              })
                                  : restApiClient
                                  .showListOfGamesByStores("com.gamersgram/1",
                                  pageCount,  widget.storeDetailsArguments.gameId)
                                  .then((GameList responses) {
                                storeGameList = responses;
                                int pageCounts =
                                (responses.count / responses.results.length)
                                    .floor();
                                // print("printcode" + pageCount.toString());
                                pages = new List();

                                for (int i = 1; i < pageCounts; i++) {
                                  //  print("pp"+pg.floor().toString());
                                  pages.add(i);
                                }
                              }),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (storeGameList == null) {
                                  return Container(
                                      height: SizeConfig.heightMultiplier * 10,

                                      child: Center(
                                          child: FlareActor('assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          )));
                                }
                                return Column(
//              scrollDirection: Axis.vertical,
//
//              shrinkWrap: true,
                                  //   padding: EdgeInsets.all(5),

                                  children: <Widget>[


                                    storeWiseGamesWidget(),
//                                    pages.length != 0
//                                        ? footerWidget()
//                                        : Container(),

                                  ],);
                              }),


                        ],),


//                ],),)

                        //  filtersWidget(),

//                    ],
//                  )
//

                        // ),
                      ]))
                ])
            );
            // ]));
          });
    });
  }
}
