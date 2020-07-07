import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/allgames/AllGameList.dart';
import 'package:gamersgram/game/gamedashboard/releasecalender/gamereleasecalender.dart';
import 'package:gamersgram/game/gamedashboard/monthlytrending/monthlytrendinggames.dart';
import 'package:gamersgram/game/gamedashboard/nextweekrelease/nextweekrelease.dart';
import 'package:gamersgram/game/gamedashboard/popularoftheyear/populargameslastyear.dart';
import 'package:gamersgram/game/gamedashboard/searchyourfavgame/searchyourfavgames.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

class GameNewsDashboard extends StatelessWidget {
  static const routeName = '/gamenewsdashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameDashboard(),
    );
  }
}

class GameDashboard extends StatefulWidget {
  GameDashboard({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _GameDashboardState createState() => _GameDashboardState();
}

class _GameDashboardState extends State<GameDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, constraints) {
      print("connected");
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(

                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  //    bottomNavigationBar: footerWidget(),
                  body:

                      //WillPopScope(

                      CustomScrollView(slivers: <Widget>[
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
                                              context,"/");
//
//                                  widget.pageDirection==2?
//
//                                  Navigator.push(context,
//
//                                      PageTransition(type:
//                                      PageTransitionType.leftToRight, child: PlatformHomePage())):  Navigator.push(context,
//
//                                      PageTransition(type:
//                                      PageTransitionType.leftToRight, child: Homepage()));
                                        },
                                      )),
                                  Container(
                                      width: SizeConfig.widthMultiplier * 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Game",
                                        style: AppTheme.mainTitles,
                                        textScaleFactor: 1.2,
                                      )),
                                ],
                              ))),

                      // Center(child:
                      Container(
                          height: SizeConfig.heightMultiplier * 80,
                          width: SizeConfig.widthMultiplier * 100,
                          padding:
                              EdgeInsets.all(SizeConfig.heightMultiplier + 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,

                              children: <Widget>[
                                Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white10)),
                                  height: SizeConfig.widthMultiplier * 25,
                                  width: SizeConfig.widthMultiplier * 40,
                                  child: RaisedButton(
                                    color: Colors.black38,
                                    elevation: 11,
                                    onPressed: () {
//                                      Navigator.push(
////                                          context,
////                                          NavSlideFromRight(
////                                            page: AllGamesList(),
////                                          ));

                                      Navigator.pushNamed(
                                          context,
                                          AllGamesList.routeName);
                                    },
                                    child: Text(
                                      "All Games",
                                      style: AppTheme.subTitleLights,
                                      textScaleFactor: 1.2,
                                    ),
                                  ),
                                )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.heightMultiplier),
                                    width: SizeConfig.widthMultiplier * 100,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white10)),
                                          height:
                                              SizeConfig.widthMultiplier * 25,
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: RaisedButton(
                                            color: Colors.black38,
                                            elevation: 11,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                NextWeekRelease.routeName);
                                            },
                                            child: Text(
                                              "Next week release",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                        Spacer(flex: 1),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white10)),
                                          height:
                                              SizeConfig.widthMultiplier * 25,
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: RaisedButton(
                                            color: Colors.black38,
                                            elevation: 11,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  MonthlyTrendingGames.routeName);
                                            },
                                            child: Text(
                                              "Trending this month",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.2,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),

                                Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.heightMultiplier),
                                    width: SizeConfig.widthMultiplier * 100,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white10)),
                                          height:
                                              SizeConfig.widthMultiplier * 25,
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: RaisedButton(
                                            color: Colors.black38,
                                            elevation: 11,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  PopularGamesLastYear.routeName);
                                            },
                                            child: Text(
                                              "Last year popular Games",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                        Spacer(flex: 1),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white10)),
                                          height:
                                              SizeConfig.widthMultiplier * 25,
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: RaisedButton(
                                            color: Colors.black38,
                                            elevation: 11,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  GameReleaseCalendar.routeName);
                                            },
                                            child: Text(
                                              "Release calender",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.2,
                                            ),
                                          ),
                                        ),


                                      ],
                                    )),

                                SizedBox(height: SizeConfig.heightMultiplier,),


                                Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.white10)),
                                      height: SizeConfig.widthMultiplier * 25,
                                      width: SizeConfig.widthMultiplier * 40,
                                      child: RaisedButton(
                                        color: Colors.black38,
                                        elevation: 11,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              SearchGameHomePage.routeName);
                                        },
                                        child: Text(
                                          "Search your fav Games",
                                          style: AppTheme.subTitleLights,
                                          textScaleFactor: 1.2,
                                        ),
                                      ),
                                    )),
                                //)

                                //)
                              ]))
                    ]))
                  ]));
        },
      );
    });
  }
}
