import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flare_flutter/flare_actor.dart';

import 'package:cached_network_image/cached_network_image.dart';
List<GameStores> storeDetailsList;
var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
int publisherId;

String publisherName;
int pageDirection;
YoutubeArguments publisherDetailsArguments;

class PublisherDetails extends StatelessWidget {
  static const routeName="/PublisherDetails";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PublisherDetailsState(
        publisherDetailsArguments: publisherDetailsArguments,
//        publisherId: publisherId,
//        publisherName: publisherName,
//        pageDirection: pageDirection,
      ),
    );
  }
}

class PublisherDetailsState extends StatefulWidget {
  static Map event;

  PublisherDetailsState(
      {Key key, @required this.publisherDetailsArguments})
      : super(key: key);

//  final int publisherId;
//  final String publisherName;
//  final int pageDirection;
  final YoutubeArguments publisherDetailsArguments;

  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}

class _CreatorDetailsState extends State<PublisherDetailsState> {
  Future<void> _initializeVideoPlayerFuture;

  int pageCount = 1;
  int count;
  List<int> pages = new List();
  @override
  void initState() {
    super.initState();
  }

//
//  @override
//  void dispose() {
//    // Ensure disposing of the VideoPlayerController to free up resources.
//    //  _controller.dispose();
////    // pageCount=0;
////     pages.clear();
//    publisherGameList.results.clear();
//    pageCount = 1;
//    gamePublisherDetails.description = null;
//    super.dispose();
//  }
  GamePublisherDetails gamePublisherDetails;


  @override
  Widget build(BuildContext context) {
 //   print("url" + widget.pageDirection.toString());

    GameList publisherGameList;
    Widget publisherWiseGamesWidget() {
      return Container(
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
              ? SizeConfig.heightMultiplier * 52
              : SizeConfig.heightMultiplier * 42,
          //width: SizeConfig.widthMultiplier * 97,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            //  physics: const ScrollPhysics(),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: publisherGameList == null ? 0 : publisherGameList.results
                .length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                    YoutubeArguments publisherGameListArguments = new YoutubeArguments(

                      flag: 2,
                      gameName:publisherGameList.results[index].name!=null? publisherGameList.results[index].name:AppConstants.noInfo
                      ,gameId: publisherGameList.results[index].id!=null?publisherGameList.results[index].id:AppConstants.noInfo,

                      screenShots: publisherGameList.results[index].short_screenshots!=null?
                      publisherGameList.results[index].short_screenshots:AppConstants.noInfo,
                    //  clip:publisherGameList.results[index].clip.clip!=null?publisherGameList.results[index].clip.clip:AppConstants.noInfo,
                      description: publisherGameList.results[index].description!=null? publisherGameList.results[index].description:AppConstants.noInfo,
                      genres: publisherGameList.results[index].genres!=null? publisherGameList.results[index].genres:AppConstants.noInfo,
                      platforms: publisherGameList.results[index].platforms!="Null"?publisherGameList.results[index].platforms:AppConstants.noInfo,
                      rating: publisherGameList.results[index].rating!=null? publisherGameList.results[index].rating:AppConstants.noInfo,
                      website: publisherGameList.results[index].website!=null?publisherGameList.results[index].website:AppConstants.noInfo,
                      released: publisherGameList.results[index].released!=null? publisherGameList.results[index].released:AppConstants.noInfo,
                   //   stores: publisherGameList.results[index].stores!=null?publisherGameList.results[index].stores:AppConstants.noInfo,
                      stores:  publisherGameList.results[index].stores!="Null"? publisherGameList.results[index].stores:AppConstants.noInfo,

                    );
                    Navigator.pushNamed(context, GameDetails.routeName,arguments: publisherGameListArguments);

//                    publisherGameList.results[index].clip == null
//                        ? Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: publisherGameList.results[index].id,
//                              screenShots: publisherGameList
//                                  .results[index].short_screenshots,
//                              gameName: publisherGameList.results[index].name,
//                              released:
//                              publisherGameList.results[index].released,
//                              rating: publisherGameList.results[index].rating,
//                              stores: publisherGameList.results[index].stores,
//                              clip: "no",
//                              genres: publisherGameList.results[index].genres,
//                              platforms:
//                              publisherGameList.results[index].platforms,
//                              flag: 1,
//                            )))
//                        : Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: publisherGameList.results[index].id,
//                              screenShots: publisherGameList
//                                  .results[index].short_screenshots,
//                              gameName: publisherGameList.results[index].name,
//                              released:
//                              publisherGameList.results[index].released,
//                              rating: publisherGameList.results[index].rating,
//                              stores: publisherGameList.results[index].stores,
//                              clip: publisherGameList.results[index].clip.clip,
//                              genres: publisherGameList.results[index].genres,
//                              platforms:
//                              publisherGameList.results[index].platforms,
//                              flag: 1,
//                              description:
//                              publisherGameList.results[index].description,
////                              systemRequirement: publisherGameList
////                                  .results[index].platforms[index].requirements,
//                            )));
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: publisherGameList.results.length,
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
                                    right: 1 * SizeConfig.heightMultiplier,
                                    bottom: 1 * SizeConfig.heightMultiplier),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    publisherGameList.results[index]
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
                                        imageUrl: publisherGameList
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
                                            left: 1 *
                                                SizeConfig.heightMultiplier,
                                            top: 2),
                                        child: Text(
                                          publisherGameList.results[index].name,
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
             bottomNavigationBar:  FutureBuilder(
                 future: restApiClient
                     .showListOfGamesByPublishers("com.gamersgram/1",
                     pageCount, widget.publisherDetailsArguments.gameId)
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

                     pages.length != 0 ? footerWidget() : Container(height: 0,);

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
//          backgroundColor: Colors.black,
//        pinned: true,
//        expandedHeight:SizeConfig.heightMultiplier+30,
//actions: <Widget>[],
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
                                      width: SizeConfig.widthMultiplier * 12,

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
                                          YoutubeArguments publisherDetailsArguments=new YoutubeArguments(gameId: widget.publisherDetailsArguments.gameId,
                                          gameName: widget.publisherDetailsArguments.gameName,flag: 2);
                                          widget.publisherDetailsArguments.flag == 2
                                              ?


                                          Navigator.pushNamed(context, PublisherHomePage.routeName,arguments: publisherDetailsArguments)


//                                          Navigator.push(context,
//
//                                              PageTransition(type:
//                                              PageTransitionType.leftToRight,
//                                                  child: PublisherHomePage()))
                                              :  Navigator.pushNamed(
                                              context,
                                              "/");
                                        },
                                      )),
                                  Container(
                                      width: SizeConfig.widthMultiplier * 80,

                                      alignment: Alignment.center,
                                      child:
                                      Text(widget.publisherDetailsArguments.gameName,
                                        style: AppTheme.mainTitles,
                                        textScaleFactor: 1.3,)),


                                ],))),


                      Container(

                          padding: EdgeInsets.only(top: 5),
                          height: SizeConfig.heightMultiplier * 30,
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
                                            .showGamePublishersDetails("com.gamersgram/1",
                                            widget.publisherDetailsArguments.gameId)
                                            .then((
                                            GamePublisherDetails responses) {
                                          gamePublisherDetails = responses;
                                          print("GEMER NAME" +
                                              gamePublisherDetails.name);
                                        }),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          return

//                                            gamePublisherDetails != null
//                                              ?

                                          Column(
                                            children: <Widget>[
                                              gamePublisherDetails!= null
                                                  ? Container(
                                                  height: SizeConfig
                                                      .heightMultiplier *
                                                      28,


//                                                height: SizeConfig
//                                                        .heightMultiplier *
//                                                    15,

                                                  child:
                                                 gamePublisherDetails.description.isNotEmpty? SingleChildScrollView(
                                                    scrollDirection:
                                                    Axis.vertical,
                                                    //reverse: true,

                                                    child: Text(
                                                      html2md.convert(
                                                          gamePublisherDetails
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
                                                  ):
                                          Center(child:(Text("No info available :(",
                                          style: AppTheme.subTitleLights,textScaleFactor: 1.2,))),


                                          // style: AppTheme.subText,

                                              ) : Container(height: SizeConfig
                                                  .heightMultiplier * 10,
                                                  child: FlareActor(
                                                      'assets/loader.flr',
                                                      alignment: Alignment
                                                          .center,
                                                      fit: BoxFit.contain,
                                                      animation: "loader"


                                                  )),


                                            ],
                                          );
//                                              : Container(height: SizeConfig
//                                              .heightMultiplier * 10,
//                                              child: FlareActor(
//                                                  'assets/loader.flr',
//                                                  alignment: Alignment.center,
//                                                  fit: BoxFit.contain,
//                                                  animation: "loader"
//
//
//                                              ));
                                        })
                                  ]))),

                      Container(
                          height: SizeConfig.heightMultiplier * 7,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              SizeConfig.heightMultiplier + 5),
                          child: Text(widget.publisherDetailsArguments.gameName +
                              " game list",
                            softWrap: true,
                            style: AppTheme.subTitleLights,
                            textScaleFactor: 1.3,

                          )),

//                      Container(
//                        height: SizeConfig.heightMultiplier*41,
//                child: Column(children: <Widget>[
//
//
//
//
//                  Container(
//                    height: SizeConfig.heightMultiplier*40,
//                    color: Colors.green,

                      FutureBuilder(
                          future: pageCount != 1
                              ? restApiClient
                              .showListOfGamesByPublishers("com.gamersgram/1",
                              pageCount, widget.publisherDetailsArguments.gameId)
                              .then((GameList responses) {
                            publisherGameList = responses;
                          })
                              : restApiClient
                              .showListOfGamesByPublishers("com.gamersgram/1",
                              1, widget.publisherDetailsArguments.gameId)
                              .then((GameList responses) {
                            publisherGameList = responses;

                            print("INSIDE GAME API" +
                                publisherGameList.results.length.toString());
                            int pageCounts =
                            (responses.count / responses.results.length)
                                .floor();
                            // print("printcode" + pageCount.toString());
                            pages = new List();

                            for (int i = 1; i < pageCounts; i++) {
                              //  print("pp"+pg.floor().toString());
                              pages.add(i);
                            }
                          }

                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            if (publisherGameList == null) {
                              return

                                Container(
                                    height: SizeConfig.heightMultiplier * 15,

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


                                publisherWiseGamesWidget(),
//                                pages.length != 0
//                                    ? footerWidget()
//                                    : Container(),

                              ],);
                          }),


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
