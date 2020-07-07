import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/tags/ui/AllTagsHomePage.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

//List<GameStores> storeDetailsList;
var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();
int tagId;
//GameGenresDetails gameGenresDetails;

String tagName;
List<int> pages = new List();
int pageDirection;
YoutubeArguments tagWiseGameArguments;
class TagWiseGameList extends StatelessWidget {
    static const routeName = '/TagWiseGameListState';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TagWiseGameListState(
        tagWiseGameArguments: tagWiseGameArguments,),
    );
  }
}

class TagWiseGameListState extends StatefulWidget {
  static Map event;

  TagWiseGameListState(
      {Key key, @required this.tagWiseGameArguments})
      : super(key: key);

final YoutubeArguments tagWiseGameArguments;

  @override
  _TagWiseGameListState createState() => _TagWiseGameListState();
}

class _TagWiseGameListState extends State<TagWiseGameListState> {
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }
  int pageCount = 1;
  int count;
//  Widget gamesByTagsWidget() {
//    var mediaQuery = MediaQuery.of(context);
//    return LayoutBuilder(builder: (context, boxSizing) {
////      var sizingInformation = SizingInformation(
////        orientation: mediaQuery.orientation,
////        deviceType: getDeviceType(mediaQuery),
////        screenSize: mediaQuery.size,
////        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
////      );
////   print("Size info" +sizingInformation.screenSize.toString());
////   print( SizeConfig.heightMultiplier);
//
//      return new Container(
//          color: Color.fromRGBO(21, 21, 21, 10),
//          height: SizeConfig.heightMultiplier * 83,
//          //width: SizeConfig.widthMultiplier*150,
//          child: GridView.builder(
//            padding: EdgeInsets.all(5),
//
//            gridDelegate: mediaQuery.size.height > 640
//                ? SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
//                : SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//
//            // physics: const NeverScrollableScrollPhysics(),
//            scrollDirection: Axis.vertical,
//            shrinkWrap: true,
//            itemCount: tagWiseGameList == null ? 0 : tagWiseGameList.results
//                .length,
//            itemBuilder: (context, index) {
//              return new GestureDetector(
//                  onTap: () {
//                    /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//
//                    //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                    tagWiseGameList.results[index].clip == null
//                        ? Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: tagWiseGameList.results[index].id,
//                              screenShots:
//                              tagWiseGameList.results[index].short_screenshots,
//                              gameName: tagWiseGameList.results[index].name,
//                              released: tagWiseGameList.results[index].released,
//                              rating: tagWiseGameList.results[index].rating,
//                              stores: tagWiseGameList.results[index].stores,
//                              clip: "no",
//                              genres: tagWiseGameList.results[index].genres,
//                              platforms: tagWiseGameList.results[index]
//                                  .platforms,
//                              flag: 1,
//                            )))
//                        : Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              clips:
//                              tagWiseGameList.results[index].clip.clips.full,
//                              gameId: tagWiseGameList.results[index].id,
//                              screenShots:
//                              tagWiseGameList.results[index].short_screenshots,
//                              gameName: tagWiseGameList.results[index].name,
//                              released: tagWiseGameList.results[index].released,
//                              rating: tagWiseGameList.results[index].rating,
//                              stores: tagWiseGameList.results[index].stores,
//                              clip: tagWiseGameList.results[index].clip.clip,
//                              genres: tagWiseGameList.results[index].genres,
//                              platforms: tagWiseGameList.results[index]
//                                  .platforms,
//                              flag: 1,
//                            )));
//                  },
//                  child: AnimationConfiguration.staggeredGrid(
//                      position: index,
//                      duration: const Duration(milliseconds: 375),
//                      columnCount: tagWiseGameList.results.length,
//                      child: ScaleAnimation(
//                          child: FadeInAnimation(
//                              child:
//
//
//                              //Stack(children: <Widget>[
//                              Container(
//                                  height: SizeConfig
//                                      .heightMultiplier *
//                                      12,
//
////                              height: animation.value,
////                              width: animation.value,
//
////                                  padding:
////                                      EdgeInsets.only(right: 5.0, top: 0.5),
//                                  child:
//
//
//                                  Card(
//
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.circular(3)),
//                                      semanticContainer: true,
//                                      color: Color.fromRGBO(32, 32, 32, 5),
//                                      elevation: 10.0,
//                                      child: Container(
////                                        constraints: BoxConstraints(maxHeight:
////                                         SizeConfig
////                                          .heightMultiplier *
////                                          25,),
////                                              height: SizeConfig
////                                                  .heightMultiplier *
////                                                  50,
//
////                                        height:
////                                        SizeConfig.heightMultiplier * 25,
//                                        //  color: Colors.green,
//
////                                        decoration: BoxDecoration(
////                                            border: Border.all(
////                                                color: Colors.white30)),
//
//                                        // width: SizeConfig.widthMultiplier * 33,
//                                        child: Column(
//                                          // shrinkWrap: true,
//                                          mainAxisSize: MainAxisSize.max,
//                                          children: <Widget>[
//
//
//                                            Container(
//
//                                              height: SizeConfig
//                                                  .heightMultiplier *
//                                                  13,
//                                              width: SizeConfig
//                                                  .widthMultiplier *
//                                                  45,
//                                              child:
//                                              tagWiseGameList
//                                                  .results[index]
//                                                  .background_image != null
//                                                  ? CachedNetworkImage(
//                                                imageUrl: tagWiseGameList
//                                                    .results[index]
//                                                    .background_image,
//                                                imageBuilder: (context,
//                                                    imageProvider) =>
//                                                    Container(
//                                                      height: SizeConfig
//                                                          .heightMultiplier *
//                                                          11,
//                                                      width: SizeConfig
//                                                          .widthMultiplier *
//                                                          45,
//                                                      decoration:
//                                                      BoxDecoration(
//                                                        image:
//                                                        DecorationImage(
//                                                          image:
//                                                          imageProvider,
//                                                          fit: BoxFit.cover,
//                                                          //  colorFilter:
//                                                          //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                                                        ),
//                                                      ),
//                                                    ),
//                                                placeholder: (context,
//                                                    url) =>
//                                                    FlareActor(
//                                                        'assets/loader.flr',
//                                                        alignment: Alignment
//                                                            .center,
//                                                        fit: BoxFit.contain,
//                                                        animation: "loader"
//
//
//                                                    ),
//                                                errorWidget: (context,
//                                                    url, error) =>
//                                                    Icon(Icons.error),
//                                              )
//                                                  : Text("No mage found"),
//                                            ),
//
////                                              Expanded(
////                                                  flex: 1,
////                                                  child:
//
//                                            Divider(color: Colors.white30,
//                                              thickness: 0.5,
//                                              height: 1.2,),
//
//                                            Expanded(child:
//
//                                            Container(
//                                              // color: Colors.white30,
////                                              height:
////                                                  SizeConfig.heightMultiplier *
////                                                      5,
//                                              width:
//                                              SizeConfig.widthMultiplier *
//                                                  45,
//                                              padding: EdgeInsets.all(5),
//                                              // alignment: Alignment.topLeft,
//                                              child: Text(
//                                                '${tagWiseGameList
//                                                    .results[index].name}',
//                                                style: AppTheme.textGridTitle,
//                                                textScaleFactor: 1.3,
//                                                softWrap: true,
//                                              ),
//                                            )),
//                                            //),
//                                          ],
//                                        ),
//                                      ))
//
//                                //)
////                            ])
//
//
//                              )))));
//            },
//          ));
//    });
//  }




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
  GameList tagWiseGameList;

  @override
  Widget build(BuildContext context) {

    Widget tagWiseGamesWidget() {
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
              ? SizeConfig.heightMultiplier * 89
              : SizeConfig.heightMultiplier * 79,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            //  physics: const ScrollPhysics(),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: tagWiseGameList == null ? 0 : tagWiseGameList.results
                .length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */


                    print("FLAG" +widget.tagWiseGameArguments.flag.toString());
                    print("ID"+widget.tagWiseGameArguments.tagId.toString());
                    print("name"+widget.tagWiseGameArguments.tagName.toString());

                    YoutubeArguments tagArguments =

                //    widget.tagWiseGameArguments.gameId!=2?

                    new YoutubeArguments(
                      flag: 6,
                      tagId: widget.tagWiseGameArguments.tagId,
                      tagName: widget.tagWiseGameArguments.tagName ,

                      gameName:tagWiseGameList.results[index].name!=null? tagWiseGameList.results[index].name:AppConstants.noInfo
                      ,gameId: tagWiseGameList.results[index].id!=null?tagWiseGameList.results[index].id:AppConstants.noInfo,

                      screenShots: tagWiseGameList.results[index].short_screenshots!=null?
                      tagWiseGameList.results[index].short_screenshots:AppConstants.noInfo,
                      //clip:tagWiseGameList.results[index].clip.clip!=null?tagWiseGameList.results[index].clip.clip:AppConstants.noInfo,
                      description: tagWiseGameList.results[index].description!=null? tagWiseGameList.results[index].description:AppConstants.noInfo,
                      genres: tagWiseGameList.results[index].genres!=null? tagWiseGameList.results[index].genres:AppConstants.noInfo,
                      platforms: tagWiseGameList.results[index].platforms!=null?tagWiseGameList.results[index].platforms:AppConstants.noInfo,
                      rating: tagWiseGameList.results[index].rating!=null? tagWiseGameList.results[index].rating:AppConstants.noInfo,
                      website: tagWiseGameList.results[index].website!=null?tagWiseGameList.results[index].website:AppConstants.noInfo,
                      released: tagWiseGameList.results[index].released!=null? tagWiseGameList.results[index].released:AppConstants.noInfo,
                        stores:  tagWiseGameList.results[index].stores!="Null"? tagWiseGameList.results[index].stores:AppConstants.noInfo,
                    )
//
//                        :new YoutubeArguments(
//                      gameName: widget.tagWiseGameArguments.gameName,
//
//                        gameId: widget.tagWiseGameArguments.gameId)

                    ;

                    Navigator.pushNamed(context, GameDetails.routeName,arguments: tagArguments);
                    


                    //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                    tagWiseGameList.results[index].clip == null
//                        ? Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: tagWiseGameList.results[index].id,
//                              screenShots:
//                              tagWiseGameList.results[index].short_screenshots,
//                              gameName: tagWiseGameList.results[index].name,
//                              released: tagWiseGameList.results[index].released,
//                              rating: tagWiseGameList.results[index].rating,
//                              stores: tagWiseGameList.results[index].stores,
//                              clip: "no",
//                              genres: tagWiseGameList.results[index].genres,
//                              platforms: tagWiseGameList.results[index].platforms,
//                              flag: 1,
//                            )))
//                        : Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              clips:
//                              tagWiseGameList.results[index].clip.clips.full,
//                              gameId: tagWiseGameList.results[index].id,
//                              screenShots:
//                              tagWiseGameList.results[index].short_screenshots,
//                              gameName: tagWiseGameList.results[index].name,
//                              released: tagWiseGameList.results[index].released,
//                              rating: tagWiseGameList.results[index].rating,
//                              stores: tagWiseGameList.results[index].stores,
//                              clip: tagWiseGameList.results[index].clip.clip,
//                              genres: tagWiseGameList.results[index].genres,
//                              platforms: tagWiseGameList.results[index].platforms,
//                              flag: 1,
//                            )));
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: tagWiseGameList.results.length,
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
                                    tagWiseGameList.results[index]
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
                                        imageUrl: tagWiseGameList
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
                                            6.7,
                                        width: SizeConfig
                                            .widthMultiplier *
                                            34,
                                        padding: EdgeInsets.only(
                                            left: 1 * SizeConfig.heightMultiplier,
                                            top: 2),
                                        child: Text(
                                          tagWiseGameList.results[index].name,
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

    //  print("url"+widget.clip);

    print("image   widget widget widget  " + widget.tagWiseGameArguments.tagId.toString());
    print("image   widget widget tagNametagName  " + widget.tagWiseGameArguments.tagName.toString());

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(
              backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                bottomNavigationBar:widget.tagWiseGameArguments.tagId!=0?FutureBuilder(
                    future: restApiClient
                        .showListOfGamesByTags("com.gamersgram/1",pageCount, widget.tagWiseGameArguments.tagId)
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
                    }):Container(height: 2,),

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
//                      Column(
//                        children: <Widget>[

                      //    snapshot.connectionState == ConnectionState.done ?
//                                                Column(
//
////                                  crossAxisAlignment: CrossAxisAlignment.start,
////                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//
//
//                    children: <Widget>[

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

                                              size: 6 * SizeConfig
                                                  .imageSizeMultiplier,
                                            ),
                                          )
                                        ],),
                                        onTap: () {
                                          widget.tagWiseGameArguments.flag == 2
                                              ?

                                          Navigator.pushNamed(context,
                                              AllTagsHomePage.routeName)
                                              : Navigator.pushNamed(context,

                                              '/');
                                        },
                                      )),
                                  Container(
                                      width: SizeConfig.widthMultiplier * 80,

                                      alignment: Alignment.center,
                                      child:
                                      Text(widget.tagWiseGameArguments.tagName,
                                        style: AppTheme.mainTitles,
                                        textScaleFactor: 1.2,)),


                                ],))),
                      FutureBuilder(
                          future: pageCount != 1
                              ? restApiClient
                              .showListOfGamesByTags("com.gamersgram/1",pageCount, widget.tagWiseGameArguments.tagId)
                              .then((GameList responses) {
                            tagWiseGameList = responses;
                          })
                              : restApiClient
                              .showListOfGamesByTags("com.gamersgram/1",1, widget.tagWiseGameArguments.tagId)
                              .then((GameList responses) {
                            tagWiseGameList = responses;
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
                            if (tagWiseGameList == null) {
                              return
                                Container(
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


                                tagWiseGamesWidget(),
//                                pages.length != 0
//                                    ? footerWidget()
//                                    : Container(),

                              ],);
                          }),

//                        ],
//                      ),
                      //])
                    ]))
              ]));
        },
      );
    });
  }
}
