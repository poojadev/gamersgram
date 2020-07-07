import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/genres/details/GenresDetails.dart';
import 'package:gamersgram/genres/model/GenresPOJO.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:flare_flutter/flare_actor.dart';

import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();

class GenresHomePage extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/genreshomepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GenresHomePageState(),
    );
  }
}

GenresPOJO genresList;
GameGenresDetails genresDetails;

class GenresHomePageState extends StatefulWidget {
  GenresHomePageState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _GenresHomePageState createState() => _GenresHomePageState();
}

class _GenresHomePageState extends State<GenresHomePageState> {
  GlobalKey<AutoCompleteTextFieldState<GenresResult>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;
  GenresPOJO genresDetailsResponse;
  AutoCompleteTextField<GenresResult> textField;
  TextEditingController editingController = new TextEditingController();
  String currentText = "";
  List<GenresResult> genresDetails = new List();

  //List<PlatformListDetails>platformListDetailsResult=new List();

//
//  @override
//  void dispose() {
//    // Ensure disposing of the VideoPlayerController to free up resources.
//    //  _controller.dispose();
////    // pageCount=0;
////     pages.clear();
//    platformwiseGameList.results.clear();
//    pageCount=1;
//    setState(() {
//
//    });
//    super.dispose();
//  }

  int pageCount = 1;
  int count;
  List<int> pages = new List();

  // platformListDetailsResult=new List();
  @override
  Widget build(BuildContext context) {
    //  publisherSuggestionsAc=new List();

    int pageNumber = 1;
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

    Widget genresListWidget(GenresPOJO genresList) {
      return new Container(
          height: SizeConfig.heightMultiplier * 87,
          width: SizeConfig.widthMultiplier * 97,
          child: ListView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 4),
            //  physics: const ScrollPhysics(),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: genresList == null ? 0 : genresList.results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                    YoutubeArguments genresDetailsArguments=new YoutubeArguments(gameName: genresList.results[index].name,
                        gameId: genresList.results[index].id,flag: 2);
                    Navigator.pushNamed(context, GenresDetails.routeName,arguments: genresDetailsArguments);

                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: genresList.results.length,
                      child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: Container(
                                  height: SizeConfig.heightMultiplier * 9,
                                  width: SizeConfig.widthMultiplier * 30,
//                              height: animation.value,
//                              width: animation.value,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white30)),
//                                        padding: EdgeInsets.only(
//                                            left: 5.0, right: 5.0, top: 0.5),

                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      semanticContainer: true,
                                      color: Color.fromRGBO(32, 32, 32, 5),
                                      elevation: 8.0,
                                      child: Container(
                                        child: Row(
                                          //  mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                              // color: Colors.white30,
//                                              height:
//                                                  SizeConfig.heightMultiplier *
//                                                      5,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      30,
                                              padding: EdgeInsets.all(5),
                                              // alignment: Alignment.topLeft,
                                              child: Text(
                                                '${genresList.results[index].name}',
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.0,
                                                softWrap: true,
                                              ),
                                            )),
                                          ],
                                        ),
                                      )))))));
            },
          ));
      //));
    }

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return  Scaffold(
            backgroundColor: Color.fromRGBO(21, 21, 21, 5),
            //bottomNavigationBar: footerWidget(),

            body: CustomScrollView(
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
//       Column(
//
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[

                    // footerWidget(),

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
                                            "/");
                                      },
                                    )),
                                Container(
                                    width: SizeConfig.widthMultiplier * 80,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Genres List",
                                      style: AppTheme.mainTitles,
                                      textScaleFactor: 1.2,
                                    )),
                              ],
                            ))),
//                          platformSearchWidget(),
//
//                          genresDetails.length==0?
//                          Container(height: 5,): publisherSearchResult(),

//            Expanded(
//              child: Container(

                    //child:

                    //  publisherListLv==null?
                    FutureBuilder(
                        future: pageCount != 1
                            ? restApiClient
                                .showGenresList("com.gamersgram/1",pageCount)
                                .then((GenresPOJO responses) {
                                genresList = responses;
                              })
                            : restApiClient
                                .showGenresList("com.gamersgram/1",1)
                                .then((GenresPOJO responses) {
                                genresList = responses;
                                print("PAGE COUNT IN PUBLISHER" +
                                    genresList.count.toString());
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
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (genresList == null) {
                            return Container(
                                height: SizeConfig.heightMultiplier * 20,
                                child: FlareActor('assets/loader.flr',
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    animation: "loader"));
                          }

                          return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(5),
                            children: <Widget>[
                              genresListWidget(genresList),
                              footerWidget()
                            ],
                          );
                        }),
                    //)),

                    //Divider(color: Colors.red,thickness: 2.0,),

//                    ],
//                  ),
                  ]),
                )
              ],
            ),
          

              //)

              );
        },
      );
    });
  }
}
