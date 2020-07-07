import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/generated/i18n.dart';
import 'package:gamersgram/publishers/detail/PublisherDetails.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/SearchBox.dart';
import 'package:gamersgram/util/ui/SearchWidgets.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants=new AppConstants();

class SearchGameHomePage extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName="/SearchGameHomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,


        body:  SearchGameHomePageState(),
        );
  }
}
class SearchGameHomePageState extends StatefulWidget {
  SearchGameHomePageState({Key key,

    this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  _SearchGameHomePageState createState() => _SearchGameHomePageState();

}

//List<GamePublisherResult>publisherDetailsResult=new List();



class _SearchGameHomePageState extends State<SearchGameHomePageState> {

  String currentText = "@#%";

  SearchBoxExampleState searchBoxExample=new SearchBoxExampleState()
  ;

  int pageCount = 1;
  int count;
  List<int> pages = new List();
  GlobalKey<AutoCompleteTextFieldState<GamePublisherResult>> key =
  new GlobalKey();

// AutoCompleteTextField searchTextField;
  AutoCompleteTextField<GamePublisherResult> textField;
  TextEditingController editingController = new TextEditingController();


//List<Result>publisherSuggestionsAc=new List();
  List<GamePublisherResult>publisherListDetails = new List();
  GamePublisherPOJO publisherSearchedResponse;
  GamePublisherPOJO publisherListLv;
  final keys = new GlobalKey<SearchBoxExampleState>();

  GameList gameListDetailsResponse;
  List<GameListDetails>gameListDetails = new List();
  GameList allGameList;


  @override
  void initState() {
    // TODO: implement initState
    //WidgetsBinding.addPostFrameCallback(() {            });




    super.initState();
  }

  // platformListDetailsResult=new List();
  @override
  Widget build(BuildContext context) {
    GameList searchedGameList;

    print("PAGECONT" + SizeConfig.heightMultiplier.toString());


    double rating;





    //  publisherSuggestionsAc=new List();

    int pageNumber = 1;


    Widget allGamesListWidget() {
      var mediaQuery = MediaQuery.of(context);
      //return LayoutBuilder(builder: (context, boxSizing) {
//      var sizingInformation = SizingInformation(
//        orientation: mediaQuery.orientation,
//        deviceType: getDeviceType(mediaQuery),
//        screenSize: mediaQuery.size,
//        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
//      );
//   print("Size info" +sizingInformation.screenSize.toString());
//   print( SizeConfig.heightMultiplier);

        return new Container(
            //padding: EdgeInsets.only(left: 5, right: 5),
//            decoration: BoxDecoration(
//              //  color: Colors.red,
//                borderRadius:
//                BorderRadius
//                    .all(Radius
//                    .circular(
//                    1)),
//                border: Border.all(color:
//                Colors.white30)
//            ),
            height: pages.length == 0
                ? SizeConfig.heightMultiplier * 98
                : SizeConfig.heightMultiplier * 98,
            child: ListView.builder(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 3),

padding: EdgeInsets.all(SizeConfig.heightMultiplier),
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: gameListDetails == null ? 0 : gameListDetails.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    onTap: () {
                      /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                      YoutubeArguments gameListDetailsArguments = new YoutubeArguments(
                        flag: 1,

                        gameName:gameListDetails[index].name!=null? gameListDetails[index].name:AppConstants.noInfo
                        ,gameId: gameListDetails[index].id!=null?gameListDetails[index].id:AppConstants.noInfo,

                        screenShots: gameListDetails[index].short_screenshots!=null?
                        gameListDetails[index].short_screenshots:AppConstants.noInfo,
                        //clip:gameListDetails[index].clip.clip!=null?gameListDetails[index].clip.clip:AppConstants.noInfo,
                        description: gameListDetails[index].description!=null? gameListDetails[index].description:AppConstants.noInfo,
                        genres: gameListDetails[index].genres!=null? gameListDetails[index].genres:AppConstants.noInfo,
                        platforms: gameListDetails[index].platforms!=null?gameListDetails[index].platforms:AppConstants.noInfo,
                        rating: gameListDetails[index].rating!=null? gameListDetails[index].rating:AppConstants.noInfo,
                        website: gameListDetails[index].website!=null?gameListDetails[index].website:AppConstants.noInfo,
                        released: gameListDetails[index].released!=null? gameListDetails[index].released:AppConstants.noInfo,
                        stores:  gameListDetails[index].stores!="Null"? gameListDetails[index].stores:AppConstants.noInfo,
                      );
                      Navigator.pushNamed(context, GameDetails.routeName,arguments: gameListDetailsArguments);



                      //  print("ID PASSING TO DETAILS PAGE"   + gameList.results[index].description);
//                      gameListDetails[index].clip == null
//                          ? Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) =>
//                              GameDetailsStates(
//                                gameId:gameListDetails[index].id,
//                                screenShots:
//                                gameListDetails[index].short_screenshots,
//                                gameName: gameListDetails[index].name,
//                                released: gameListDetails[index].released,
//                                rating: gameListDetails[index].rating,
//                                stores: gameListDetails[index].stores,
//                                clip: "no",
//                                genres: gameListDetails[index].genres,
//                                platforms: gameListDetails[index].platforms,
//                                flag: 1,
//                                website: gameListDetails[index].website,
//                              )))
//                          : Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) =>
//                              GameDetailsStates(
//                                clips:
//                                gameListDetails[index].clip.clips.full,
//                                gameId: gameListDetails[index].id,
//                                screenShots:
//                                gameListDetails[index].short_screenshots,
//                                gameName: gameListDetails[index].name,
//                                released: gameListDetails[index].released,
//                                rating: gameListDetails[index].rating,
//                                stores: gameListDetails[index].stores,
//                                clip: gameListDetails[index].clip.clip,
//                                genres: gameListDetails[index].genres,
//                                platforms: gameListDetails[index].platforms,
//                                flag: 1,
//                                website: gameListDetails[index].website,
//                              )));
                    },
                    child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: gameListDetails.length,
                        child: ScaleAnimation(
                            child: FadeInAnimation(

                              child: Card(
//                                height: SizeConfig.heightMultiplier*90,
//                                  width: SizeConfig.widthMultiplier*90,
                              elevation: 11,
                                  color: Colors.white12,


//                                  child: Column(
//                                //    mainAxisSize: MainAxisSize.max,
//                                    children: <Widget>[

//                                              Expanded(
//                                                  flex: 1,
//                                                  child:



                                   child:   Container(width: SizeConfig.widthMultiplier*90,
                                        height: SizeConfig.heightMultiplier*15,
                                     color: Colors.white12,

                                        child: Row(children: <Widget>[

                                          Container(width: SizeConfig.widthMultiplier*30,
                                            height: SizeConfig.heightMultiplier*15,

                                          child:  gameListDetails[index]
                                              .background_image !=
                                              null
                                              ? Container(

//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    color: Colors
//                                                        .white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                            height: SizeConfig
                                                .imageSizeMultiplier *
                                                20,
//                                            width: SizeConfig
//                                                .widthMultiplier *
//                                                34,

                                            child:


                                            CachedNetworkImage(
                                              imageUrl: searchedGameList
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

                                          ),


                                          Container(width: SizeConfig.widthMultiplier*60,
                                            height: SizeConfig.heightMultiplier*10,

                                            child: Column(children: <Widget>[
                                              Expanded(
                                                child:
                                                Container(

//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                      color: Colors
//                                                          .white30)),
//                                                  height: SizeConfig
//                                                      .heightMultiplier *
//                                                      6.7,
//                                                  width: SizeConfig
//                                                      .widthMultiplier *
//                                                      34,
                                                  padding: EdgeInsets.only(left: 1 *
                                                      SizeConfig.heightMultiplier,
                                                      top: 2),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    gameListDetails[index].name,
                                                    style: AppTheme.subTitleLights,
                                                    textScaleFactor: 1,
                                                    //  textAlign: TextAlign.center,
                                                  ),
                                                ),),

                                              Expanded(
                                                child:
                                                Container(
                                                  alignment: Alignment.topLeft,

//                                              decoration: BoxDecoration(
//                                                  border: Border.all(
//                                                      color: Colors
//                                                          .white30)),
//                                                  height: SizeConfig
//                                                      .heightMultiplier *
//                                                      6.7,
//                                                  width: SizeConfig
//                                                      .widthMultiplier *
//                                                      34,
                                                  padding: EdgeInsets.only(left: 1 *
                                                      SizeConfig.heightMultiplier,
                                                      top: 2),
                                                  child:     gameListDetails[index].rating == 0.0
                                                      ? Container(
//                                                      padding: EdgeInsets.only(
//                                                          left: 10, top: 2),
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                        "No Ratings Avalibale",
                                                        style: AppTheme
                                                            .subTitleLights,
                                                        textScaleFactor: 1.1,))
                                                      : FlutterRatingBarIndicator(
                                                    rating:  gameListDetails[index].rating ,
                                                    itemCount: 5,
                                                    itemSize:SizeConfig.heightMultiplier+5,
                                                    emptyColor:
                                                    Colors.amber.withAlpha(50),
                                                  ),
                                                ),),



                                            ],),


                                          ),


                                        ],),

 


                                      )






                                      //),
//                                    ],
//                                  )

                              ),
//                                              ))
//
//                                      )
//                                    ])

                            ))));
              },
            ));
     // });
    }












    String myText;


    ValueNotifier<String> notebe =  ValueNotifier("");

    return LayoutBuilder(builder: (context, constraints) {
//      SearchBoxExampleState().editingController=new TextEditingController();
//      //SearchBoxExampleState().textHasErrorNotifier=ValueNotifier( SearchBoxExampleState().editingController.text);
//      SearchBoxExampleState().searchList=new List();



      GamePublisherPOJO loaderPublisherListLv;

      return OrientationBuilder(
        builder: (context, orientation) {

          SizeConfig().init(constraints, orientation);
          return
//            MaterialApp(
//
//                home:

                Scaffold(
                    resizeToAvoidBottomInset:false,

                    backgroundColor: Color.fromRGBO(21, 21, 21, 5),
//                    bottomNavigationBar:
//                    Opacity(
//
//
//                        opacity: editingController.text.trim().isNotEmpty?0.0:1.0,
//                        child:FutureBuilder(
//                            future:  restApiClient
//                                .showPublisherList(1)
//                                .then((GamePublisherPOJO responses) {
//                              //  publisherListLv = responses;
//                              //  print("PAGE COUNT IN PUBLISHER" + publisherListLv.count.toString());
//                              int pageCounts =
//                              (responses.count / responses.results.length)
//                                  .floor();
//                              // print("printcode" + pageCount.toString());
//                              pages = new List();
//                              //  print("editingController pages" + pages.length.toString());
//
//                              for (int i = 1; i < pageCounts; i++) {
//                                //  print("pp"+pg.floor().toString());
//                                pages.add(i);
//                                //  i == pageCount ? pages.add(pageCount) : i;
//                                //  print("PGE COUNt" + pages.length.toString());
//
//                              }
//                            }
//
//                            ),
//                            builder:
//                                (BuildContext context,
//                                AsyncSnapshot snapshot) {
//
//
//
//                              return
//
//                                footerWidget();
//
////                            ],);
//                            })),


                    body:
                        Container(
                          height: SizeConfig.heightMultiplier*100,
          width: SizeConfig.widthMultiplier*100,

          child:
                    CustomScrollView(
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
                                                    GameNewsDashboard.routeName);
                                              },
                                            )),
                                        Container(
                                            width: SizeConfig.widthMultiplier *
                                                80,

                                            alignment: Alignment.center,
                                            child:
                                            Text("Search games",
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.3,)),


                                      ],))),

//                            Container(
//                              //     height: SizeConfig.heightMultiplier*7,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
//                              child: platformSearchWidget(),),


//                            Container(
//                              height: SizeConfig.heightMultiplier * 9,
//                              width:SizeConfig.widthMultiplier*97,
//
//                              alignment: Alignment.center,
//                              padding: EdgeInsets.only(left: SizeConfig.heightMultiplier),
//
//
//                              //  width: SizeConfig.widthMultiplier*100,
////                              padding: EdgeInsets.only(
////                                  left: 17, right: 17, top: 13),
//                              child: Row(children: <Widget>[
//                                Card(
//                                    elevation: 6,
//                                    color: Colors.white30,
//
//                                    child:
//                                    Container(
//                                        width: SizeConfig.widthMultiplier*75,
//                                        height: SizeConfig.heightMultiplier * 8,
//                                        alignment: Alignment.center,
//                                        decoration: BoxDecoration(color: Colors.white30,
//                                        ),
//                                        //   padding: EdgeInsets.all(5),
//                                        child: new Theme(
//                                            data: new ThemeData(
//                                              primaryColor: Colors.white10,
//                                            ),
//                                            child: new TextField(
//                                              decoration: new InputDecoration(
////                                        border: new OutlineInputBorder(
////                                          borderSide: new BorderSide(color: Colors.blue),
////                                          borderRadius: BorderRadius.circular(40.0),
////                                        ),
//
//                                                  filled: true,
//                                                  hintStyle: new TextStyle(color: Colors.grey[800]),
//                                                  hintText: "Search Games",
//                                                  fillColor: Colors.white30),controller: editingController,
//
////
////                                              onSubmitted: (c){
////                                                setState(() {
////
////                                                  editingController.text.length==0? editingController.text="   ":Container();
////                                                  ;
////
////                                                  print("onSubmitted" + currentText);
////                                                  ;
////                                                  //   print("INSIDE"+editingController.text);
////
////                                                });
////
////
////
////
////                                              },
////
////                                              onChanged: (c)
////                                              {
////
////                                                //   setState(() {
////
////                                                // editingController.text.trim().isEmpty? publisherListDetails=new List():Container(child: Text(""),);
////
////                                                // editingController.text.trim().isEmpty? editingController.text="   ":Container(child: Text(""),);
////
////                                                //  editingController.text.trim().isEmpty ?Container(child:Text("")):currentText;
////                                                if(editingController.text.trim().isEmpty)
////                                                {
////                                                  setState(() {
////                                                    publisherListDetails=new List();
////
////                                                  });
////
////                                                  print("empty" + currentText);
////                                                  Container(child: Text(""),);
////
////                                                }
//
//                                                // });
//
//
//                                              //},
//
////                                  onSubmitted: (currentText)
////                                  {
////
////                                    print("onSubmitted");
////                                    publisherListDetails=new List();
////                                    editingController.text.length==0?currentText="@#%":Container();
////                                  },
//
////                                  onTap: (){
////                                    setState(() {
//////                                      editingController.text==null?          publisherListDetails.remove(publisherSearchedResponse)
//////                                          :Container();
////                                      publisherListDetails=new List();
////                                      editingController.text.length==0?currentText="@#%":Container();
////                                      print("onTap");
////
////
////                                    });
////
////
////
////                                  }
//
//                                            )))),
//                                SizedBox(width: SizeConfig.widthMultiplier,),
//                                Card(
//                                    elevation: 6,
//                                    color: Colors.white30,
//
//                                    child:
//                                    Container(
//                                        width: SizeConfig.widthMultiplier*15,
//                                        height: SizeConfig.heightMultiplier*8,
//                                        color: Colors.white30,
//                                        // padding: EdgeInsets.only(left: 5),
//
//                                        child:FlatButton(
//                                          hoverColor: Colors.red,
//                                          highlightColor: Colors.black38,
//
//                                          child:      Align(
//                                            alignment: Alignment.center,
//                                            child: Icon(
//                                              Icons.search,
//                                              color: Colors.white,
//                                              size: 6 * SizeConfig
//                                                  .imageSizeMultiplier,
//
//
//                                            ),
//                                          ) ,
//
//
//
//                                          onPressed: (){
//
//                                        //    setState(() {
//
//
//                                              editingController.text.isNotEmpty? editingController.text:Container();
////                                        editingController.text.isEmpty?  publisherListDetails=new List():Container();
//
//                                           // });
//
//
//                                          },)
//                                    )),
//
//
//
//
//
//                              ],),),
//                                 Stack(
//                              alignment: Alignment.center,
//
//                              children: <Widget>[

//                            editingController.text.isNotEmpty?Text("Not empty"): Text("Empty"),
//                          editingController.text.length!=0?Text("Not empty 1"): Text("Empty 1"),
//                            editingController.text.trim()==" "?Text("Not empty 2"): Text("Empty 1"),

                            Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 97,

                           //   alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: SizeConfig.heightMultiplier),


                              //  width: SizeConfig.widthMultiplier*100,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
                              child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                Card(
                                    elevation: 6,
                                    color: Colors.white30,

                                    child:
                                    Container(
                                        width: SizeConfig.widthMultiplier * 70,
                                        height: SizeConfig.heightMultiplier * 8,
                                        //alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                        ),
                                        //   padding: EdgeInsets.all(5),
                                        child: new Theme(
                                            data: new ThemeData(
                                              primaryColor: Colors.white10,
                                            ),
                                            child:
                                            new TextField(
                                              decoration: new InputDecoration(
//                                        border: new OutlineInputBorder(
//                                          borderSide: new BorderSide(color: Colors.blue),
//                                          borderRadius: BorderRadius.circular(40.0),
//                                        ),

                                                  filled: true,
                                                  hintStyle: new TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: "Search Games",
                                                  alignLabelWithHint: true,
                                                  fillColor: Colors.white30),
                                              controller: editingController,
//                                              onSubmitted: (c) {
//                                               setState(() {
//                                                  currentText = c;
//
//                                                  gameListDetails =
//                                                  new List();
//                                                  editingController.text.length ==
//                                                      0
//                                                      ?
//                                                  editingController.text = "   "
//                                                      : Container();
//                                                  ;
//
//                                                  print("onSubmitted" +
//                                                      currentText);
//                                                  ;
//                                                  //   print("INSIDE"+editingController.text);
//
//                                               });
//                                              },

                                              onChanged: (c) {
                                                editingController.text.isEmpty?  setState(() {

                                                // editingController.text.trim().isEmpty? publisherListDetails=new List():Container(child: Text(""),);

                                                // editingController.text.trim().isEmpty? editingController.text="   ":Container(child: Text(""),);

                                                //  editingController.text.trim().isEmpty ?Container(child:Text("")):currentText;
                                                if (editingController.text
                                                    .trim()
                                                    .isEmpty) {
                                               //   setState(() {
                                                    gameListDetails =
                                                    new List();
                                              //    });

                                                  print("empty" + currentText);
                                                }
                                                  }):                                                  Container(child: Text(""),);



                                              },

//                                  onSubmitted: (currentText)
//                                  {
//
//                                    print("onSubmitted");
//                                    publisherListDetails=new List();
//                                    editingController.text.length==0?currentText="@#%":Container();
//                                  },

//                                  onTap: (){
//                                    setState(() {
////                                      editingController.text==null?          publisherListDetails.remove(publisherSearchedResponse)
////                                          :Container();
//                                      publisherListDetails=new List();
//                                      editingController.text.length==0?currentText="@#%":Container();
//                                      print("onTap");
//
//
//                                    });
//
//
//
//                                  }

                                            )))),
                                SizedBox(width: SizeConfig.widthMultiplier,),
                                Card(
                                    elevation: 6,
                                    color: Colors.white30,

                                    child:
                                    Container(
                                        width: SizeConfig.widthMultiplier * 15,
                                        height: SizeConfig.heightMultiplier * 8,
                                        color: Colors.white30,
                                        // padding: EdgeInsets.only(left: 5),

                                        child: FlatButton(
                                          hoverColor: Colors.red,
                                          highlightColor: Colors.black38,

                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.white,
                                              size: 6 * SizeConfig
                                                  .imageSizeMultiplier,


                                            ),
                                          ),


                                          onPressed: () {
                                            setState(() {
                                              editingController.text.isNotEmpty
                                                  ? editingController.text
                                                  : Container();
                                              editingController.text.isEmpty?  gameListDetails=new List():Container();

                                            });
                                          },)
                                    )),


                              ],),),
                            editingController.text
                                .trim()
                                .isEmpty
                                ? Container(child: Text(""))
                                : FutureBuilder(
                                future:
                                restApiClient.showSearchedGames(          "com.gamersgram/1",                  editingController.text
                                )
                                    .then((GameList responses) {
                                  searchedGameList = responses;
                                  print("INSIDE"+editingController.text);

                                  // print("Check new options" +gameListDetailsResponse.results[0].name);
                                  gameListDetails = new List();
                                  gameListDetails.addAll(
                                      searchedGameList.results);
                                  pageCount = 1;
                                }),
                                builder:
                                    (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (searchedGameList == null) {
                                    return Container(
                                        height: SizeConfig.heightMultiplier *
                                            20,
                                        child: FlareActor('assets/loader.flr',
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain,
                                            animation: "loader"


                                        ));
                                  }
                                  return Column(children: <Widget>[
                                    

                                  //  appState.getDisplayText.isEmpty?Center(child:Text("Search ")):
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: allGamesListWidget(),


                                    )
                                  ],);
                                }),









                            //   ],)



                            // )),


                            // Divider(color: Colors.red,thickness: 2.0,),


//                    ],
//                  ),

                          ]),
                        )
                      ],
                      // ),


                    ))

                  //)


                );
        },
      );
    });
  }
}
