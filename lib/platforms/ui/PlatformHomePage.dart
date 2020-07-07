import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/platforms/platformdescription/ui/PlatformDetailsWithGaames.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;

import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/searchkar.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:provider/provider.dart';


var dio = new Dio()
  ..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();

class PlatformHomePage extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/platformhomepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          PlatformHomePageState(),
        );
  }
}

//PlatformListDetails _platformListDetails;
class PlatformHomePageState extends StatefulWidget {
  PlatformHomePageState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PlatformHomePageState createState() => _PlatformHomePageState();
}

//GlobalKey<AutoCompleteTextFieldState<PlatformListDetails>> key =
//new GlobalKey();
class _PlatformHomePageState extends State<PlatformHomePageState> {

  AutoCompleteTextField searchTextField;
  PlatformList platformListDetailsResponse;

//AutoCompleteTextField<PlatformListDetails> textField;
  TextEditingController editingController = new TextEditingController();
  String currentText = "";
  List<PlatformListDetails>platformListDetails = new List();
  List<PlatformListDetails>platformListDetailsResult = new List();

  GlobalKey<
      AutoCompleteTextFieldState<PlatformListDetails>> key = new GlobalKey();
  List<PlatformListDetails> users = new List<PlatformListDetails>();

  int pageCount = 1;
  int count;
  PlatformList allPlatformList;

//String tagName;
  List<int> pages = new List();

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

  // platformListDetailsResult=new List();



  Widget platformListWidget() {
//    return Align(
//        child: Directionality(
//           // textDirection: TextDirection.ltr,
//            child:

    return new Container(
        height: SizeConfig.heightMultiplier * 88,
        width: SizeConfig.widthMultiplier * 97,
        child: ListView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 4),
          //  physics: const ScrollPhysics(),
          padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier),

          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: allPlatformList == null ? 0 : allPlatformList.results
              .length,
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  /*
                              Switching and  passing data to TvShowDetailsPage
                            */

//                  Navigator.of(context).push(MaterialPageRoute(
////                      builder: (context) =>
////                          PlatformDetailsStates(platformId: allPlatformList
////                              .results[index].id,
////                            platformName: allPlatformList.results[index]
////                                .name,
////
////
////                          )))


                YoutubeArguments platformArguments = new YoutubeArguments(
                  gameId: allPlatformList.results[index].id,
                  gameName: allPlatformList.results[index].name,
                  flag: 2
                );
                Navigator.pushNamed(context, PlatformDetailsWithGames.routeName,arguments: platformArguments);
                },
                child:

                AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: allPlatformList.results.length,
                    child: ScaleAnimation(
                        child: FadeInAnimation(
                            child: Container(
                                height: SizeConfig.heightMultiplier * 8,
                                width: SizeConfig.widthMultiplier * 30,
//                              height: animation.value,
//                              width: animation.value,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors
                                            .white30)),
//                                        padding: EdgeInsets.only(
//                                            left: 5.0, right: 5.0, top: 0.5),


                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),


                                    color: Color.fromRGBO(32, 32, 32, 5),
                                    elevation: 8.0,

                                    child: Container(

                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
//                                                       Container(
//                                              height:
//                                              SizeConfig.heightMultiplier *
//                                                  8,
//                                              width:
//                                              SizeConfig.widthMultiplier *
//                                                  8,
//                                              //  padding: EdgeInsets.only(left: 10),
//
//                                              decoration: new BoxDecoration(
//                                                  color: Colors.white30,
//                                                  border: Border.all(
//                                                      color: Colors.white30),
//                                                  borderRadius: new BorderRadius
//                                                      .only(
//                                                    // bottomLeft:const Radius.circular(40.0) ,
//                                                      bottomRight:
//                                                      const Radius.circular(
//                                                          40.0),
//                                                      //   topLeft: const Radius.circular(40.0),
//                                                      topRight:
//                                                      const Radius.circular(
//                                                          40.0))),
//      child: Align(
//      alignment: Alignment.center,
//      child: Icon(
//      Icons.videogame_asset,
//      color: Colors.white,
//      ),
//      )),

                                          Expanded(child:

                                          Container(
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
                                              '${allPlatformList.results[index]
                                                  .name}',
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.0,
                                              softWrap: true,
                                            ),
                                          )),

                                        ],
                                      ),
                                    )))
                        ))));
          },
        ));
    //));
  }








  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return
            Scaffold(
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  // bottomNavigationBar:             footerWidget(),


                  body:


                  CustomScrollView(
                    slivers: <Widget>[
//                    SliverAppBar(
//                      pinned: true,
//                      expandedHeight: 20.0,
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
                                          width: SizeConfig.widthMultiplier *
                                              12,

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
                                                  "/");
                                            },
                                          )),
                                      Container(
                                          width: SizeConfig.widthMultiplier *
                                              80,

                                          alignment: Alignment.center,
                                          child:
                                          Text("Platform List",
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.3,)),


                                    ],))),


//                          Opacity(
//
//
//                              opacity: editingController.text.trim().isNotEmpty?0.0:1.0,
//                              child:
                          FutureBuilder(
                              future: restApiClient
                                  .showPlatformList("com.gamersgram/1",1)
                                  .then((PlatformList responses) {
                                platformListDetails = new List();
                                allPlatformList = responses;
                              }

                              ),
                              builder:
                                  (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (allPlatformList == null) {
                                  return Center(
                                      child:
                                      Container(
                                          height: SizeConfig
                                              .heightMultiplier * 20,

                                          child: FlareActor(
                                              'assets/loader.flr',
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              animation: "loader"


                                          ))

                                  );
                                  print("hasData Data");
                                }
                                else {
                                  print("hasData Data receved");
                                  return Column(
//              scrollDirection: Axis.vertical,
//
//              shrinkWrap: true,
                                    //   padding: EdgeInsets.all(5),

                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: platformListWidget(),


                                      )


                                      //     footerWidget()

                                    ],);
                                }
                              }),


                          //)),


                          //     Divider(color: Colors.red,thickness: 2.0,),


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
