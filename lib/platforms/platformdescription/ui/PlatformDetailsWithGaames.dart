import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/platforms/ui/PlatformHomePage.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/footerwidget.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

int flag;

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
String ordering = "-added";
String platformName;
int pageDirection;
 YoutubeArguments platformDetailsArguments;

class PlatformDetailsWithGames extends StatelessWidget {

  static const routeName="/PlatformDetailsWithGames";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformDetailsStates(

        platformDetailsArguments: platformDetailsArguments,

      ),
    );
  }
}

List<String> filterStringList = new List();


// ignore: must_be_immutable
class PlatformDetailsStates extends StatefulWidget {
  static Map event;

  PlatformDetailsStates(
      {Key key, @required this.platformDetailsArguments})
      : super(key: key);

  //final String clip;
//  final int platformId;
//  final int pageDirection;
//
//  final String platformName;
  final YoutubeArguments platformDetailsArguments;
  bool isExpanded = false;

  @override
  _PlatformDetailsStatesState createState() => _PlatformDetailsStatesState();
}

class _PlatformDetailsStatesState extends State<PlatformDetailsStates>
    with TickerProviderStateMixin<PlatformDetailsStates> {
  @override
  void initState() {
    filterStringList.add("Name");
    filterStringList.add("Popular");
    filterStringList.add("Ratingwise");
//   if(widget.flag!=1 && widget.clip!=null)
    // print(widget.clip);

//if(widget.flag==1)
//  {
//        _controller = VideoPlayerController.network(
//      "",
//    );
//  }
//else
//  {
//        _controller = VideoPlayerController.network(
//      widget.clip,
//    );
//  }

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    //  _controller.dispose();
//    // pageCount=0;
//     pages.clear();

    super.dispose();
  }
  var currentSelectedValue;
  PlatformDescription platformsDescription;
  int pageCount = 1;
  int count;
//String tagName;
  List<int> pages = new List();
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


  var _SelectdType = "Name";

  Widget filtersWidget() {
    return new Row(children: <Widget>[
      new Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
//          elevation: 11,
//          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.elliptical(90, 90))),

        // padding: new EdgeInsets.all(16.0),

        child: DropdownButtonHideUnderline(
          child: new DropdownButton<String>(
            style:
                TextStyle(color: Colors.white, decorationColor: Colors.white),

            items: filterStringList.map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: new Container(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  color: Colors.white,
                  child: Text(
                    val,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }).toList(),
            // hint:Text("Sort By"),
            hint: Text(_SelectdType),
            value: currentSelectedValue,

            isDense: true,
            onChanged: (newValue) {
              setState(() {
                currentSelectedValue = newValue;
              });
              if (currentSelectedValue == "Name") {
                ordering = "-name";
              } else if (currentSelectedValue == 'Ratingwise') {
                ordering = "-rating";
              } else if (currentSelectedValue == "Popular") {
                ordering = "-added";
              }
              print(currentSelectedValue);
            },
          ),
        ),
      )
    ]);
  }

//  GameList gameList;

  /*
   platformWiseGamesWidget games
     */



//  onBackPress() {
//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(
//            builder: (context) => platformWiseGamesWidget()
//        ),
//        ModalRoute.withName("/HomepageState")
//    );
//
//    platformwiseGameList.results.clear();
//
//  }

//  Widget gamePlatformWidget() {
//    return Container(
//        padding: EdgeInsets.all(8),
//        alignment: Alignment.topLeft,
//
//        child:
//
//
//
//
//        Column(children: <Widget>[
//
//
//
//          Directionality(
//              textDirection: TextDirection.ltr,
//              child: new Container(
//                  height: 40.0,
//                  child: ListView.builder(
//                      scrollDirection: Axis.vertical,
//                      shrinkWrap: true,
//                      itemCount:
//                      platformsDescription== null ? 0 : platformsDescription.description,
//                      itemBuilder: (context, index) {
//                        return AnimationConfiguration.staggeredList(
//                            position: index,
//                            duration: const Duration(milliseconds: 375),
//                            //columnCount:  widget.platforms.length,
//                            child: ScaleAnimation(
//                                child: FadeInAnimation(
//                                    child:
//                                    Container(
////                                      height: 50,
////                                      width: 100,
////                              height: animation.value,
////                              width: animation.value,
//
//                                      padding: EdgeInsets.only(
//                                          left: 5.0, right: 5.0, top: 0.5),
//                                      child:Wrap(children: <Widget>[
//
//                                        Text(
//                                          platformsDescription
//                                             .name,
//                                          style: AppTheme.subText,
//
//                                        ),
//
//
//                                        Text(
//                                          platformsDescription
//                                              .description,
//                                          style: AppTheme.subTitleLight,
//
//                                        ),
//
//
//
//                                      ],),
//                                    ))));
//                      })))
//
//        ],));
//  }

  String strDescription;

  @override
  Widget build(BuildContext context) {

    GameList platformwiseGameList;

    Widget platformWiseGamesWidget() {
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
          height:
          pages.length == 0
              ? SizeConfig.heightMultiplier * 52
              :
          SizeConfig.heightMultiplier * 42,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            //  physics: const ScrollPhysics(),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: platformwiseGameList == null ? 0 : platformwiseGameList
                .results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                    YoutubeArguments  platformwiseGameListArguments = new YoutubeArguments(
                      flag: 4,

                      gameName:platformwiseGameList.results[index].name!=null? platformwiseGameList.results[index].name:AppConstants.noInfo
                      ,gameId: platformwiseGameList.results[index].id!=null?platformwiseGameList.results[index].id:AppConstants.noInfo,

                      screenShots: platformwiseGameList.results[index].short_screenshots!=null?
                      platformwiseGameList.results[index].short_screenshots:AppConstants.noInfo,
                      //clip:platformwiseGameList.results[index].clip.clip!=null?platformwiseGameList.results[index].clip.clip:AppConstants.noInfo,
                      description: platformwiseGameList.results[index].description!=null? platformwiseGameList.results[index].description:AppConstants.noInfo,
                      genres: platformwiseGameList.results[index].genres!=null? platformwiseGameList.results[index].genres:AppConstants.noInfo,
                      platforms: platformwiseGameList.results[index].platforms!=null?platformwiseGameList.results[index].platforms:AppConstants.noInfo,
                      rating: platformwiseGameList.results[index].rating!=null? platformwiseGameList.results[index].rating:AppConstants.noInfo,
                      website: platformwiseGameList.results[index].website!=null?platformwiseGameList.results[index].website:AppConstants.noInfo,
                      released: platformwiseGameList.results[index].released!=null? platformwiseGameList.results[index].released:AppConstants.noInfo,
                      stores:  platformwiseGameList.results[index].stores!="Null"? platformwiseGameList.results[index].stores:AppConstants.noInfo,
                    );
                    Navigator.pushNamed(context, "/GameDetailsStates",arguments: platformwiseGameListArguments);


//                  platformwiseGameList.results[index].clip == null
//                      ? Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) =>
//                          GameDetailsStates(
//                            gameId: platformwiseGameList.results[index].id,
//                            screenShots: platformwiseGameList
//                                .results[index].short_screenshots,
//                            gameName: platformwiseGameList.results[index].name,
//                            released:
//                            platformwiseGameList.results[index].released,
//                            rating: platformwiseGameList.results[index].rating,
//                            stores: platformwiseGameList.results[index].stores,
//                            clip: "no",
//                            genres: platformwiseGameList.results[index].genres,
//                            platforms:
//                            platformwiseGameList.results[index].platforms,
//                            flag: 1,
//                          )))
//                      : Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) =>
//                          GameDetailsStates(
//                            gameId: platformwiseGameList.results[index].id,
//                            screenShots: platformwiseGameList
//                                .results[index].short_screenshots,
//                            gameName: platformwiseGameList.results[index].name,
//                            released:
//                            platformwiseGameList.results[index].released,
//                            rating: platformwiseGameList.results[index].rating,
//                            stores: platformwiseGameList.results[index].stores,
//                            clip: platformwiseGameList.results[index].clip.clip,
//                            genres: platformwiseGameList.results[index].genres,
//                            platforms:
//                            platformwiseGameList.results[index].platforms,
//                            flag: 1,
//                            description:
//                            platformwiseGameList.results[index].description,
//                            systemRequirement: platformwiseGameList
//                                .results[index].platforms[index].requirements,
//                          )));
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: platformwiseGameList.results.length,
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
                                    platformwiseGameList.results[index]
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
                                        imageUrl: platformwiseGameList
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
                                          platformwiseGameList.results[index]
                                              .name,
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
    print(widget.platformDetailsArguments.gameId);

    //print("url" + strDescription);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return Scaffold(
            backgroundColor: Color.fromRGBO(21, 21, 21, 5),
            bottomNavigationBar:   FutureBuilder(
                future: restApiClient
                    .showPlatformWiseGamesWithFilter("com.gamersgram/1",
                     1, widget.platformDetailsArguments.gameId)
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

                    pages.length!=0 ? footerWidget() : Container(height: 0,);

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
 CustomScrollView(


                    slivers: <Widget>[

//        SliverAppBar(
//        pinned: true,
//        expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//      ),
//                    SliverAppBar(
//                      pinned: true,
//                      expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//                    ),
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
                                    width: SizeConfig.widthMultiplier * 10,

                                    child: GestureDetector(
                                      child: Row(children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Icon(

                                            Icons.arrow_back_ios,
                                            color: Colors.white,

                                            size: 6 *
                                                SizeConfig.imageSizeMultiplier,
                                          ),
                                        )
                                      ],),
                                      onTap: () {
                                        widget.platformDetailsArguments.flag == 2
                                            ?

                                        Navigator.pushNamed(context, PlatformHomePage.routeName)
                                            : Navigator.pushNamed(context,

                                           '/');
                                      },
                                    )),
                                Container(
                                    width: SizeConfig.widthMultiplier * 80,

                                    alignment: Alignment.center,
                                    child:
                                    Text(widget.platformDetailsArguments.gameName,
                                      style: AppTheme.mainTitles,
                                      textScaleFactor: 1.2,)),


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
                            .showPlatformDetails("com.gamersgram/1",
                            widget.platformDetailsArguments.gameId.toString())
                            .then((PlatformDescription responses) {
                          platformsDescription = responses;
                        }),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          return Column(
                            children: <Widget>[
                              platformsDescription != null
                                  ? Container(
                                  height: SizeConfig
                                      .heightMultiplier *
                                      28,


//                                                height: SizeConfig
//                                                        .heightMultiplier *
//                                                    15,

                                  child:platformsDescription.description.isNotEmpty ?
                                  SingleChildScrollView(
                                    scrollDirection:
                                    Axis.vertical,

                                    child: Text(
                                      html2md.convert(
                                          platformsDescription
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


                        })
                                ]))),


                    Container(
                        height: SizeConfig.heightMultiplier * 7,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(
                            SizeConfig.heightMultiplier + 5),
                        child: Text(widget.platformDetailsArguments.gameName +
                            " game list",
                          softWrap: true,
                          style: AppTheme.subTitleLights, textScaleFactor: 1.3,

                        )),


                    FutureBuilder(
                        future: pageCount != 1
                            ? restApiClient
                            .showPlatformWiseGamesWithFilter("com.gamersgram/1",
                            pageCount, widget.platformDetailsArguments.gameId)
                            .then((GameList responses) {
                          platformwiseGameList = responses;
                        })
                            : restApiClient
                            .showPlatformWiseGamesWithFilter("com.gamersgram/1",
                            pageCount, widget.platformDetailsArguments.gameId)
                            .then((GameList responses) {
                          platformwiseGameList = responses;
                          int pageCounts =
                          (responses.count / responses.results.length).floor();
                          // print("printcode" + pageCount.toString());
                          pages = new List();

                          for (int i = 1; i < pageCounts; i++) {
                            //  print("pp"+pg.floor().toString());
                            pages.add(i);
                          }
                        }),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if (platformwiseGameList == null) {
                            return Container(
                                height: SizeConfig.heightMultiplier * 20,

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


                              platformWiseGamesWidget(),
                             // pages.length != 0 ? footerWidget() : Container(),

                            ],);
                        }),


//                ],),)

                    //  filtersWidget(),

//                    ],
//                  )
//

                    // ),
                  ]))
                    ]));
        // ]));
      });
    });
  }
}
