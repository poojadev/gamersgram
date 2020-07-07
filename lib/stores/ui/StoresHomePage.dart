import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';

import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/stores/details/StoreDetails.dart';
import 'package:gamersgram/stores/model/GameStores.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:flare_flutter/flare_actor.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
int storeId;
String storeName;
 YoutubeArguments storeDetailsArguments;

class StoresHomePage extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/storeshomepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoresHomePageState(
//        storeId: storeId,
//        storeName: storeName,
        storeDetailsArguments: storeDetailsArguments,
      ),
    );
  }
}

class StoresHomePageState extends StatefulWidget {
  StoresHomePageState(
      {Key key, this.title, @required this.storeDetailsArguments})
      : super(key: key);
//  final int storeId;
//  final String storeName;
 final YoutubeArguments storeDetailsArguments;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _StoresHomePageState createState() => _StoresHomePageState();
}

class _StoresHomePageState extends State<StoresHomePageState> {
  AutoCompleteTextField searchTextField;

  String currentText = "";

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
    GameStores storesDetailsResponse;

    Widget storesWidget() {
      return new Container(
          height: SizeConfig.heightMultiplier * 85,
          width: SizeConfig.widthMultiplier * 97,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: storesDetailsResponse == null
                ? 0
                : storesDetailsResponse.results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

//                    Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) => StoreDetailsState(
//                              storeId: storesDetailsResponse.results[index].id,
//                              storeName:
//                                  storesDetailsResponse.results[index].name,
//                            )));

                  YoutubeArguments storeDetailsArguments=new YoutubeArguments(gameId: storesDetailsResponse.results[index].id,
                  gameName: storesDetailsResponse.results[index].name,flag:2);
                  Navigator.pushNamed(context, StoreDetails.routeName,arguments: storeDetailsArguments);
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: storesDetailsResponse.results.length,
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
                                                '${storesDetailsResponse.results[index].name}',
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
    }

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(

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
                                          width:
                                              SizeConfig.widthMultiplier * 10,
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
                                              Navigator.pushNamed(context,"/");
                                            },
                                          )),
                                      Container(
                                          width:
                                              SizeConfig.widthMultiplier * 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Store List",
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.2,
                                          )),
                                    ],
                                  ))),

//            Expanded(
//              child: Container(

                          //child:

                          //  publisherListLv==null?
                          FutureBuilder(
                              future: pageCount != 1
                                  ? restApiClient
                                      .shoeGameStores("com.gamersgram/1",pageCount)
                                      .then((GameStores responses) {
                                      storesDetailsResponse = responses;
                                    })
                                  : restApiClient
                                      .shoeGameStores("com.gamersgram/1",1)
                                      .then((GameStores responses) {
                                      storesDetailsResponse = responses;
                                      int pageCounts = (responses.count /
                                              responses.results.length)
                                          .floor();
                                      // print("printcode" + pageCount.toString());
                                      pages = new List();

                                      for (int i = 1; i < pageCounts; i++) {
                                        //  print("pp"+pg.floor().toString());
                                        pages.add(i);
                                        //  i == pageCount ? pages.add(pageCount) : i;
                                        //  print("PGE COUNt" + pages.length.toString());

                                      }
                                    }),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (storesDetailsResponse == null) {
                                  return Container(
                                      height: SizeConfig.heightMultiplier * 20,
                                      child: FlareActor('assets/loader.flr',
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                          animation: "loader"));
                                }

                                return Column(
//              scrollDirection: Axis.vertical,
//
//              shrinkWrap: true,
                                  //   padding: EdgeInsets.all(5),

                                  children: <Widget>[
                                    storesWidget(),
                                  ],
                                );
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

                  //)

                  );
        },
      );
    });
  }
}
