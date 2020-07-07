import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

import 'package:flare_flutter/flare_actor.dart';

class MonthlyTrendingGames extends StatelessWidget {
  static const routeName="/MonthlyTrendingGames";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MonthlyTrendingGamesState(),
    );
  }
}

class MonthlyTrendingGamesState extends StatefulWidget {
  MonthlyTrendingGamesState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MonthlyTrendingGamesState createState() => _MonthlyTrendingGamesState();
}

int selectedIndex = 0;
int pageCount = 1;
int count;
List<int> pages = new List();

class _MonthlyTrendingGamesState extends State<MonthlyTrendingGamesState> {
  String currentYear = DateTime.now().year.toString();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }



  static DateTime now = DateTime.now();
  static int lastDay = DateTime(now.year, now.month + 1, 0).day;
  static int firstDay = DateTime(now.year, now.month, 0).day;

// static String startDate = AppConstants.changeDateFormat(
//   DateTime.now().month.toString(), ("yyyy-MM-dd"));
//
  static String endDate = AppConstants.changeDateFormat(
      DateTime(now.year, 12, 31).toString(), ("yyyy-MM-dd"));

  static String startDate = AppConstants.changeDateFormat(
      DateTime(now.year, 01, 01).toString(), ("yyyy-MM-dd"));

//
  // AppConstants.changeDateFormat(DateTime.now().toString(), ("yyyy-MM-dd"));

  String weekDates = startDate + "," + endDate;



  @override
  Widget build(BuildContext context) {
    GameList monthWiseGameList;
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
                        color: pageCount == index ? Colors.red : Colors.black,
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
                            ))

                      //  subtitle: Text('${games.result[index].platformDetails[0].details.id}'),
                    )
                        : Container(),
                  );
                },
              )));
    }

    Widget trendingGamesByMonth() {
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
                borderRadius: BorderRadius.all(Radius.circular(1)),
                border: Border.all(color: Colors.white30)),
            height: pages.length == 0
                ? SizeConfig.heightMultiplier * 89
                : SizeConfig.heightMultiplier * 79,
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: monthWiseGameList == null
                  ? 0
                  : monthWiseGameList.results.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    onTap: () {
                      /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                      YoutubeArguments monthWiseGameListArguments = new YoutubeArguments(
                        flag: 1,

                        gameName:monthWiseGameList.results[index].name!=null? monthWiseGameList.results[index].name:AppConstants.noInfo
                        ,gameId: monthWiseGameList.results[index].id!=null?monthWiseGameList.results[index].id:AppConstants.noInfo,

                        screenShots: monthWiseGameList.results[index].short_screenshots!=null?
                        monthWiseGameList.results[index].short_screenshots:AppConstants.noInfo,
                        //clip:monthWiseGameList.results[index].clip.clip!=null?monthWiseGameList.results[index].clip.clip:AppConstants.noInfo,
                        description: monthWiseGameList.results[index].description!=null? monthWiseGameList.results[index].description:AppConstants.noInfo,
                        genres: monthWiseGameList.results[index].genres!=null? monthWiseGameList.results[index].genres:AppConstants.noInfo,
                        platforms: monthWiseGameList.results[index].platforms!=null?monthWiseGameList.results[index].platforms:AppConstants.noInfo,
                        rating: monthWiseGameList.results[index].rating!=null? monthWiseGameList.results[index].rating:AppConstants.noInfo,
                        website: monthWiseGameList.results[index].website!=null?monthWiseGameList.results[index].website:AppConstants.noInfo,
                        released: monthWiseGameList.results[index].released!=null? monthWiseGameList.results[index].released:AppConstants.noInfo,
                        stores:  monthWiseGameList.results[index].stores!="Null"? monthWiseGameList.results[index].stores:AppConstants.noInfo,
                      );
                      Navigator.pushNamed(context, GameDetails.routeName,arguments: monthWiseGameListArguments);
                      //  print("ID PASSING TO DETAILS PAGE"   + monthWiseGameList.results[index].description);
//                      monthWiseGameList.results[index].clip == null
//                          ? Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => GameDetailsStates(
//                            gameId: monthWiseGameList.results[index].id,
//                            screenShots: monthWiseGameList
//                                .results[index].short_screenshots,
//                            gameName:
//                            monthWiseGameList.results[index].name,
//                            released:
//                            monthWiseGameList.results[index].released,
//                            rating:
//                            monthWiseGameList.results[index].rating,
//                            stores:
//                            monthWiseGameList.results[index].stores,
//                            clip: "no",
//                            genres:
//                            monthWiseGameList.results[index].genres,
//                            platforms: monthWiseGameList
//                                .results[index].platforms,
//                            flag: 1,
//                            website: monthWiseGameList.results[index].website,
//                          )))
//                          : Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => GameDetailsStates(
//                            clips: monthWiseGameList
//                                .results[index].clip.clips.full,
//                            gameId: monthWiseGameList.results[index].id,
//                            screenShots: monthWiseGameList
//                                .results[index].short_screenshots,
//                            gameName:
//                            monthWiseGameList.results[index].name,
//                            released:
//                            monthWiseGameList.results[index].released,
//                            rating:
//                            monthWiseGameList.results[index].rating,
//                            stores:
//                            monthWiseGameList.results[index].stores,
//                            clip: monthWiseGameList
//                                .results[index].clip.clip,
//                            genres:
//                            monthWiseGameList.results[index].genres,
//                            platforms: monthWiseGameList
//                                .results[index].platforms,
//                            flag: 1,
//                            website: monthWiseGameList.results[index].website,
//                          )));
                    },
                    child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: monthWiseGameList.results.length,
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
                                      monthWiseGameList
                                          .results[index].background_image !=
                                          null
                                          ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                        height:
                                        SizeConfig.imageSizeMultiplier * 20,
                                        width: SizeConfig.widthMultiplier * 34,

                                        child: CachedNetworkImage(
                                          imageUrl: monthWiseGameList
                                              .results[index].background_image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    //  colorFilter:
                                                    //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                          placeholder: (context, url) =>
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: FlareActor(
                                                      'assets/loader.flr',
                                                      alignment:
                                                      Alignment.center,
                                                      fit: BoxFit.contain,
                                                      animation: "loader")),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                          : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                        height:
                                        SizeConfig.imageSizeMultiplier * 20,
                                        width: SizeConfig.widthMultiplier * 34,
                                        child: Center(
                                            child: Text(
                                              "No Image avaliable",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 0.9,
                                            )),
                                      ),
//                                              Expanded(
//                                                  flex: 1,
//                                                  child:

                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.white30)),
                                          height: SizeConfig.heightMultiplier * 6.7,
                                          width: SizeConfig.widthMultiplier * 34,
                                          padding: EdgeInsets.only(
                                              left: 1 * SizeConfig.heightMultiplier,
                                              top: 2),
                                          child: Text(
                                            monthWiseGameList.results[index].name,
                                            style: AppTheme.subTitleLights,
                                            textScaleFactor: 0.9,
                                            //  textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
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

//    String currentYear=DateTime.now().year.toString();
//    String monthStartDate;
//    String monthEndDate;
//
//    monthStartDate= currentYear + '-02' + "-01";
//    monthEndDate=currentYear + '-02' + "-28";
//    monthDates=monthStartDate+","+monthEndDate;
//    restApiClient
//        .showMonthWiseGameRelease(monthDates)
//        .then((GameList responses) {
//      monthWiseGameList = responses;
//      print("hmmmmmm");
//
//
//    });

    onSelected(int index) {
      setState(() => selectedIndex = index);
    }

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(
              backgroundColor: Color.fromRGBO(21, 21, 21, 5),

              bottomNavigationBar:
               FutureBuilder(
                      future: restApiClient
                          .showMonthWiseGameRelease("com.gamersgram/1",weekDates, pageCount)
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
//

                    Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier + 10),
                        width: SizeConfig.widthMultiplier * 100,
                        height: SizeConfig.heightMultiplier * 12,
                        child: Card(
                            color: Color.fromRGBO(21, 21, 21, 2),
                            elevation: 6,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: SizeConfig.widthMultiplier * 10,
                                    child: GestureDetector(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.white,
                                                size: 6 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                              ),
                                            )
                                          ],
                                        ),
          onTap: () {
          Navigator.pushNamed(
          context,
          GameNewsDashboard.routeName);
                                        })),
                                Container(
                                    width: SizeConfig.widthMultiplier * 80,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Monthly trending",
                                      style: AppTheme.subTitleLights,
                                      textScaleFactor: 1.2,
                                    ))
                              ],
                            ))),

                    //   Column(children: <Widget>[
                    FutureBuilder(
                        future:
//
//                    pageCount != 1
//                            ?

                    restApiClient
                                .showMonthWiseGameRelease("com.gamersgram/1",weekDates, pageCount)
                                .then((GameList responses) {
                                monthWiseGameList = responses;
                                print("inside future" +
                                    monthWiseGameList.count.toString());
                              }),
//                            : restApiClient
//                                .showMonthWiseGameRelease(weekDates, pageCount)
//                                .then((GameList responses) {
//                                monthWiseGameList = responses;
//                                print("inside future" +
//                                    monthWiseGameList.count.toString());
//                                int pageCounts =
//                                    (responses.count / responses.results.length)
//                                        .floor();
//                                // print("printcode" + pageCount.toString());
//                                pages = new List();
//
//                                for (int i = 1; i < pageCounts; i++) {
//                                  //  print("pp"+pg.floor().toString());
//                                  pages.add(i);
//                                }
//                              }),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (monthWiseGameList == null) {
                            return Container(
                                height: SizeConfig.heightMultiplier * 20,
                                child: Center(
                                    child: FlareActor('assets/loader.flr',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: "loader")));
                          }
                          return Column(
//              scrollDirection: Axis.vertical,
//
//              shrinkWrap: true,
                            //   padding: EdgeInsets.all(5),

                            children: <Widget>[
                              trendingGamesByMonth(),
                              //pages.length != 0 ? footerWidget() : Container(),
                            ],
                          );
                        }),
                    //)),

                    // Divider(color: Colors.red,thickness: 2.0,),

//                    ],
//                  ),
                  ]),
//            )
//            ],
                  // ),
                )

                //)
              ]));
        },
      );
    });
  }
}
