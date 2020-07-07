import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/ui/CreatorHomePage.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';

import 'package:gamersgram/genres/ui/GenresHomePage.dart';
import 'package:gamersgram/platforms/ui/PlatformHomePage.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/stores/ui/StoresHomePage.dart';
import 'package:gamersgram/tags/details/TagWiseGameList.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/footerwidget.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_share/flutter_share.dart';

//import 'package:flutter_html/flutter_html.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:webview_flutter/webview_flutter.dart';

var dio = new Dio()
  ..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
List<Screenshots> screenShots;
String released;
double rating;
List<Stores> stores;
String clip;
List<Genres> genres;
List<Platforms> platforms;
int flag;
int gameId;
String description;
String clips;
GameRequirements systemRequirement;
String website;
Clip cl;
YoutubeArguments user;
//VideoPlayerController _controller;
//Future<void> _initializeVideoPlayerFuture;
//GameList gameDetails;

class GameDetails extends StatelessWidget {
  static const String routeName="/GameDetailsStates";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameDetailsStates(
        user: user,
//        screenShots: screenShots,
//        gameName: "gameName",
//        released: released,
//        rating: rating,
//        stores: stores,
//        clip: clip,
//        genres: genres,
//        platforms: platforms,
//        flag: flag,
//        gameId: gameId,
//        description: description,
//        systemRequirement: systemRequirement,
//        website: website,
      ),
    );
  }
}

// ignore: must_be_immutable
class GameDetailsStates extends StatefulWidget {
  static Map event;

  GameDetailsStates(
      {Key key,
        @required this.user,
//      @required this.screenShots,
//      @required this.gameName,
//      @required this.released,
//      @required this.platforms,
//      @required this.rating,
//      @required this.clip,
//      @required this.stores,
//      @required this.genres,
//        @required this.gameId,
//        @required this.description,
//        @required this.clips,
//        @required this.systemRequirement,
//        @required this.website,
      @required flag})
      : super(key: key);

  //final String clip;
//  final List<Screenshots> screenShots;
//  final String gameName;
//  final Map<dynamic, dynamic> map = event;
//  final String released;
//  final double rating;
//  final List<Stores> stores;
//  final String clip;
//  final List<Genres> genres;
//  final List<Platforms> platforms;
//  final int flag = 1;
//  int gameId;
//  final GameRequirements systemRequirement;
//  final String description;
//  final String clips;
//  final String website;
  final YoutubeArguments user;

  @override
  _GameDetailsStatesState createState() => _GameDetailsStatesState();
}

class _GameDetailsStatesState extends State<GameDetailsStates>
    with SingleTickerProviderStateMixin {
  bool startedPlaying = false;

  Future<void> _initializeVideoPlayerFuture;
  Future<void> _initializeFullVideoPlayerFuture;

  TabController _gameTabController;


  @override
  void initState() {
//   if(widget.user.flag!=1 && widget.user.clip!=null)
    // print(widget.user.clip);

//if(widget.user.flag==1)
//  {
//        _controller = VideoPlayerController.network(
//      "",
//    );
//  }
//else
//  {
//        _controller = VideoPlayerController.network(
//      widget.user.clip,
//    );
//  }


//    _shortVideoController = VideoPlayerController.network(
//      widget.user.clip,
//    );
//    _shortVideoController.addListener(() {
//      if (startedPlaying && !_shortVideoController.value.isPlaying) {
//        Navigator.pop(context);
//      }
//    });
//    print(widget.user.flag);
//    if (widget.user.clip != null) {
//      _shortVideoController = VideoPlayerController.network(
//        widget.user.clip,
//      );
//
//      // Initielize the controller and store the Future for later use.
//      _initializeVideoPlayerFuture = _shortVideoController.initialize();
//
//      // Use the controller to loop the video.
//      _shortVideoController.setLooping(true);
//    }
//
//    if (widget.user.clips != null) {
//      _fullVideoController = VideoPlayerController.network(
//        widget.user.clips,
//      );
//      _fullVideoController.addListener(() {
//        setState(() {});
//      });
//      _fullVideoController.setLooping(true);
//      _fullVideoController.initialize().then((_) => setState(() {}));
//      _fullVideoController.play();
//      // Initielize the controller and store the Future for later use.
//      _initializeFullVideoPlayerFuture = _fullVideoController.initialize();
//
//      // Use the controller to loop the video.
//      _fullVideoController.setLooping(true);
//    }
//    restApiClient
//        .showListOfGamesTrailers(widget.user.gameId)
//        .then((GameTrailersPOJO responses) {
//      gameTrailersPOJOLv = responses;
//     /// gameTrailersList.add(responses);
//      // print("Videos" + gameTrailersList[0].results[0].data.max);
//      print("Videos 1tt" + gameTrailersList.length.toString());
//    });
    super.initState();
    _gameTabController = new TabController(length: 4, vsync: this);
  }


  Widget gamePlatformWidget() {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 2),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Directionality(
                textDirection: TextDirection.ltr,
                child: new Container(
                    height: SizeConfig.heightMultiplier * 4,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.user.platforms == null
                            ? 0
                            : widget.user.platforms.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              //columnCount:  widget.user.platforms.length,
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: Container(
//                                      height: 50,
//                                      width: 100,
//                              height: animation.value,
//                              width: animation.value,

                                        padding: EdgeInsets.only(
                                            left: 2.0, right: 2.0, top: 0.5),
                                        child: Wrap(
                                          children: <Widget>[
                                    Text(
                                      widget.user.platforms[index].platform.name +
                                          ",",
                                      style: AppTheme.subTitleLights,
                                      textScaleFactor: 1.2,
                                    ),
                                          ],
                                        ),
                                      ))));
                        })))
          ],
        ));
  }

  Widget gameGenresWidget() {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 2),
        alignment: Alignment.topLeft,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: new Container(
                height: SizeConfig.heightMultiplier * 4,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.user.genres == null ? 0 : widget.user.genres.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          //columnCount:  widget.user.platforms.length,
                          child: ScaleAnimation(
                              child: FadeInAnimation(
                                  child: Container(
//                                      height: 50,
//                                      width: 100,
//                              height: animation.value,
//                              width: animation.value,

                                      padding: EdgeInsets.only(
                                          left: 2.0, right: 2.0, top: 0.5),
                                      child: Wrap(children: <Widget>[
                                        Text(
                                          widget.user.genres[index].name + ",",
                                          style: AppTheme.subTitleLights,
                                          textScaleFactor: 1.2,
                                        ),
                                      ])))));
                    }))));
  }

  Widget gameStoresWidget() {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 2),
        alignment: Alignment.topLeft,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: new Container(
                height: 40.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.user.stores == null ? 0 : widget.user.stores.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          //columnCount:  widget.user.platforms.length,
                          child: ScaleAnimation(
                              child: FadeInAnimation(
                                  child: Container(
                                    // height: 50,
                                      //width: 100,
//                              height: animation.value,
//                              width: animation.value,

                                      padding: EdgeInsets.only(
                                          left: 2.0, right: 2.0, top: 0.5),
                                      child: Wrap(children: <Widget>[
                                        Text(
                                          widget.user.stores[index].store.name ,
                                          style: AppTheme.subTitleLights,
                                          textScaleFactor: 1.2,
                                        )
                                            //:Container(),
                                      ])))));
                    }))));
  }


//  Widget newGameTrailer() {
//    return
//      Center(
//        child: FutureBuilder<bool>(
//          future: started(),
//          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//            if (snapshot.data == true) {
//              return AspectRatio(
//                aspectRatio: _shortVideoController.value.aspectRatio,
//                child: VideoPlayer(_shortVideoController),
//              );
//            } else {
//              return const Text('waiting for video to load');
//            }
//          },
//        ),
//      );
//  }
//  Widget gameFullTrailerWidget() {
//    return Column(
//      children: <Widget>[
//        widget.user.clip != null
//            ? FutureBuilder(
//                future: _initializeVideoPlayerFuture,
//                builder: (context, snapshot) {
//                  if (snapshot.connectionState == ConnectionState.done) {
//                    // If the VideoPlayerController has finished initialization, use
//                    // the data it provides to limit the aspect ratio of the video.
//                    return AspectRatio(
//                      aspectRatio: _shortVideoController.value.aspectRatio,
//                      // Use the VideoPlayer widget.user.to display the video.
//                      child: VideoPlayer(_shortVideoController),
//                    );
//                  } else {
//                    // If the VideoPlayerController is still initializing, show a
//                    // loading spinner.
//                    return Container(
//                        height: SizeConfig.heightMultiplier * 10,
//                        child: Center(
//                            child: FlareActor('assets/loader.flr',
//                                alignment: Alignment.center,
//                                fit: BoxFit.contain,
//                                animation: "loader")));
//                  }
//                },
//        )
//            : Text("Trialer not avalible"),
//        ListView(
//          shrinkWrap: true,
//          children: <Widget>[
//            Stack(
//              children: <Widget>[
//                Container(
//                    alignment: Alignment.bottomCenter,
//                    child: ButtonTheme(
//                        child: RaisedButton(
//                          padding: EdgeInsets.all(10.0),
//                          color: Colors.transparent,
//                          textColor: Colors.white,
//                          onPressed: () {
//                            // Wrap the play or pause in a call to `setState`. This ensures the
//                            // correct icon is shown.
//                            setState(() {
//                              // If the video is playing, pause it.
//                              if (_shortVideoController.value.isPlaying) {
//                                _shortVideoController.pause();
//                              } else {
//                                // If the video is paused, play it.
//                                _shortVideoController.play();
//                              }
//                            });
//                          },
//                          child: Icon(
//                            _shortVideoController.value.isPlaying
//                                ? Icons.pause
//                                : Icons.play_arrow,
//                            size: 30.0,
//                          ),
//                        )))
//              ],
//            ),
//          ],
//        )
//      ],
//    );
//  }

//  Widget gameShortTrailerWidget() {
//    return Column(
//      children: <Widget>[
//        widget.user.clips != null
//            ? FutureBuilder(
//          future: _initializeFullVideoPlayerFuture,
//          builder: (context, snapshot) {
//            if (snapshot.connectionState == ConnectionState.done) {
//              // If the VideoPlayerController has finished initialization, use
//              // the data it provides to limit the aspect ratio of the video.
//
//              return AspectRatio(
//                aspectRatio: _fullVideoController.value.aspectRatio,
//                      // Use the VideoPlayer widget.user.to display the video.
//                child: VideoPlayer(_fullVideoController),
//                    );
//                  } else {
//                    // If the VideoPlayerController is still initializing, show a
//                    // loading spinner.
//              return Center(
//                  child: FlareActor('assets/loader.flr',
//                      alignment: Alignment.center,
//                      fit: BoxFit.contain,
//                      animation: "loader"));
//                  }
//                },
//              )
//            : Text("Trialer not avalible"),
//        ListView(
//          shrinkWrap: true,
//          children: <Widget>[
//            Stack(
//              children: <Widget>[
//                Container(
//                    alignment: Alignment.bottomCenter,
//                    child: ButtonTheme(
//                        child: RaisedButton(
//                          padding: EdgeInsets.all(10.0),
//                          color: Colors.transparent,
//                          textColor: Colors.white,
//                          onPressed: () {
//                            // Wrap the play or pause in a call to `setState`. This ensures the
//                            // correct icon is shown.
//                            setState(() {
//                              // If the video is playing, pause it.
//                              if (_fullVideoController.value.isPlaying) {
//                                _fullVideoController.pause();
//                              } else {
//                                // If the video is paused, play it.
//                                _fullVideoController.play();
//                              }
//                            });
//                          },
//                          child: Icon(
//                            _fullVideoController.value.isPlaying
//                                ? Icons.pause
//                                : Icons.play_arrow,
//                            size: 30.0,
//                          ),
//                        )))
//              ],
//            ),
//          ],
//        )
//      ],
//    );
//  }

  Widget buttonDemo() {
  final basicSlider = CarouselSlider(
      items: widget.user.screenShots.map(
            (index) {
          return Container(
            height: SizeConfig.heightMultiplier * 11,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: index.image!=null ? CachedNetworkImage(
                  imageUrl: index.image,
                  imageBuilder: (context, imageProvider) =>
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
                  (Container(
                      height: SizeConfig.heightMultiplier * 10,
                      child: Center(
                          child: FlareActor(
                            'assets/loader.flr',
                            //  animation:
//              "circle"
                          )))),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ):Center(child:Text("No images available :(")),)
          );
        },
      ).toList(),
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      initialPage: 2,
    );
    return Column(children: [
      basicSlider,
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: SizeConfig.heightMultiplier * 7,
          width: SizeConfig.widthMultiplier * 15,
          alignment: Alignment.center,
          color: Colors.black12,

          child:

          RaisedButton(

            color: Colors.black12,
            elevation: 4,
            onPressed: () =>
                basicSlider.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear),
            child: Icon(Icons.arrow_back_ios, color: Colors.white,),
          ),
        ),
//        Card(
//            color: Colors.black38,
//            elevation: 11,
//
//            child:
        Container(
          height: SizeConfig.heightMultiplier * 7,
          width: SizeConfig.widthMultiplier * 15,
          alignment: Alignment.center,
          color: Colors.black12,

          child: RaisedButton(

            color: Colors.black12,
            elevation: 4,
            onPressed: () =>
                basicSlider.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear),
            child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
          ),
        ),
//        ...Iterable<int>.generate(widget.user.screenShots.length).map(
//              (int pageIndex) =>
//              Flexible(
//                child: Container(
//                  padding: EdgeInsets.only(
//                    left: 2.0, right: 2.0,),
//
//                  child: RaisedButton(
//                    onPressed: () =>
//                        basicSlider.animateToPage(pageIndex,
//                            duration: Duration(milliseconds: 300),
//                            curve: Curves.linear),
//                    child: Text("$pageIndex", style: AppTheme.subTitleLights,),
//                    color: Colors.black38,
//
//                  ),
//
//                ),
//              ),
//        ),
      ]),
    ]);
  }

  GameList suggestedGames;
  GameList gameSeries;
  GameListDetails gameDetailRequirements;
  GameListDetails gameDescription;
  //youtubeVideosOfGamePOJO youtubeAssociatedWithGamePOJO;
  @override
  Widget build(BuildContext context) {

    print("Game id"+widget.user.gameId.toString());
   // print("Screenshot enght" + widget.user.screenShots.length.toString());

    Future<void> shareFile() async {
  //    List<dynamic> docs = await DocumentsPicker.pickDocuments;
      if (widget.user.screenShots[0].image == null || widget.user.screenShots[0].image.isEmpty) return null;

      await FlutterShare.shareFile(
        title: widget.user.gameName,
        text: 'Chek out this cool game',
        filePath: widget.user.screenShots[0].image,
      );
    }
//
//    _launchURL() async {
//      const url = 'https://rawg.io/';
//      if (await canLaunch(url)) {
//        await launch(url);
//      } else {
//        throw 'Could not launch $url';
//      }
//    }

    Future<void> shareMixed() async {
      print("clickedmixxxxxx"+widget.user.screenShots[0].image);
      try {
       // if(widget.user.screenShots[0].image!=null) {

        var request = await HttpClient().getUrl(Uri.parse(
            widget.user.screenShots[0].image));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);

          //  }
      //  await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');

        
        Share.text(widget.user.gameName ,"Check out this cool game on" +user.platforms[0].platform.name, "text");
//        await Share.files(
//            'esys images',
//            {
//             // 'esys.png': bytes.buffer.asUint8List(),
//            //  'bluedan.png': bytes2.buffer.asUint8List(),
//             // 'addresses.csv': bytes3.buffer.asUint8List(),
//            },
//
//            '*/*', text:"Check out this cool game :)" + widget.user.gameName  +"on "  + widget.user.platforms[0].platform.name );
      } catch (e) {
        print('errggfhgfhfhfhfhor: $e');
      }
    }
    Widget seriesOfGamesListWidget(GameList seriesOfGameDetails) {
      //  var mediaQuery = MediaQuery.of(context);

      return new Container(
          color: Color.fromRGBO(21, 21, 21, 10),
          height: SizeConfig.heightMultiplier * 40,
          //width: SizeConfig.widthMultiplier*150,
          child: GridView.builder(
            padding: EdgeInsets.all(5),

            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),

            // physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: seriesOfGameDetails == null ? 0 : seriesOfGameDetails.results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {

                    YoutubeArguments seriesArguments = new YoutubeArguments(
                      gameName:seriesOfGameDetails.results[index].name!=null? seriesOfGameDetails.results[index].name:AppConstants.noInfo
                      ,gameId: seriesOfGameDetails.results[index].id!=null?seriesOfGameDetails.results[index].id:AppConstants.noInfo,

                      screenShots: seriesOfGameDetails.results[index].short_screenshots!=null?
                      seriesOfGameDetails.results[index].short_screenshots:AppConstants.noInfo,
                      //clip:seriesOfGameDetails.results[index].clip.clip!=null?seriesOfGameDetails.results[index].clip.clip:AppConstants.noInfo,
                      description: seriesOfGameDetails.results[index].description!=null? seriesOfGameDetails.results[index].description:AppConstants.noInfo,
                      genres: seriesOfGameDetails.results[index].genres!=null? seriesOfGameDetails.results[index].genres:AppConstants.noInfo,
                      platforms: seriesOfGameDetails.results[index].platforms!=null?seriesOfGameDetails.results[index].platforms:AppConstants.noInfo,
                      rating: seriesOfGameDetails.results[index].rating!=null? seriesOfGameDetails.results[index].rating:AppConstants.noInfo,
                      website: seriesOfGameDetails.results[index].website!=null?seriesOfGameDetails.results[index].website:AppConstants.noInfo,
                      released: seriesOfGameDetails.results[index].released!=null? seriesOfGameDetails.results[index].released:AppConstants.noInfo,
                      stores:  seriesOfGameDetails.results[index].stores!="Null"? seriesOfGameDetails.results[index].stores:AppConstants.noInfo,
                    );
                    Navigator.pushNamed(context, "/GameDetailsStates",arguments: seriesArguments);

//                    seriesOfGameDetails.results[index].clip == null
//                        ? Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: seriesOfGameDetails.results[index].id,
//                              screenShots: seriesOfGameDetails
//                                  .results[index].short_screenshots,
//                              gameName: seriesOfGameDetails.results[index].name,
//                              released:
//                              seriesOfGameDetails.results[index].released,
//                              rating: seriesOfGameDetails.results[index].rating,
//                              stores: seriesOfGameDetails.results[index].stores,
//                              clip: "no",
//                              genres: seriesOfGameDetails.results[index].genres,
//                              platforms:
//                              seriesOfGameDetails.results[index].platforms,
//                              flag: 1,
//                              website: seriesOfGameDetails.results[index].website,
//                            )))
//                        : Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            GameDetailsStates(
//                              gameId: seriesOfGameDetails.results[index].id,
//                              screenShots: seriesOfGameDetails
//                                  .results[index].short_screenshots,
//                              gameName: seriesOfGameDetails.results[index].name,
//                              released:
//                              seriesOfGameDetails.results[index].released,
//                              rating: seriesOfGameDetails.results[index].rating,
//                              stores: seriesOfGameDetails.results[index].stores,
//                              clip: seriesOfGameDetails.results[index].clip.clip,
//                              genres: seriesOfGameDetails.results[index].genres,
//                              platforms:
//                              seriesOfGameDetails.results[index].platforms,
//                              flag: 1,
//                              description:
//                              seriesOfGameDetails.results[index].description,
//                              website: seriesOfGameDetails.results[index].website,
//
//                              // systemRequirement: seriesOfGameDetails
//                              //.results[index].platforms[index].requirements,
//                            )));



                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                    //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: seriesOfGameDetails.results.length,
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
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    seriesOfGameDetails.results[index]
                                        .background_image !=
                                        null
                                        ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                      height:
                                      SizeConfig.imageSizeMultiplier * 18,
                                      width: SizeConfig.widthMultiplier * 34,

                                      child: CachedNetworkImage(
                                        imageUrl: seriesOfGameDetails
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
                                      SizeConfig.imageSizeMultiplier * 18,
                                      width: SizeConfig.widthMultiplier * 34,
                                      child: Center(
                                          child: Text(
                                            "No Image available",
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
                                        height: SizeConfig.heightMultiplier *
                                            7.8,
                                        width: SizeConfig.widthMultiplier * 34,
                                        padding: EdgeInsets.only(
                                            left: 1 *
                                                SizeConfig.heightMultiplier,
                                            top: 2),
                                        child: Text(
                                          seriesOfGameDetails.results[index].name,
                                          style: AppTheme.subTitleLights,
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
    }


//
//    Future<bool> onBackPressed(String url) {
//      return showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              title: Text('Are you sure?'),
//              content: Text('You are going to exit the application!!'),
//              actions: <Widget>[
//
//                      WebView(
//                        initialUrl:url,
//                        gestureRecognizers: Set()
//                          ..add(Factory<VerticalDragGestureRecognizer>(
//                                  () => VerticalDragGestureRecognizer())),
//                      ),
//
//                FlatButton(
//                  child: Text('YES'),
//                  onPressed: () {
//                    Navigator.of(context).pop(true);
//                  },
//                ),
//              ],
//            );
//          });
//    }
//
//
//

//    Widget youTubeReviewsOfTheGamesWidget() {
//      //  var mediaQuery = MediaQuery.of(context);
//
//      return new Container(
//          color: Color.fromRGBO(21, 21, 21, 10),
//          height: SizeConfig.heightMultiplier * 50,
//          width: SizeConfig.widthMultiplier * 98,
//          child: ListView.builder(
//            // padding: EdgeInsets.all(5),
//
//            //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//
//            // physics: const NeverScrollableScrollPhysics(),
//            scrollDirection: Axis.vertical,
//            shrinkWrap: true,
//            itemCount: youtubeAssociatedWithGamePOJO == null
//                ? 0
//                : youtubeAssociatedWithGamePOJO.results.length,
//            itemBuilder: (context, index) {
//              return new GestureDetector(
//                  onTap: () {
//
////                    Navigator.of(context).pushNamedAndRemoveUntil('/',
////                            (Route<dynamic> route) => false);
//
//                  List<Object>args=new List();
//                  args.addAll(youtubeAssociatedWithGamePOJO.results);
//                  print("sending game id" +widget.user.gameId.toString());
//                  List<GameDevelopers>gd;
//
////
////                  this.id, this.name, this.description, this.released,
////                    this.background_image, this.rating, this.clip, this.genres,
////                    this.short_screenshots, this.stores, this.platforms, this.developers,
////                    this.website
//
//                    YoutubeArguments user = new YoutubeArguments(gameName: widget.user.gameName,gameId: widget.user.gameId,externel_id:
//
//                    youtubeAssociatedWithGamePOJO.results[index].external_id,
//                      channel_name: youtubeAssociatedWithGamePOJO.results[index].channel_title,
//                      screenShots: widget.user.screenShots,
//                      clip: widget.user.clips,
//                      description: widget.user.description,
//                      genres: widget.user.genres,
//                      platforms: widget.user.platforms,
//                      rating: widget.user.rating,
//                      website: widget.user.website,
//                      released: widget.user.released,
//                      stores: widget.user.stores
//                    );
//
//                  Navigator.of(context).pushNamed("/GameYoutubePlayerStates",arguments:user
//
//
//                  );
////                    Navigator.of(context).push(MaterialPageRoute(
////                        builder: (context) =>
////                            GameYoutubePlayerStates(
////                              external_id: youtubeAssociatedWithGamePOJO
////                                  .results[index].external_id,
////                              channel_id: youtubeAssociatedWithGamePOJO
////                                  .results[index].channel_title,
////                              gameName: widget.user.gameName,
////                              clip: widget.user.iclp,
////                              description: widget.user.description,
////                              gameId: widget.user.gameId,
////                              genres: widget.user.genres,
////                              screenShots: widget.user.screenShots,
////                              stores: widget.user.stores,
////                              platforms: widget.user.platforms,
////                              rating: widget.user.rating,
////                              released: widget.user.released,
////                              website: widget.user.website,
////
////
////                            )));
//                    //   onBackPressed("https://www.youtube.com/user/MM7Games/");
//                    /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//
//                    //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                  },
//                  child: AnimationConfiguration.staggeredGrid(
//                      position: index,
//                      duration: const Duration(milliseconds: 375),
//                      columnCount: youtubeAssociatedWithGamePOJO.results.length,
//                      child: ScaleAnimation(
//                          child: FadeInAnimation(
////
//                              child: Container(
//                                  height: SizeConfig.heightMultiplier * 25,
//                                  width: SizeConfig.widthMultiplier * 98,
//                                  decoration: BoxDecoration(
//                                      border:
//                                      Border.all(color: Colors.white30)),
//////                                padding: EdgeInsets.only(
////                                    left: 1 * SizeConfig.heightMultiplier,
////                                    right: 1 * SizeConfig.heightMultiplier,
////                                    bottom: 1 * SizeConfig.heightMultiplier),
//                                  child: Column(
//                                    //mainAxisSize: MainAxisSize.min,
//                                      children: <Widget>[
//
//                                    Container(
//                                        height: SizeConfig.heightMultiplier *
//                                            15,
//                                        width: SizeConfig.widthMultiplier * 98,
//
//
//                                        child:
//
//                                        Row(
//                                          children: <Widget>[
//                                            Container(
//                                              height:
//                                              SizeConfig.heightMultiplier *
//                                                  15,
//                                              width:
//                                              SizeConfig.widthMultiplier *
//                                                  30,
//                                              child:
//                                              youtubeAssociatedWithGamePOJO
//                                                  .results[index]
//                                                  .thumbnails
//                                                  .medium
//                                                  .url !=
//                                                  null
//                                                  ? CachedNetworkImage(
//                                                imageUrl:
//                                                youtubeAssociatedWithGamePOJO
//                                                    .results[
//                                                index]
//                                                    .thumbnails
//                                                    .medium
//                                                    .url,
//                                                imageBuilder: (context,
//                                                    imageProvider) =>
//                                                    Container(
//                                                      decoration:
//                                                      BoxDecoration(
//                                                        image:
//                                                        DecorationImage(
//                                                          image:
//                                                          imageProvider,
//                                                          fit: BoxFit
//                                                              .cover,
//                                                          //  colorFilter:
//                                                          //    ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                                                        ),
//                                                      ),
//                                                    ),
//                                                placeholder: (context, url) =>
//                                                    Container(
//                                                        height: SizeConfig
//                                                            .heightMultiplier *
//                                                            15,
//                                                        alignment:
//                                                        Alignment
//                                                            .center,
//                                                        child: FlareActor(
//                                                            'assets/loader.flr',
//                                                            alignment:
//                                                            Alignment
//                                                                .center,
//                                                            fit: BoxFit
//                                                                .contain,
//                                                            animation:
//                                                            "loader")),
//                                                errorWidget: (context,
//                                                    url, error) =>
//                                                    Icon(Icons.error),
//                                              )
//                                                  : Container(
//                                                decoration: BoxDecoration(
//                                                    border: Border.all(
//                                                        color: Colors
//                                                            .white30)),
////                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
////                                                      bottom: 1 * SizeConfig.heightMultiplier),
//
////                height: SizeConfig
////                    .imageSizeMultiplier *
////                    18,
////                width: SizeConfig
////                    .widthMultiplier *
////                    34,
//                                                child: Center(
//                                                    child: Text(
//                                                      "No Image avaliable",
//                                                      style: AppTheme
//                                                          .subTitleLights,
//                                                      textScaleFactor:
//                                                      0.9,
//                                                    )),
//                                              ),
//
//                                              alignment: Alignment.topLeft,
////                     height: SizeConfig.heightMultiplier*20,
////                     width: SizeConfig.widthMultiplier*20,
//                                            ),
//                                            Container(
//                                              padding: EdgeInsets.all(
//                                                  SizeConfig.heightMultiplier),
////                                              height:
////                                                  SizeConfig.heightMultiplier *
////                                                      25,
////                                              width:
////                                                  SizeConfig.widthMultiplier *
////                                                      60,
//                                              alignment: Alignment.topLeft,
//                                              child: Column(
//                                                children: <Widget>[
//                                                  Container(
////                                            height: SizeConfig
////                                                .heightMultiplier *
////                                                7.8,
//                                                    width: SizeConfig
//                                                        .widthMultiplier *
//                                                        60,
////                                            padding: EdgeInsets.only(
////                                                left: 1 * SizeConfig.heightMultiplier,
////                                                top: 2),
//                                                    child: Text("Name :" +
//                                                        youtubeAssociatedWithGamePOJO
//                                                            .results[index]
//                                                            .name,
//                                                      style: AppTheme
//                                                          .mainTitles,
//                                                      //  textAlign: TextAlign.center,
//                                                    ),
//                                                  ),
//                                                  Divider(height: 5,
//                                                    thickness: 1,
//                                                    color: Colors.white12,),
//                                                  Container(
//                                                    alignment: Alignment
//                                                        .topLeft,
////
////                                            height: SizeConfig
////                                                .heightMultiplier *
////                                                7.8,
//                                                    width: SizeConfig
//                                                        .widthMultiplier *
//                                                        60,
////                                            padding: EdgeInsets.only(
////                                                left: 1 * SizeConfig.heightMultiplier,
////                                                top: 2),
//                                                    child: Text(
//                                                      "Channel Name :" +
//                                                          youtubeAssociatedWithGamePOJO
//                                                              .results[index]
//                                                              .channel_title,
//                                                      style: AppTheme
//                                                          .mainTitles,
//                                                      //  textAlign: TextAlign.center,
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                            )
//                                          ],
//                                        )),
//
//
//                                        Container(
//                                          padding: EdgeInsets.all(
//                                              SizeConfig.heightMultiplier),
//
//                                          alignment: Alignment.topLeft,
//                                          height: SizeConfig.widthMultiplier *
//                                              11,
//                                          width: SizeConfig.widthMultiplier *
//                                              98,
//                                          child:
//                                          youtubeAssociatedWithGamePOJO
//                                              .results[index]
//                                              .description !=
//                                              null
//                                              ?
//
//
//                                          Container(
//
////                                            height: SizeConfig
////                                                .heightMultiplier *
////                                                7.8,
////                                            width: SizeConfig
////                                                .widthMultiplier *
////                                                34,
////                                            padding: EdgeInsets.only(
////                                                left: 1 * SizeConfig.heightMultiplier,
////                                                top: 2),
//                                            child: Text(
//                                              youtubeAssociatedWithGamePOJO
//                                                  .results[index].description,
//                                              style: AppTheme.subTitleLights,
//                                              //  textAlign: TextAlign.center,
//                                            ),
//
//
//                                            //),
//                                            //],
//                                          ) : Container(
//
////                                            height: SizeConfig
////                                                .heightMultiplier *
////                                                7.8,
////                                            width: SizeConfig
////                                                .widthMultiplier *
////                                                34,
////                                            padding: EdgeInsets.only(
////                                                left: 1 * SizeConfig.heightMultiplier,
////                                                top: 2),
//                                            child: Text(
//                                              "No description avaliable",
//                                              style: AppTheme.subTitleLights,
//                                              //  textAlign: TextAlign.center,
//                                            ),
//
//
//                                          ),
//                                        ),
//
////                                              ))
////
////                                      )
////                                    ])
//                                      ]))))));
//            },
//          ));
//    }

    //  print("url"+widget.user.clip);
    print("image" + widget.user.tagId.toString());


    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);

          return Scaffold(
              body: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                      backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                      //  bottomNavigationBar:footerWidget(),

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

                                                  switch(widget.user.flag)
                                                  {
                                                    case 1:
                                                      Navigator.pushNamed(
                                                          context,GameNewsDashboard.routeName);
                                                      break;
                                                    case 2:
                                                      Navigator.pushNamed(
                                                          context,PublisherHomePage.routeName);
                                                      break;
                                                    case 3:
                                                      Navigator.pushNamed(
                                                          context,GenresHomePage.routeName);
                                                      break;
                                                    case 4:
                                                      Navigator.pushNamed(
                                                          context,PlatformHomePage.routeName);
                                                      break;
                                                    case 5:
                                                      Navigator.pushNamed(
                                                          context,StoresHomePage.routeName);
                                                      break;
                                                    case 6:

                                                      YoutubeArguments  tagArguments = new YoutubeArguments(
                                                        flag: 6,

                                                         tagName:widget.user.tagName!=null?widget.user.tagName:AppConstants.noInfo
                                                        ,tagId:widget.user.tagId!=null?widget.user.tagId:AppConstants.noInfo,

//                                                        screenShots:widget.user.screenShots!=null?
//                                                        widget.user.screenShots:AppConstants.noInfo,
//                                                        //clip:platformwiseGameList.results[index].clip.clip!=null?platformwiseGameList.results[index].clip.clip:AppConstants.noInfo,
//                                                        description: widget.user.description!=null?widget.user.description:AppConstants.noInfo,
//                                                        genres: widget.user.genres!=null?  widget.user.genres:AppConstants.noInfo,
//                                                        platforms: widget.user.platforms!=null? widget.user.platforms:AppConstants.noInfo,
//                                                        rating: widget.user.rating!=null? widget.user.rating:AppConstants.noInfo,
//                                                        website:widget.user.website!=null?widget.user.website:AppConstants.noInfo,
//                                                        released: widget.user.released!=null?widget.user.released:AppConstants.noInfo,
//                                                        stores:  widget.user.stores!="Null"?widget.user.stores:AppConstants.noInfo,
                                                      );                                                      Navigator.pushNamed(
                                                          context,TagWiseGameList.routeName,arguments:tagArguments );
                                                      break;
                                                    case 7:
                                                      Navigator.pushNamed(
                                                          context,CreatorHomePage.routeName);
                                                      break;
                                                    default:
                                                      Navigator.pushNamed(
                                                          context,"/");
                                                      break;


                                                  }

                                              //  Navigator.pop(context);
                                                },
                                              )),
                                          Container(
                                              alignment: Alignment.center,

                                              width:
                                              SizeConfig.widthMultiplier * 60,
                                              child: Text(
                                                widget.user.gameName,
                                                style: AppTheme.mainTitles,
                                                textScaleFactor: 1.1,
                                              )),



                                          Container(
                                            alignment: Alignment.centerRight,
                                              width:
                                              SizeConfig.widthMultiplier * 20,
                                              child: GestureDetector(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Icon(
                                                        Icons.share,
                                                        color: Colors.white,
                                                        size: 6 *
                                                            SizeConfig
                                                                .imageSizeMultiplier,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                 shareMixed();
                                                //  shareFile();
                                                },
                                              )),
                                        ],
                                      ))),
                              Column(
                                children: <Widget>[
                                  Container(
                                      height: SizeConfig.heightMultiplier * 41,
                                      width: SizeConfig.widthMultiplier * 97,
                                      child: widget.user.screenShots.length != 0
                                          ? buttonDemo()
                                          : Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(3)),
                                          semanticContainer: true,
                                          color: Color.fromRGBO(32, 32, 32, 5),
                                          elevation: 10.0,
                                          child: Container(
                                            child:Center(
                                            child: Text(
                                              "No Images available",
                                              style: AppTheme.subText,
                                            ),)
                                          ))),

//                              widget.user.systemRequirement != null
//                                  ? Container(
//                                //padding: EdgeInsets.all(8),
//                                  padding: EdgeInsets.only(left:10,top:2),
//                                  alignment: Alignment.centerLeft,
//                                  child: Text(
//                                    "Req",
//                                    style: AppTheme.subTitleLight,
//                                  ))
//                                  : Container(),
//                              widget.user.systemRequirement == null
//                                  ? Container()
//                                  : Text(
//                                widget.user.systemRequirement.minimum,
//                              ),
//
//
//
//                              widget.user.description != null
//                                  ? Container(
//                                      //padding: EdgeInsets.all(8),
//                                  padding: EdgeInsets.only(left:10,top:2),
//                                      alignment: Alignment.centerLeft,
//                                      child: Text(
//                                        "Description",
//                                        style: AppTheme.subTitleLight,
//                                      ))
//                                  : Container(),
//                              widget.user.description == null
//                                  ? Container()
//                                  : Text(
//                                      widget.user.description,
//                                    ),

//                              Divider(
//                                thickness: 1,
//                                color: Colors.red,
//                              ),
                                  new Container(
                                    height: SizeConfig.heightMultiplier * 8,
                                    width: SizeConfig.widthMultiplier * 100,
                                    color: Colors.black38,
                                    padding: EdgeInsets.only(left: 5, right: 5),
//                                decoration: new BoxDecoration(
//                                    color: Colors.white30,
//                                    borderRadius: BorderRadius.only(
//                                       //bottomRight: Radius.circular(20),
//                                        topRight: Radius.circular(10), //bottomLeft: Radius.circular(20),
//                                        topLeft: Radius.circular(10))),
                                    child: new TabBar(
                                      controller: _gameTabController,
                                      isScrollable: true,
                                      indicatorPadding: EdgeInsets.all(4),
                                      indicatorColor: Colors.white30,
                                      indicator: new BoxDecoration(
                                        color: Colors.redAccent,
//                                      borderRadius: BorderRadius.only(
//                                        //  bottomRight: Radius.circular(20),
//                                          topRight: Radius.circular(10),
//                                          // bottomLeft: Radius.circular(20),
//                                          topLeft: Radius.circular(10))
                                      ),
                                      tabs: [
                                        new Tab(
                                          child: Container(
                                            child: Text(
                                              "About",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                          // text: 'About',
                                        ),
                                        new Tab(
                                          child: Container(
                                            child: Text(
                                              "Description",
                                              style: AppTheme.subTitleLights,
                                              textScaleFactor: 1.0,
                                            ),
                                          ),
                                          // text: 'About',
                                        ),
                                        new Tab(
                                          child: Container(
                                              child: Text(
                                                "Series",
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.0,
                                              )),
                                          // text: 'About',
                                        ),
//                                        new Tab(
//                                          child: Container(
//                                            child: Text(
//                                              "YouTube review",
//                                              style: AppTheme.subTitleLights,
//                                              textScaleFactor: 1.0,
//                                            ),
//                                          ),
//                                          // text: 'About',
//                                        ),
//                                        new Tab(
//                                          child: Container(
//                                              child: Text(
//                                                "Trailer",
//                                                style: AppTheme.subTitleLights,
//                                                textScaleFactor: 1.0,
//                                              )),
//                                        ),
                                        new Tab(
                                          child: Container(
                                              child: Text(
                                                "Suggested",
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.0,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1.5,
                                    color: Colors.white10,
                                  ),

                                  new Container(
                                    height: SizeConfig.heightMultiplier * 39,
                                    width: SizeConfig.widthMultiplier * 99,
                                    decoration: new BoxDecoration(
                                      // color: Colors.white30,
                                        borderRadius: BorderRadius.only(
                                          // bottomRight: Radius.circular(10),
                                          //   topRight: Radius.circular(20),
                                          // bottomLeft: Radius.circular(10)
                                          // topLeft: Radius.circular(20))
                                        )),
                                    child: new TabBarView(
                                      controller: _gameTabController,
                                      children: <Widget>[
                                        Container(
                                          height: SizeConfig.heightMultiplier*34,
                                            color: Colors.black45,
                                            child: new ListView(
                                              shrinkWrap: true,
                                              children: <Widget>[




                                                Container(
                                                    padding:
                                                    EdgeInsets.only(left: 10),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      "Ratings",
                                                      style: AppTheme
                                                          .subTitleLight,
                                                    )),
                                                widget.user.rating == 0.0
                                                    ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    alignment:
                                                    Alignment.centerLeft,
                                                    child: Text(
                                                      "No Ratings Available",
                                                      style: AppTheme
                                                          .subTitleLights,
                                                      textScaleFactor: 1.1,
                                                    ))
                                                    : FlutterRatingBarIndicator(
                                                  rating: widget.user.rating,
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                  emptyColor: Colors.amber
                                                      .withAlpha(50),
                                                ),

                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      "Release Date",
                                                      style: AppTheme
                                                          .subTitleLight,
                                                    )),

                                                widget.user.released != null
                                                    ? Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    widget.user.released,
                                                    style: AppTheme
                                                        .subTitleLights,
                                                    textScaleFactor: 1.2,
                                                  ),
                                                )
                                                    : Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    " Release date not avaliable",
                                                    style: AppTheme
                                                        .subTitleLights,
                                                    textScaleFactor: 1.2,
                                                  ),
                                                ),

                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      "Website",
                                                      style: AppTheme
                                                          .subTitleLight,
                                                    )),

                                                widget.user.website != null
                                                    ? Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    widget.user.website,
                                                    style: AppTheme
                                                        .subTitleLights,
                                                    textScaleFactor: 1.2,
                                                  ),
                                                )
                                                    : Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    " Website info not avaliable",
                                                    style: AppTheme
                                                        .subTitleLights,
                                                    textScaleFactor: 1.2,
                                                  ),
                                                ),




                                                //Text(widget.user.genres[0].name,style: TextStyle(fontSize: 18,color: Colors.white),),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      "Platforms",
                                                      style: AppTheme
                                                          .subTitleLight,
                                                    )),
                                                gamePlatformWidget(),

                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 2),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      "Genres",
                                                      style: AppTheme
                                                          .subTitleLight,
                                                      textScaleFactor: 1.1,
                                                    )),
                                                widget.user.genres==null?Center(child:(Text("No genre info available :(",
                                                  style: AppTheme.subTitleLights,textScaleFactor: 1.2,))):
                                                gameGenresWidget(),

                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: Text("Where to buy",
                                                      style:
                                                      AppTheme.subTitleLight),
                                                ),

                                                widget.user==null?Center(child:(Text("No store info avaliable :(",
                                                  style: AppTheme.subTitleLights,textScaleFactor: 1.2,))):

                                                gameStoresWidget(),





                                              ],
                                            )),

                                        /**game details**/

//                                        new Card(
//                                          color: Colors.black38,
                                        // child:
                                        FutureBuilder(
                                            future: restApiClient
                                                .getGameDetails("com.gamersgram/1",widget.user.gameId)
                                                .then((
                                                GameListDetails responses) {
                                              gameDescription = responses;
                                            }),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (gameDescription == null) {
                                                return Container(
                                                    height:
                                                    SizeConfig.widthMultiplier *
                                                        10,
                                                    child: FlareActor(
                                                        'assets/loader.flr',
                                                        alignment: Alignment
                                                            .center,
                                                        fit: BoxFit.contain,
                                                        animation: "loader"));
                                              }
                                              return ListView(
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  gameDescription
                                                      .description !=
                                                      null
                                                      ? Container(
                                                    padding: EdgeInsets.all(
                                                        SizeConfig
                                                            .heightMultiplier),
                                                    alignment:
                                                    Alignment.center,
                                                      child: Text(
                                                        html2md.convert(
                                                            gameDescription
                                                                .description),
                                                        softWrap: true,
                                                        style: AppTheme
                                                            .subTitleLights,
                                                        textScaleFactor: 1.2,
                                                      ),
                                                  )
                                                      : Container(
                                                      child: Text(
                                                        "No description avaliable",
                                                        softWrap: true,
                                                        style: AppTheme
                                                            .subTitleLights,
                                                        textScaleFactor: 1.1,
                                                      ),
                                                    alignment:
                                                    Alignment.center,
                                                  ),
                                                ],
                                              );
                                            }),
                                        // ),

//                                        new Card(
//                                          child:

                                        FutureBuilder(
                                            future: restApiClient
                                                .showListOfGamesSeries("com.gamersgram/1",
                                                1, widget.user.gameId)
                                                .then((GameList responses) {
                                              gameSeries = responses;
                                            }),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (gameSeries == null) {
                                                return Container(
                                                    height:
                                                    SizeConfig.widthMultiplier *
                                                        10,
                                                    child: FlareActor(
                                                        'assets/loader.flr',
                                                        alignment: Alignment
                                                            .center,
                                                        fit: BoxFit.contain,
                                                        animation: "loader"));
                                              }
                                              return
                                                gameSeries.results.length==0?Center(child:(Text("No series avaliable :(",
                                                style: AppTheme.mainTitles,textScaleFactor: 1.2,))):

                                                seriesOfGamesListWidget(
                                                  gameSeries);
                                            }),
                                        //       ),

//                                        new Card(
//                                          color: Colors.black38,
//                                          child:
//

//                                        FutureBuilder(
//                                            future: restApiClient
//                                                .getGameYoutubeVideos(
//                                                widget.user.gameId)
//                                                .then((youtubeVideosOfGamePOJO
//                                            responses) {
//                                              youtubeAssociatedWithGamePOJO =
//                                                  responses;
//                                            }),
//                                            builder: (BuildContext context,
//                                                AsyncSnapshot snapshot) {
//                                              if (youtubeAssociatedWithGamePOJO ==
//                                                  null) {
//                                                return Container(
//                                                    height:
//                                                    SizeConfig.widthMultiplier *
//                                                        10,
//                                                    child: FlareActor(
//                                                        'assets/loader.flr',
//                                                        alignment: Alignment
//                                                            .center,
//                                                        fit: BoxFit.contain,
//                                                        animation: "loader"));
//                                              }
//                                              return ListView(
//                                                shrinkWrap: true,
//                                                children: <Widget>[
//
//                                                  youtubeAssociatedWithGamePOJO.results.length==0?Center(child:(Text("No Youtube reviews avaliable :(",
//                                                    style: AppTheme.mainTitles,textScaleFactor: 1.2,))):
//                                                  youTubeReviewsOfTheGamesWidget(),
//                                                  //  footerWidget(),
//                                                ],
//                                              );
//                                            }),
//
//                                    ListView(
//                                      shrinkWrap: true,
//                                      children: <Widget>[
                                        //  gameShortTrailerWidget(),
//                                        FutureBuilder(
//                                            future: restApiClient
//                                                .getGameDetails(widget.user.gameId)
//                                                .then((
//                                                GameListDetails responses) {
//                                              gameDetailRequirements =
//                                                  responses;
//                                              print("req" +
//                                                  gameDetailRequirements
//                                                      .platforms[0].requirements
//                                                      .toString());
//                                            }),
//                                            builder: (BuildContext context,
//                                                AsyncSnapshot snapshot) {
//                                              if (gameDetailRequirements ==
//                                                  null) {
//                                                return Container(
//                                                    height:
//                                                    SizeConfig.widthMultiplier *
//                                                        10,
//                                                    child: FlareActor(
//                                                        'assets/loader.flr',
//                                                        alignment: Alignment
//                                                            .center,
//                                                        fit: BoxFit.contain,
//                                                        animation: "loader"));
//                                              }
//                                              return ListView(
//                                                shrinkWrap: true,
//                                                children: <Widget>[
//                                                  gameDetailRequirements
//                                                      .description !=
//                                                      null
//                                                      ? Container(
//                                                    padding: EdgeInsets.all(
//                                                        SizeConfig
//                                                            .heightMultiplier),
//                                                    alignment:
//                                                    Alignment.center,
//
//                                                  )
//                                                      : Container(
//                                                    child: Text(
//                                                      "No description avaliable",
//                                                      softWrap: true,
//                                                      style: AppTheme
//                                                          .subTitleLights,
//                                                      textScaleFactor: 1.1,
//                                                    ),
//                                                    alignment:
//                                                    Alignment.center,
//                                                  ),
//                                                ],
//                                              );
//                                            }),
//                                      ],
//                                    ),

//                                    new Card(
//                                      child: FutureBuilder(
//                                          future: restApiClient
//                                              .showListOfGamesSeries(
//                                              1, widget.user.gameId)
//                                              .then((GameList responses) {
//                                            gameSeries = responses;
//                                          }),
//                                          builder: (BuildContext context,
//                                              AsyncSnapshot snapshot) {
//                                            if (snapshot.hasData == null) {
//                                              return Container(
//                                                  child:  FlareActor('assets/loader.flr',
//                                                      alignment:Alignment.center, fit:BoxFit.contain, animation:"loader"
//
//
//                                                  ));
//                                            }
//                                            return filterGameListWidget(
//                                                gameSeries,context);
//                                          }),
//                                    ),

                                        Container(
                                          color: Colors.black45,
                                          child: FutureBuilder(
                                              future: restApiClient
                                                  .showListOfGamesSuggested("com.gamersgram/1",
                                                  1, widget.user.gameId)
                                                  .then((GameList responses) {
                                                suggestedGames = responses;
                                              }),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (suggestedGames == null) {
                                                  return Container(
                                                      child: FlareActor(
                                                          'assets/loader.flr',
                                                          alignment:
                                                          Alignment.center,
                                                          fit: BoxFit.contain,
                                                          animation: "loader"));
                                                }
                                                return
                                                  suggestedGames.results.length==0?Center(child:(Text("No suggested games avaliable :(",
                                                    style: AppTheme.mainTitles,textScaleFactor: 1.2,))):
                                                  seriesOfGamesListWidget(
                                                    suggestedGames);
                                              }),
                                        ),

//                      new Card(
//                        child: gameClips(),
//                      ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]))
                      ]))));
        },
      );
    });
  }
}
