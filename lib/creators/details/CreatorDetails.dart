import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/creators/ui/CreatorHomePage.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/footerwidget.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:cached_network_image/cached_network_image.dart';

List<GamesCreatorsDetails> creatorDetailList;
var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants=new AppConstants();
int creatorId;

int pageCount = 1;
int count;
List<int> pages = new List();
String creatorImageUrl;
String creatorName;
int pageDirection;
YoutubeArguments creatorDetailsArguments;
class CreatorDetails extends StatelessWidget {
  static const String routeName="/CreatorDetailsState";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreatorDetailsState(
          creatorDetailsArguments:creatorDetailsArguments

      ),
    );
  }
}

class CreatorDetailsState extends StatefulWidget {
  static Map event;

  CreatorDetailsState(
      {Key key,
      @required this.creatorDetailsArguments})
      : super(key: key);

  final YoutubeArguments creatorDetailsArguments;



  @override
  _CreatorDetailsState createState() => _CreatorDetailsState();
}

class _CreatorDetailsState extends State<CreatorDetailsState>
    with SingleTickerProviderStateMixin {
  TabController _creatorTabController;

  Future<void> _initializeVideoPlayerFuture;

  GamesCreatorsDetails gamesCreatorsDetails;
  CreatorPlatformList creatorPlatformList;
  GameList creatorGameList;
  @override
  void initState() {


    super.initState();
    _creatorTabController = new TabController(length: 3, vsync: this);
  }


  Widget gamePlatformWidget() {
    return Container(
        alignment: Alignment.topLeft,

        child:
        Column(children: <Widget>[
          Directionality(
              textDirection: TextDirection.ltr,
              child: new Container(
                  height: SizeConfig.heightMultiplier + 15,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                      gamesCreatorsDetails == null ? 0 :gamesCreatorsDetails.positions.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            //columnCount:  widget.platforms.length,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child:
                                    Container(
//                                      height: 50,
//                                      width: 100,
//                              height: animation.value,
//                              width: animation.value,

                                      padding: EdgeInsets.only(left: 9),

                                      child: Text(
                                        gamesCreatorsDetails.platforms
                                            .results[index].platform.name,
                                        textScaleFactor: 0.9,
                                        style: AppTheme.mainTitles,
                                        softWrap: true,

                                      ),
                                    ))));
                      })))

        ],));
  }


  Widget gamePositionWidget() {
    return Container(
        alignment: Alignment.topLeft,

        child:
        Column(children: <Widget>[
          Directionality(
              textDirection: TextDirection.ltr,
              child: new Container(
                  height: SizeConfig.heightMultiplier + 15,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                      gamesCreatorsDetails == null ? 0 : gamesCreatorsDetails
                          .positions.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            //columnCount:  widget.platforms.length,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child:
                                    Container(
//                                      height: 50,
//                                      width: 100,
//                              height: animation.value,
//                              width: animation.value,

                                      padding: EdgeInsets.only(left: 9),

                                      child:Wrap(children: <Widget>[

                                        Text(
                                          gamesCreatorsDetails.positions[index]
                                              .name,
                                          textScaleFactor: 1,
                                          style: AppTheme.mainTitles,
                                          softWrap: true,

                                        ),
                                      ],),
                                    ))));
                      })))

        ],));
  }



  Widget gamesByCreatorWidget() {
    return new Container(
        height: SizeConfig.heightMultiplier * 30,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          //  physics: const ScrollPhysics(),
          padding: EdgeInsets.all(5),

          scrollDirection: Axis.vertical,
                    shrinkWrap: true,
          itemCount: creatorGameList == null ? 0 : creatorGameList.results
              .length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                          onTap: () {
                            /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                            YoutubeArguments creatorGameListArguments = new YoutubeArguments(
                              flag: 7,

                              gameName:creatorGameList.results[index].name!=null? creatorGameList.results[index].name:AppConstants.noInfo
                              ,gameId: creatorGameList.results[index].id!=null?creatorGameList.results[index].id:AppConstants.noInfo,

                              screenShots: creatorGameList.results[index].short_screenshots!=null?
                              creatorGameList.results[index].short_screenshots:AppConstants.noInfo,
                              //clip:creatorGameList.results[index].clip!=null?creatorGameList.results[index].clip.clip:AppConstants.noInfo,
                              description: creatorGameList.results[index].description!=null? creatorGameList.results[index].description:AppConstants.noInfo,
                              genres: creatorGameList.results[index].genres!=null? creatorGameList.results[index].genres:AppConstants.noInfo,
                              platforms: creatorGameList.results[index].platforms!=null?creatorGameList.results[index].platforms:AppConstants.noInfo,
                              rating: creatorGameList.results[index].rating!=null? creatorGameList.results[index].rating:AppConstants.noInfo,
                              website: creatorGameList.results[index].website!=null?creatorGameList.results[index].website:AppConstants.noInfo,
                              released: creatorGameList.results[index].released!=null? creatorGameList.results[index].released:AppConstants.noInfo,
                              stores:  creatorGameList.results[index].stores!="Null"? creatorGameList.results[index].stores:AppConstants.noInfo,
                            );
                            Navigator.pushNamed(context, GameDetails.routeName,arguments: creatorGameListArguments);

//                            creatorGameList.results[index].clip == null
//                                ? Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) =>
//                                    GameDetailsStates(
//                                      gameId: creatorGameList.results[index].id,
//                                      screenShots: creatorGameList
//                                          .results[index].short_screenshots,
//                                      gameName: creatorGameList.results[index]
//                                          .name,
//                                      released:
//                                      creatorGameList.results[index].released,
//                                      rating: creatorGameList.results[index]
//                                          .rating,
//                                      stores: creatorGameList.results[index]
//                                          .stores,
//                                  clip: "no",
//                                      genres: creatorGameList.results[index]
//                                          .genres,
//                                      platforms:
//                                      creatorGameList.results[index].platforms,
//                                  flag: 1,
//                                    )))
//                                : Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) =>
//                                    GameDetailsStates(
//                                      gameId: creatorGameList.results[index].id,
//                                      screenShots: creatorGameList
//                                          .results[index].short_screenshots,
//                                      gameName: creatorGameList.results[index]
//                                          .name,
//                                      released:
//                                      creatorGameList.results[index].released,
//                                      rating: creatorGameList.results[index]
//                                          .rating,
//                                      stores: creatorGameList.results[index]
//                                          .stores,
//                                      clip: creatorGameList.results[index].clip
//                                          .clip,
//                                      genres: creatorGameList.results[index]
//                                          .genres,
//                                      platforms:
//                                      creatorGameList.results[index].platforms,
//                                  flag: 1,
//                                      description:
//                                      creatorGameList.results[index]
//                                          .description,
//                                      systemRequirement: creatorGameList
//                                          .results[index].platforms[index]
//                                          .requirements,
//                                    )));
                          },
                          child: AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: creatorGameList.results.length,
                              child: ScaleAnimation(
                                  child: FadeInAnimation(

                                    child: Container(

                                        padding: EdgeInsets.only(
                                            left: 1 *
                                                SizeConfig.heightMultiplier,
                                            right: 1 *
                                                SizeConfig.heightMultiplier,
                                            bottom: 1 *
                                                SizeConfig.heightMultiplier),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            creatorGameList.results[index]
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
                                                imageUrl: creatorGameList
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
                                                : Container(
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
                                                padding: EdgeInsets.only(
                                                    left: 1 *
                                                        SizeConfig
                                                            .heightMultiplier,
                                                    top: 2),
                                                child: Text(
                                                  creatorGameList.results[index]
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


  Widget footerWidget() {
    // pages.add(pageCount);
    print("wee" + pages.length.toString());

    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            height: SizeConfig.heightMultiplier * 7,
            //    width: SizeConfig.widthMultiplier*1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
//        gridDelegate:
//        SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 20.0),
              shrinkWrap: true,

              itemCount: pages == null ? 0 : pages.length,
              itemBuilder: (context, index) {
                print("inside" + pages.length.toString());
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: index != 0
                      ? new Container(
                    // (foo==1)?something1():(foo==2)? something2():(foo==3)? something3(): something4();
//(i == 1) ? 1 : (i == 2) ? 2 : 0
                      color: pageCount == index
                          ? Colors.red
                          : pageCount == 1 ? Colors.red : Colors.black,
                      height: 10,
                      //  width: 5,
                      padding:
                      EdgeInsets.only(left: 5.0, right: 5.0, top: 0.2),
                      child: Card(
                        // color: pageCount == index ? Colors.red : Colors.black,
                        elevation: 10.0,
                        child: RaisedButton(

                            onPressed: () {
                              creatorGameList.results.clear();

                              setState(() {
                                // index==0?index++:index;

                                pageCount = index;
                              });
                              print("Pressed" + pageCount.toString());
                              print("pressed index" + index.toString());
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

                    //  subtitle: Text('${games.result[index].platformDetails[0].details.id}'),
                  )
                      : Container(),
                );
              },
            )));
  }


  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
      print("url"+widget.creatorDetailsArguments.gameId.toString());

    return LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return Scaffold(
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  //     bottomNavigationBar:footerWidget(),

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
                                              10,

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
//
                                              widget.creatorDetailsArguments.flag == 2
                                                  ?

                                              Navigator.pushNamed(context, CreatorHomePage.routeName)

                                                  : Navigator.pop(context);

                                            },
                                          )),
                                      Container(
                                          width: SizeConfig.widthMultiplier *
                                              80,

                                          alignment: Alignment.center,
                                          child:
                                          Text(widget.creatorDetailsArguments.gameName,
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.2,)),


                                    ],))),
//              Container(
//
//              padding: EdgeInsets.only(top: 5),
//              height: SizeConfig.heightMultiplier * 100,
//                      child:
                          SingleChildScrollView(
                         child: Container(

                            padding: EdgeInsets.only(top: 5),
                            height: SizeConfig.heightMultiplier * 90,
//                            decoration: BoxDecoration(
//                              //  color: Colors.red,
//                                borderRadius:
//                                BorderRadius
//                                    .all(Radius
//                                    .circular(
//                                    1)),
//                                border: Border.all(color:
//                                Colors.white30)
//                            ),
                         //   child: SingleChildScrollView(

                              // color: Colors.yellowAccent,

                              // height: SizeConfig.heightMultiplier * 10,
                              child:

                              Wrap(
                                //   mainAxisSize: MainAxisSize.max,
                                children: <Widget>[


//                              Container(
//
//                                  padding: EdgeInsets.only(top: 20),
//                                  height: SizeConfig.heightMultiplier * 70,
//                                  decoration: BoxDecoration(
//                                      borderRadius:
//                                      BorderRadius
//                                          .all(Radius
//                                          .circular(
//                                          1)),
//                                      border: Border.all(color:
//                                      Colors.white30)
//                                  ),
//
//                                    // color: Colors.yellowAccent,
//
//                                    // height: SizeConfig.heightMultiplier * 10,
//
//
//                                    child:

//                      Column(
//                        mainAxisSize: MainAxisSize.max,
//                        children: <Widget>[


//                              Container(
//
//
//
//                                  decoration: BoxDecoration(
//                                      color: Colors.black54,
//                                      borderRadius:
//                                      BorderRadius
//                                          .all(Radius
//                                          .circular(
//                                          1)),
//                                      border: Border.all(color:
//                                      Colors.white30)
//                                  ),
//
//                                  padding: EdgeInsets.all(5),
//
//                                  height: SizeConfig.heightMultiplier*100/2+10,
//                              width: SizeConfig.widthMultiplier*99,
//child:
//



                                SingleChildScrollView(child:
                                  Container(
                                      height: SizeConfig.heightMultiplier*45,
                                      width: SizeConfig.widthMultiplier * 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .white30)),


                                      child:
                                      FutureBuilder(
                                          future: restApiClient
                                              .showGameCreatorsDetails("com.gamersgram/1",widget.creatorDetailsArguments.gameId)
                                              .then((GamesCreatorsDetails responses) {
                                            gamesCreatorsDetails = responses;
                                            creatorPlatformList =
                                                responses.platforms;
                                            print("DDDDDD" + responses.name);
                                          }),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (gamesCreatorsDetails == null) {
                                              return Container(
                                                  height: SizeConfig
                                                      .heightMultiplier * 10,
                                                  child: Center(
                                                      child: FlareActor(
                                                          'assets/loader.flr',
                                                          //  animation:
                                                          alignment: Alignment
                                                              .center,
                                                          fit: BoxFit.contain,
                                                          animation: "loader"


                                                      )));
                                            }
                                            return
                                          SingleChildScrollView(
//                                              scrollDirection: Axis.vertical,
////                                              height: SizeConfig.heightMultiplier*60,
////                                           width: SizeConfig.widthMultiplier*98,
//
                                              child:

                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                //  shrinkWrap: true,

                                                children: <Widget>[

                                                  widget.creatorDetailsArguments.imgUrl != null
                                                      ? CachedNetworkImage(
                                                    imageUrl: widget.creatorDetailsArguments.imgUrl,
                                                    imageBuilder: (context,
                                                        imageProvider) =>
                                                        Container(
                                                          height: SizeConfig
                                                              .heightMultiplier *
                                                              19,
                                                          width: SizeConfig
                                                              .widthMultiplier *
                                                              35,
                                                          decoration:
                                                          BoxDecoration(
                                                            // border: Border.all(color:Colors.white30,width: 2),
                                                            shape: BoxShape
                                                                .circle,
                                                            image:
                                                            DecorationImage(
                                                              image:
                                                              imageProvider,
                                                              fit: BoxFit.cover,
                                                              //  colorFilter:
                                                              //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                            ),
                                                          ),

                                                        ),
                                                    placeholder: (context,
                                                        url) =>Container(
                                                      height: SizeConfig.heightMultiplier*20,
                                                        child:Center(
                                                            child: FlareActor(
                                                                'assets/loader.flr',
                                                                alignment: Alignment
                                                                    .center,
                                                                fit: BoxFit
                                                                    .contain,
                                                                animation: "loader")


                                                            )),
                                                    errorWidget: (context,
                                                        url, error) =>
                                                        Icon(Icons.error),
                                                  )
                                                      : Container(),
//                                              gamesCreatorsDetails.name!=null?Container(
//
//                                                child:  AutoSizeText(gamesCreatorsDetails.name,style: TextStyle(color: Colors.white),),
//                                                padding: EdgeInsets.all(5),
//
//                                              ):Container(),

//                                              Expanded(
//
//                                                flex:1,
//                                                child:
//                                      Container(
//                                        color:Colors.red,

//                                          height: SizeConfig
//                                              .heightMultiplier *
//                                              20,


//                                                height: SizeConfig
//                                                        .heightMultiplier *
//                                                    15,

                                                  //  child:
                                                  //    Expanded(
                                                  //  scrollDirection:
                                                  // Axis.vertical,
                                                  // reverse: true,
                                                 gamesCreatorsDetails.description!=null? Container(
                                                      padding: EdgeInsets
                                                          .only(top: SizeConfig
                                                          .heightMultiplier +
                                                          5),

//                                            height: SizeConfig
//                                                .heightMultiplier *
//                                                15,
                                                      child:
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.vertical,

                                                        child: Text(
                                                          html2md.convert(
                                                              gamesCreatorsDetails
                                                                  .description),
                                                          style: AppTheme
                                                              .subTitleLights,
                                                          textScaleFactor:
                                                          1.1,
                                                          softWrap: true,
                                                        ),

                                                        padding: EdgeInsets
                                                            .only(
                                                            left: SizeConfig
                                                                .heightMultiplier +
                                                                5,
                                                            right: SizeConfig
                                                                .heightMultiplier +
                                                                5),
//
                                                      )):Center(
                                                   child: Text(AppConstants.noInfo,style: AppTheme.descText,),
                                                 ),


//                                            padding: EdgeInsets
//                                                .all(SizeConfig
//                                                .heightMultiplier +
//                                                5),
////
                                                  //  ),
                                                  // ),

                                                  gamesCreatorsDetails != null
                                                      ?

                                                  Container(


                                                      width: SizeConfig
                                                          .widthMultiplier * 97,
                                                      padding: EdgeInsets.all(
                                                          5),

//

                                                      child:
                                                      Text(
                                                        "Platforms he worked on",
                                                        style: AppTheme
                                                            .subText,
                                                        textScaleFactor: 0.9,))
                                                      : Text("Waiting..."),

                                                  gamePlatformWidget(),

                                                  Container(width: SizeConfig
                                                      .widthMultiplier * 97,
                                                      padding: EdgeInsets.all(
                                                          5),

                                                      child:
                                                      Text(
                                                        "His job positions ",
                                                        style: AppTheme
                                                            .subText,
                                                        textScaleFactor: 0.9,)),
                                                  gamePositionWidget(),


                                                ],)
                                            );
                                          }))),
                                  //),


                                      Container(
                                          height: SizeConfig.heightMultiplier*6,

                                          width: SizeConfig
                                      .widthMultiplier * 97,
                                      padding: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),


                                      child:
                                      Text(
                                        "Games created by " +
                                            widget.creatorDetailsArguments.gameName,
                                        style: AppTheme
                                            .subText,
                                        textScaleFactor: 1.1,)),
                                  Container(
                                      height: SizeConfig.heightMultiplier*38,
                                      width: SizeConfig.widthMultiplier * 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .white30)),


                                      child:

                                      FutureBuilder(
                                          future: pageCount != 1
                                              ? restApiClient
                                              .showListOfGamesByCreators("com.gamersgram/1",
                                              widget.creatorDetailsArguments.gameId, pageCount).then((
                                              GameList responses) {
                                            creatorGameList = responses;
                                          })
                                              : restApiClient
                                              .showListOfGamesByCreators("com.gamersgram/1",
                                              widget.creatorDetailsArguments.gameId, pageCount).then((
                                              GameList responses) {
                                            creatorGameList = responses;
                                            int pageCounts =
                                            (responses.count /
                                                responses.results.length).floor();
                                            // print("printcode" + pageCount.toString());
                                            pages = new List();

                                            for (int i = 1; i < pageCounts; i++) {
                                              //  print("pp"+pg.floor().toString());
                                              pages.add(i);
                                            }
                                          }),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (creatorGameList == null) {
                                              return
                                                Container(
                                                    height: SizeConfig
                                                        .heightMultiplier * 20,

                                                    child:

                                                    Center(child: FlareActor(
                                                        'assets/loader.flr',
                                                        alignment: Alignment.center,
                                                        fit: BoxFit.contain,
                                                        animation: "loader"


                                                    )));
                                            }

                                            return Wrap(
                                             // scrollDirection: Axis.vertical,
//
                                             // shrinkWrap: true,
                                              //   padding: EdgeInsets.all(5),

                                              children: <Widget>[
creatorGameList!=null?

                                                gamesByCreatorWidget():Center(child:Text(AppConstants.noInfo,style: AppTheme.descText,)),

//                                            scrollDirection: Axis.vertical,
//                                            ),
                                                creatorGameList!=null?
                                                pages.length != 0
                                                    ? footerWidget()
                                                    : Container(height: 1,):Container(height: 1,),

                                              ],);
                                          })),


//
//                                Container(height: SizeConfig.heightMultiplier*100/2-20,
//                              width: SizeConfig.widthMultiplier*99,
//                                  decoration: BoxDecoration(
//                                      borderRadius:
//                                      BorderRadius
//                                          .all(Radius
//                                          .circular(
//                                          1)),
//                                      border: Border.all(color:
//                                      Colors.white30)
//                                  ),
//
//                                 // padding: EdgeInsets.all(5),
//                              child://
//                              Container(width:SizeConfig.widthMultiplier*97,
//                                //  padding: EdgeInsets.all(7),
//                                  height: SizeConfig.heightMultiplier*100/2-20,
//                                  child:Column(children: <Widget>[
//                                    Container(height: SizeConfig.heightMultiplier+30,
//                                        alignment: Alignment.center,
//                                        padding: EdgeInsets.only(top: 5),
//                                        color: Colors.black,
//                                        child:
//                                    AutoSizeText("Games created by " + widget.creatorName ,
//                                      style: AppTheme.mainTitles,textScaleFactor: 1.3,),
//
//                                    ),
//
//                                    FutureBuilder(
//                                        future: pageCount != 1
//                                            ?
//                                        restApiClient
//                                            .showListOfGamesByCreators(widget.id,pageCount).then((GameList responses) {
//                                          creatorGameList = responses;
//
//                                        })
//                                            :  restApiClient
//                                            .showListOfGamesByCreators(widget.id,pageCount).then((GameList responses) {
//                                          creatorGameList = responses;
//
//                                          if (pageCount != 1) {
//                                            pageCount =
//                                                (responses.count / responses.results.length)
//                                                    .floor();
//                                            //p.add(pageCount);
//                                            // print("printcode 1" + pageCount.toString());
//                                          }
//                                          pageCount =
//                                              (responses.count / responses.results.length)
//                                                  .floor();
//                                          // print("printcode" + pageCount.toString());
//                                          pages = new List();
//
//
//                                          for (int i = 1; i < pageCount; i++) {
//                                            //  print("pp"+pg.floor().toString());
//
//                                            i < pageCount ? pages.add(pageCount) : i;
//                                            // print("PGE COUNt" + pages.length.toString());
//                                          }
//                                        }),
//                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
//                                          if (creatorGameList == null) {
//                                            return   Container(
//                                                height: SizeConfig.heightMultiplier*10,
//                                                child: FlareActor('assets/loader.flr',
//                                                    alignment:Alignment.center, fit:BoxFit.contain, animation:"loader"
//
//
//                                                ));
//                                          }
//                                          return
//                                            Wrap(
////              scrollDirection: Axis.vertical,
////              shrinkWrap: true,
//                                              children: <Widget>[
//
//                                                  Container(
////                                                  height: SizeConfig
////                                                      .heightMultiplier * 60,
//
//                                                      child:
//                                                      gamesByCreatorWidget()),
//
//
//
//
////
////
//
//                                                Container(
//                                                    height: SizeConfig
//                                                        .heightMultiplier * 7,
//
//
//                                                    child:
//                                                    footerWidget()),
//                                              ],
//                                            );
//                                        })
//                                  ],)
//                              ),
//
//                                ),

                                ],),








                          ),


                          )
                        ]))
                  ]));
            });
        });
  }
}
