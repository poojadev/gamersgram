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

//
//class GameReleaseCalendar extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: GameReleaseCalendarState(),
//    );
//  }
//}

class GameReleaseCalendar extends StatefulWidget {
  static const routeName="/GameReleaseCalendar";

  GameReleaseCalendar({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PopularGamesState createState() => _PopularGamesState();
}

int selectedIndex = 0;
int pageCount = 1;
int count;

List<int> pages = new List();

class _PopularGamesState extends State<GameReleaseCalendar> {
  String currentYear = DateTime.now().year.toString();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String monthStartDate = currentYear + '-01' + "-01";
    String monthEndDate = currentYear + '-01' + "-31";

    monthDates = monthStartDate + "," + monthEndDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String monthDates;

  @override
  Widget build(BuildContext context) {
    GameList releaseGameList;

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
                            color:
                                pageCount == index ? Colors.red : Colors.black,
//                      color: pageNumber == index
//                          ? Colors.red
//                          : pageNumber == 1 ? Colors.red : Colors.black,
                            //  width: 5,
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 0.2),
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

    Widget gamesByReleaseMonth() {
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

        return Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                //  color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(1)),
                border: Border.all(color: Colors.white30)),
            height: pages.length == 0
                ? SizeConfig.heightMultiplier * 66
                : SizeConfig.heightMultiplier * 56,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),

              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:
                  releaseGameList == null ? 0 : releaseGameList.results.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    onTap: () {
                      /*
                              Switching and  passing data to TvShowDetailsPage
                            */
                      YoutubeArguments releaseGameListArguments = new YoutubeArguments(
                        flag: 1,

                        gameName:releaseGameList.results[index].name!=null? releaseGameList.results[index].name:AppConstants.noInfo
                        ,gameId: releaseGameList.results[index].id!=null?releaseGameList.results[index].id:AppConstants.noInfo,

                        screenShots: releaseGameList.results[index].short_screenshots!=null?
                        releaseGameList.results[index].short_screenshots:AppConstants.noInfo,
                        //clip:releaseGameList.results[index].clip.clip!=null?releaseGameList.results[index].clip.clip:AppConstants.noInfo,
                        description: releaseGameList.results[index].description!=null? releaseGameList.results[index].description:AppConstants.noInfo,
                        genres: releaseGameList.results[index].genres!=null? releaseGameList.results[index].genres:AppConstants.noInfo,
                        platforms: releaseGameList.results[index].platforms!=null?releaseGameList.results[index].platforms:AppConstants.noInfo,
                        rating: releaseGameList.results[index].rating!=null? releaseGameList.results[index].rating:AppConstants.noInfo,
                        website: releaseGameList.results[index].website!=null?releaseGameList.results[index].website:AppConstants.noInfo,
                        released: releaseGameList.results[index].released!=null? releaseGameList.results[index].released:AppConstants.noInfo,
                        stores:  releaseGameList.results[index].stores!="Null"? releaseGameList.results[index].stores:AppConstants.noInfo,
                      );
                      Navigator.pushNamed(context, GameDetails.routeName,arguments: releaseGameListArguments);


                      //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                      releaseGameList.results[index].clip == null
//                          ? Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => GameDetailsStates(
//                                    gameId: releaseGameList.results[index].id,
//                                    screenShots: releaseGameList
//                                        .results[index].short_screenshots,
//                                    gameName:
//                                        releaseGameList.results[index].name,
//                                    released:
//                                        releaseGameList.results[index].released,
//                                    rating:
//                                        releaseGameList.results[index].rating,
//                                    stores:
//                                        releaseGameList.results[index].stores,
//                                    clip: "no",
//                                    genres:
//                                        releaseGameList.results[index].genres,
//                                    platforms: releaseGameList
//                                        .results[index].platforms,
//                                    flag: 1,
//                                website: releaseGameList.results[index].website,
//                                  )))
//                          : Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => GameDetailsStates(
//                                    clips: releaseGameList
//                                        .results[index].clip.clips.full,
//                                    gameId: releaseGameList.results[index].id,
//                                    screenShots: releaseGameList
//                                        .results[index].short_screenshots,
//                                    gameName:
//                                        releaseGameList.results[index].name,
//                                    released:
//                                        releaseGameList.results[index].released,
//                                    rating:
//                                        releaseGameList.results[index].rating,
//                                    stores:
//                                        releaseGameList.results[index].stores,
//                                    clip: releaseGameList
//                                        .results[index].clip.clip,
//                                    genres:
//                                        releaseGameList.results[index].genres,
//                                    platforms: releaseGameList
//                                        .results[index].platforms,
//                                    flag: 1,
//                                website: releaseGameList.results[index].website,
//                                  )));
                    },
                    child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: releaseGameList.results.length,
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
                                  releaseGameList.results[index]
                                              .background_image !=
                                          null
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                          height:
                                              SizeConfig.imageSizeMultiplier *
                                                  20,
                                          width:
                                              SizeConfig.widthMultiplier * 34,

                                          child: CachedNetworkImage(
                                            imageUrl: releaseGameList
                                                .results[index]
                                                .background_image,
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
                                                    height: SizeConfig.heightMultiplier*10,
                                                    child: FlareActor(
                                                        'assets/loader.flr',
                                                        alignment:
                                                            Alignment.center,
                                                        fit: BoxFit.contain,
                                                        animation: "loader")),
                                            errorWidget:
                                                (context, url, error) =>
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
                                              SizeConfig.imageSizeMultiplier *
                                                  20,
                                          width:
                                              SizeConfig.widthMultiplier * 34,
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
                                          border: Border.all(
                                              color: Colors.white30)),
                                      height: SizeConfig.heightMultiplier * 6.7,
                                      width: SizeConfig.widthMultiplier * 34,
                                      padding: EdgeInsets.only(
                                          left: 1 * SizeConfig.heightMultiplier,
                                          top: 2),
                                      child: Text(
                                        releaseGameList.results[index].name,
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

    List<String> monthList = new List();
    monthList.add("Jan");
    monthList.add("Feb");
    monthList.add("Mar");
    monthList.add("Apr");
    monthList.add("May");
    monthList.add("Jun");
    monthList.add("Jul");
    monthList.add("Aug");
    monthList.add("Sep");
    monthList.add("Oct");
    monthList.add("Nov");
    monthList.add("Dec");
    int monthCount = 0;

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

    print("NOT PLESE WORK");

return


    LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(
              backgroundColor: Color.fromRGBO(21, 21, 21, 5),
              bottomNavigationBar:                FutureBuilder(
                  future:restApiClient
                      .showMonthWiseGameRelease("com.gamersgram/1",monthDates, pageCount)
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

                      pages.length != 0 ? footerWidget() : Container(height: 2,);

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
                                              context,
                                              GameNewsDashboard.routeName);
                                        })),
                                Container(
                                    width: SizeConfig.widthMultiplier * 80,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Game release calender",
                                      style: AppTheme.subTitleLights,
                                      textScaleFactor: 1.2,
                                    ))
                              ],
                            ))),

                    Container(
                        height: SizeConfig.heightMultiplier * 23,
                        width: SizeConfig.widthMultiplier * 98,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6),
                          // physics: const NeverScrollableScrollPhysics(),

                          scrollDirection: Axis.vertical,
//                shrinkWrap: true,
                          padding: EdgeInsets.all(5),

                          shrinkWrap: true,
                          itemCount: monthList == null ? 0 : monthList.length,
                          itemBuilder: (context, index) {
                            //     print("Lenght of tags" +tagsList.results.length.toString());

                            return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: monthList.length,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: Card(
                                          // (foo==1)?something1():(foo==2)? something2():(foo==3)? something3(): something4();
//(i == 1) ? 1 : (i == 2) ? 2 : 0

                                          //  width: 5,
//                      padding:
//                      EdgeInsets.only(left: 5.0, right: 5.0, top: 0.2),
                                          elevation: 11,
                                          child: Container(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2,
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  child: RaisedButton(
                                                      padding: EdgeInsets.all(
                                                          SizeConfig
                                                              .heightMultiplier),
                                                      color: selectedIndex !=
                                                                  null &&
                                                              selectedIndex ==
                                                                  index
                                                          ? Colors.red
                                                          : Colors.black45,
                                                      //    height: SizeConfig.heightMultiplier * 12,

                                                      onPressed: () {
                                                        //  setState(() {
                                                        onSelected(index);
                                                        print("value" +
                                                            onSelected(index)
                                                                .toString());

                                                        //  });
                                                        print(monthCount);
                                                        String currentYear =
                                                            DateTime.now()
                                                                .year
                                                                .toString();
                                                        String monthStartDate;
                                                        String monthEndDate;
                                                        print(monthCount);
                                                        print(index);
                                                        setState(() {
                                                          pageCount = 1;
                                                          switch (index) {
                                                            case 0:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-01' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-01' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                monthCount =
                                                                    index;
                                                              });
//                                                restApiClient
//                                                    .showMonthWiseGameRelease(monthDates)
//                                                    .then((GameList responses) {
//                                                  monthWiseGameList = responses;
//
//
//                                                });

                                                              break;

                                                            case 1:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-02' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-02' +
                                                                      "-29";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });

                                                              break;
                                                            case 2:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-03' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-03' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 3:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-04' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-04' +
                                                                      "-30";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 4:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-05' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-05' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 5:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-06' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-06' +
                                                                      "-30";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 6:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-07' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-07' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 7:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-08' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-08' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 8:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-09' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-09' +
                                                                      "-30";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 9:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-10' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-10' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 10:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-11' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-11' +
                                                                      "-30";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;

                                                            case 11:
                                                              monthStartDate =
                                                                  currentYear +
                                                                      '-12' +
                                                                      "-01";
                                                              monthEndDate =
                                                                  currentYear +
                                                                      '-12' +
                                                                      "-31";
                                                              setState(() {
                                                                monthDates =
                                                                    monthStartDate +
                                                                        "," +
                                                                        monthEndDate;
                                                                print("click" +
                                                                    index
                                                                        .toString());
                                                                releaseGameList;
                                                                monthCount =
                                                                    index;
                                                                print(
                                                                    monthCount);
                                                              });
                                                              break;
                                                          }
                                                        });
                                                      },
                                                      child:
                                                          //padding: EdgeInsets.all(5),
                                                          //   padding: EdgeInsets.all(10),

                                                          //  height: SizeConfig.heightMultiplier*10,
                                                          Container(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  8,
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  8,
                                                              //  padding: EdgeInsets.only(left: 10),

//                                                decoration: new BoxDecoration(
//                                                    color: Colors.white30,
//                                                    border: Border.all(
//                                                 ),
//                                                  child: Align(
//
//
//                                                    alignment: Alignment.center,
//                                                    child:Image.asset("assets/images/publisher.png"
//
//                                                    ),
//
//                                                  )
//                                              ),

                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  monthList[
                                                                      index],
                                                                  style: AppTheme
                                                                      .subTitleLights,
                                                                  softWrap:
                                                                      true,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  textScaleFactor:
                                                                      1.0,
                                                                ),
                                                              ))))))),
                                ));
                          },
                        )),

                    FutureBuilder(
                        future:

//                        pageCount != 1
//                            ?

                        restApiClient
                                .showMonthWiseGameRelease("com.gamersgram/1",monthDates, pageCount)
                                .then((GameList responses) {
                                releaseGameList = responses;
                                print("inside future" +
                                    releaseGameList.count.toString());
                              }),
//                            : restApiClient
//                                .showMonthWiseGameRelease(monthDates, pageCount)
//                                .then((GameList responses) {
//                                releaseGameList = responses;
//                                print("inside future" +
//                                    releaseGameList.count.toString());
//
//                                if (pageCount != 1) {
//                                  pageCount = (responses.count /
//                                          responses.results.length)
//                                      .floor();
//                                  //p.add(pageCount);
//                                  //print("printcode 1" + pageCount.toString());
//                                }
//                                pageCount =
//                                    (responses.count / responses.results.length)
//                                        .floor();
//                                // print("printcode" + pageCount.toString());
//                                pages = new List();
//
//                                for (int i = 1; i < pageCount; i++) {
//                                  //  print("pp"+pg.floor().toString());
//
//                                  i < pageCount ? pages.add(pageCount) : i;
//                                  // print("PGE COUNt" + pages.length.toString());
//                                }
//                              }),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (releaseGameList == null) {
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
                              gamesByReleaseMonth(),
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
