import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/gamelist/GameListPOJO.dart';
import 'package:gamersgram/generated/i18n.dart';
import 'package:gamersgram/publishers/detail/PublisherDetails.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/SearchBox.dart';
import 'package:gamersgram/util/ui/SearchWidgets.dart';
import 'package:gamersgram/util/ui/searchkar.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:provider/provider.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants=new AppConstants();
SearchBoxExampleState searchBoxExampleState;
SearchBoxExample searchBoxExampleobj = new SearchBoxExample();
class PublisherHomePage extends StatelessWidget {
 // static const routeName = '/PublisherDetailsState';
  static const routeName = '/publisherhomepage';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: PublisherHomePageState(),
        );
  }
}
class PublisherHomePageState extends StatefulWidget {
  PublisherHomePageState( {Key key,

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
  _PlatformHomePageState createState() => _PlatformHomePageState();

}

//List<GamePublisherResult>publisherDetailsResult=new List();


class _PlatformHomePageState extends State<PublisherHomePageState> {

  String currentText = "@#%";

  SearchBoxExampleState searchBoxExample = new SearchBoxExampleState()
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
  List<GamePublisherResult>passArgu=new List();

  List<String>searchListstatic = new List();

  @override
  void initState() {
    // TODO: implement initState
    //WidgetsBinding.addPostFrameCallback(() {            });

    searchBoxExample.searchList = new List();

    searchBoxExample.searchList.add("ganu");
    searchBoxExample.searchList.add("ganapati");
    searchBoxExample.searchList.add("ganpya");
    searchBoxExample.searchList.add("sai");
    searchBoxExample.searchList.add("Sai");

    searchBoxExample.searchList.add("Laxmi");


    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBoxExampleState = new SearchBoxExampleState();
    });

    super.initState();
  }

  // platformListDetailsResult=new List();
  @override
  Widget build(BuildContext context) {
    print("PAGECONT" + SizeConfig.heightMultiplier.toString());
   // final appState = Provider.of<AppState>(context);


    Widget platformSearchWidget() {
      return

        Container(
            height: SizeConfig.heightMultiplier * 8,

            decoration: BoxDecoration(color: Colors.white30,
                borderRadius: BorderRadius.all(Radius.circular(10))),

            child:
            textField = new AutoCompleteTextField<GamePublisherResult>(
                style: AppTheme.subTitleLights,


                decoration: InputDecoration(
                  labelText: "Search Publisher",
                  fillColor: Colors.white,

                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),

                ),

                //  key: key,

                submitOnSuggestionTap: true,
                clearOnSubmit: true,
                controller: editingController,
                //   suggestions: publisherListDetails,
                textInputAction: TextInputAction.go,
                textChanged: (item) {
                  currentText = item;

                  print("editingController names" + item);
                  //  print("names" +editingController.text);

                  setState(() {
                    currentText = item;

                    if (item.length == 0) {
                      print("Item length 0");
                      currentText = "@#%";
                      item = "";
                      publisherSearchedResponse.results.clear();
                      publisherListDetails.clear();
                      publisherListDetails.remove(
                          publisherSearchedResponse.results);


                      //gamesearchkey.currentState.clear();
                    }
                    if (currentText.isEmpty) {
                      print("Item length 0");
                      currentText = "@#%";
                      item = "";
                      publisherSearchedResponse.results.clear();
                      publisherSearchedResponse.results.remove(
                          publisherSearchedResponse);

                      publisherListDetails.clear();
                      publisherListDetails.remove(
                          publisherSearchedResponse.results);


                      //gamesearchkey.currentState.clear();
                    }
                  });
                },
                itemSubmitted: (item) {
                  setState(() {
                    currentText = item.name;
                  });
                },

                itemBuilder: (context, item) {
                  return Container();
                },
                itemSorter: (a, b) {
                  return a.name.compareTo(b.name);
                },
                itemFilter: (item, query) {
                  return item.name.toLowerCase().startsWith(
                      query.toLowerCase());
                }
            )


        );
    }


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
                  //   print("index" + index.toString());
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

    Widget publisherListWidget() {
//    return Align(
//        child: Directionality(
//           // textDirection: TextDirection.ltr,
//            child:

      return new Container(
          height: SizeConfig.heightMultiplier * 67,
          width: SizeConfig.widthMultiplier * 97,
          child: ListView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 4),
            //  physics: const ScrollPhysics(),
            padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier),

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: publisherListLv == null ? 0 : publisherListLv.results
                .length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */



                  //  Navigator.of(context).pushNamed(
                    passArgu.add(publisherListLv.results[index]);

                    print("Adding....."+passArgu[0].name);
                    print("Adding 22....."+publisherListLv.results[index].name);
//
//                    Navigator.pushNamed(
//                          context,
//                          "/PublisherDetailsState",
//                          arguments: PublisherDetailsState(
//                           // publisherId:  publisherListLv.results[index].id,
//                            //publisherName:  publisherListLv.results[index].name,
//                            pageDirection: 2,
//                            passArgu: passArgu,
//
//
//                          ),
//                        );
//                    Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) =>
//                            PublisherDetailsState(
//                              publisherId: publisherListLv.results[index].id,
//                              publisherName: publisherListLv.results[index]
//                                  .name,
//                              pageDirection: 2,
//
//
//                            )))

                  YoutubeArguments publisherDetailsArguments=new  YoutubeArguments(
                    gameId: publisherListLv.results[index].id,
                    gameName: publisherListLv.results[index].name,
                    flag: 2,

                  );
                  Navigator.pushNamed(context, PublisherDetails.routeName,arguments: publisherDetailsArguments);



                  },
                  child:

                  AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: publisherListLv.results.length,
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
                                          borderRadius: BorderRadius.circular(
                                              3)),


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
                                                '${publisherListLv
                                                    .results[index]
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


    String myText;


    ValueNotifier<String> notebe = ValueNotifier("");

//
//Widget showSearchedPublishers()
//    {
//      return Column(children: <Widget>[
//
//      Align(
//
//      alignment: Alignment.topCenter,
//      child: Directionality(
//      textDirection: TextDirection.ltr,
//
//      child: new Container(
//      height: SizeConfig
//              .heightMultiplier * 20,
//
//          child: Scrollbar(
//
//
//          child: ListView.builder(
//          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//          // physics: const NeverScrollableScrollPhysics(),
//
//
//          scrollDirection: Axis
//              .vertical,
//          shrinkWrap: true,
//
//          itemCount: publisherListDetails ==
//          null
//          ? 0
//              : publisherListDetails
//              .length,
//          itemBuilder: (context,
//          index) {
//        return new GestureDetector(
//
//            onTap: () {
//              /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//              //print("Passing id "+ platformListDetailsResult[index].id.toString());
////                                              Navigator.of(context).push(MaterialPageRoute(
////                                                  builder: (context) => PublisherDetailsState(publisherId:publisherListDetails[index].id,publisherName: publisherListDetails[index].name,
////
////
////                                                  ) ));
//
//              Navigator.push(
//                  context,
//                  PageTransition(
//                      type:
//                      PageTransitionType
//                          .rightToLeft,
//                      child: PublisherDetailsState(
//                        publisherId: publisherListDetails[index]
//                            .id,
//                        publisherName: publisherListDetails[index]
//                            .name,
//                        pageDirection: 2,)));
//
//              //;
//            },
//            child:
//
//            AnimationConfiguration
//                .staggeredGrid(
//                position: index,
//                duration: const Duration(
//                    milliseconds: 375),
//                columnCount: publisherListDetails
//
//                    .length,
//                child: ScaleAnimation(
//                    child: FadeInAnimation(
//                        child: Container(
//                            height: SizeConfig
//                                .heightMultiplier *
//                                8,
//                            width: SizeConfig
//                                .widthMultiplier *
//                                30,
////                              height: animation.value,
////                              width: animation.value,
//
//                            padding: EdgeInsets
//                                .only(
//                                left: 5.0,
//                                right: 5.0,
//                                top: 0.5),
//
//
//                            child: Card(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius
//                                        .circular(
//                                        3)),
//                                semanticContainer: true,
//
//
//                                color: Color
//                                    .fromRGBO(
//                                    32,
//                                    32,
//                                    32,
//                                    5),
//                                elevation: 10.0,
//
//                                child: Container(
//                                  height: SizeConfig
//                                      .heightMultiplier *
//                                      8,
//                                  width: SizeConfig
//                                      .widthMultiplier *
//                                      30,
//                                  child: Row(
//                                    //  mainAxisSize: MainAxisSize.max,
//                                    children: <
//                                        Widget>[
//
//
////                                                          Column(children: <Widget>[
//
//                                      Container(
//                                        height: SizeConfig
//                                            .heightMultiplier *
//                                            8,
//                                        width: SizeConfig
//                                            .widthMultiplier *
//                                            30,
//                                        padding: EdgeInsets
//                                            .all(
//                                            10),
//                                        //    decoration: BoxDecoration(color: Colors.white30,borderRadius: BorderRadius.all(Radius.circular(10))),
//                                        child: Text(
//                                          '${publisherListDetails
//                                          [index]
//                                              .name}',
//                                          style: AppTheme
//                                              .subTitleLights,
//                                          softWrap: true,
//                                          textScaleFactor: 1.0,
//                                        ),
//                                      ),
////                                      Container(
////                                        padding: EdgeInsets.all(10),
////                                        child: Text(
////                                          '${gameListDetails[index].re}',
////                                          style: TextStyle(color: Colors.white,),softWrap: true,
////                                        ),
////                                      ),
//
//
////                                                          ],),
//
//                                    ],
//
//                                  ),
//                                )))
//                    ))));
//      },
//      ))))
//
//
//      )
//
//      ]
//    }
//


    List<String>searchList = new List();
//SearchBoxExampleState().build(context);
//SearchBoxExampleState().mounted.runtimeType;
    return LayoutBuilder(builder: (context, constraints) {
    //  SearchBoxExampleState().editingController = new TextEditingController();
      //SearchBoxExampleState().textHasErrorNotifier=ValueNotifier( SearchBoxExampleState().editingController.text);
    //  SearchBoxExampleState().searchList = new List();


      GamePublisherPOJO loaderPublisherListLv;
      //PublisherDetailsState args = ModalRoute.of(context).settings.arguments;

      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return
//            MaterialApp(
////              routes:<String,WidgetBuilder>{
////
////                //PublisherHomePage.routeName: (context) => PublisherHomePage(),
////                "PublisherDetailsState": (context) =>
////                    PublisherDetailsState(
////                      //    publisherId:  args.publisherId,
////                      // publisherName:  args.publisherName,
////                        passArgu: passArgu
////
////
////                    ),
////              },
////
//              onGenerateRoute: Router.generateRoute,
//      routes: <String, WidgetBuilder>{
//      //  '/PublisherHomePage': (BuildContext context) => new PublisherHomePage( ),
//
//        '/PublisherDetailsState': (BuildContext context) => new PublisherDetailsState( passArgu: passArgu)
//      },
//
//////                routes:<String,WidgetBuilder> {
//////
//////                    // When navigating to the "/" route, build the FirstScreen widget.
//////                    // When navigating to the "/second" route, build the SecondScreen widget.
//////                    '/Homepage': (context) => Homepage(),
//////
//////                  //PublisherHomePage.routeName: (context) => PublisherHomePage(),
//////                  '/PublisherDetailsState': (context) =>  PublisherDetailsState(
//////        //    publisherId:  args.publisherId,
//////           // publisherName:  args.publisherName,
//////                    passArgu: passArgu,
//////
//////
//////
//////            ),
//////
//////                },
////
//              home:
//
                Scaffold(
                    backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                    resizeToAvoidBottomInset: false,
                    bottomNavigationBar:

                    Opacity(

                    opacity: editingController.text
                            .trim()
                            .isNotEmpty ? 0.0 : 1.0,
                        child: FutureBuilder(
                            future: restApiClient
                                .showPublisherList("com.gamersgram/1",1)
                                .then((GamePublisherPOJO responses) {
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
                            })),


                    body:
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


                                                Navigator.pushNamed(context, '/');

//                                                Navigator.pushReplacement(context,
//
//                                                    PageTransition(type:
//                                                    PageTransitionType
//                                                        .leftToRight,
//                                                        child: Homepage()));
                                              },
                                            )),
                                        Container(
                                            width: SizeConfig.widthMultiplier *
                                                80,

                                            alignment: Alignment.center,
                                            child:
                                            Text("Publisher List",
                                              style: AppTheme.mainTitles,
                                              textScaleFactor: 1.3,)),


                                      ],))),

//                            Container(
//                              //     height: SizeConfig.heightMultiplier*7,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
//                              child: platformSearchWidget(),),


                            Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 97,

                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: SizeConfig.heightMultiplier),


                              //  width: SizeConfig.widthMultiplier*100,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
                              child: Row(children: <Widget>[
                                Card(
                                    elevation: 6,
                                    color: Colors.white30,

                                    child:
                                    Container(
                                        width: SizeConfig.widthMultiplier * 70,
                                        height: SizeConfig.heightMultiplier * 8,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white30,
                                        ),
                                        //   padding: EdgeInsets.all(5),
                                        child: new Theme(
                                            data: new ThemeData(
                                              primaryColor: Colors.white10,
                                            ),
                                            child: new TextField(
                                              decoration: new InputDecoration(
//                                        border: new OutlineInputBorder(
//                                          borderSide: new BorderSide(color: Colors.blue),
//                                          borderRadius: BorderRadius.circular(40.0),
//                                        ),

                                                  filled: true,
                                                  hintStyle: new TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: "Search Publisher",
                                                  fillColor: Colors.white30),
                                              controller: editingController,

//
                                              onSubmitted: (c) {
//                                                setState(() {
//                                                  currentText = c;
//
//                                                  publisherListDetails =
//                                                  new List();
//                                                  editingController.text
//                                                      .length == 0
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
//                                                });
                                              },

                                              onChanged: (c) {
                                                //   setState(() {

                                                // editingController.text.trim().isEmpty? publisherListDetails=new List():Container(child: Text(""),);

                                                // editingController.text.trim().isEmpty? editingController.text="   ":Container(child: Text(""),);

                                                //  editingController.text.trim().isEmpty ?Container(child:Text("")):currentText;
                                                if (editingController.text
                                                    .trim()
                                                    .isEmpty) {
                                                  setState(() {
                                                    publisherListDetails =
                                                    new List();
                                                  });

                                                  print("empty" + currentText);
                                                  Container(child: Text(""),);
                                                }

                                                // });


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
//                                        editingController.text.isEmpty?  publisherListDetails=new List():Container();

                                            });
                                          },)
                                    )),


                              ],),),
//                                 Stack(
//                              alignment: Alignment.center,
//
//                              children: <Widget>[

//                            editingController.text.isNotEmpty?Text("Not empty"): Text("Empty"),
//                          editingController.text.length!=0?Text("Not empty 1"): Text("Empty 1"),
//                            editingController.text.trim()==" "?Text("Not empty 2"): Text("Empty 1"),

                            editingController.text
                                .trim()
                                .isEmpty
                                ? Container(child: Text(""))
                                : FutureBuilder(
                                future:
                                restApiClient.showSearchedPublisher(
                                    editingController.text)
                                    .then((GamePublisherPOJO responses) {
                                  //  GamePublisherPOJO publisherSearchedResponse;
                                  publisherSearchedResponse = responses;
                                  //  editingController.text="   ";
                                  print("INSIDE" + editingController.text);
                                  print("object" +
                                      responses.results.length.toString());
                                  publisherListDetails = new List();

                                  publisherListDetails.addAll(
                                      publisherSearchedResponse.results);
                                  // pageCount = 1;
                                }),
                                builder:
                                    (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (publisherSearchedResponse == null) {
                                    return Container(
                                        height: SizeConfig.heightMultiplier *
                                            20,
                                        child: FlareActor('assets/loader.flr',
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain,
                                            animation: "loader"


                                        ));
                                  }
                                  return
                                    publisherSearchedResponse.results.length !=0?

                                    Column(children: <Widget>[

                                    Align(

                                        alignment: Alignment.topCenter,
                                        child: SingleChildScrollView(
                                          //textDirection: TextDirection.ltr,
                                            scrollDirection: Axis.vertical,

                                            child: new Container(
                                                height: SizeConfig
                                                    .heightMultiplier * 70,

                                                child: Scrollbar(


                                                    child: ListView.builder(
                                                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                                      // physics: const NeverScrollableScrollPhysics(),


                                                      scrollDirection: Axis
                                                          .vertical,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.all(
                                                          SizeConfig
                                                              .heightMultiplier),

                                                      itemCount: publisherListDetails ==
                                                          null
                                                          ? 0
                                                          : publisherListDetails
                                                          .length,
                                                      itemBuilder: (context,
                                                          index) {
                                                        return new GestureDetector(

                                                            onTap: () {
//                                                              Navigator.pushNamed(
//                                                                context,
//                                                                "/PublisherDetailsState",
//                                                                arguments: PublisherDetailsState(
//                                                                 // publisherId:  publisherListLv.results[index].id,
//                                                                  //publisherName:  publisherListLv.results[index].name,
//                                                                  pageDirection: 2,
//
//
//                                                                ),
//                                                              )
//
//                                                              Navigator.of(context).push(MaterialPageRoute(
//                                                                  builder: (context) =>
//                                                                      PublisherDetailsState(
//                                                                        publisherId: publisherListLv.results[index].id,
//                                                                        publisherName: publisherListLv.results[index]
//                                                                            .name,
//                                                                        pageDirection: 2,
//
//
//                                                                      )))
//
//
//                                                              ;


                                                            YoutubeArguments publisherDetailsArguments=new YoutubeArguments(
                                                              gameId: publisherListDetails[index].id,
                                                              gameName: publisherListDetails[index].name,
                                                              flag: 2,
                                                            );
                                                            Navigator.pushNamed(context, PublisherDetails.routeName,arguments: publisherDetailsArguments);

                                                              /*
                              Switching and  passing data to TvShowDetailsPage
                            */
                                                              //print("Passing id "+ platformListDetailsResult[index].id.toString());
//                                              Navigator.of(context).push(MaterialPageRoute(
//                                                  builder: (context) => PublisherDetailsState(publisherId:publisherListDetails[index].id,publisherName: publisherListDetails[index].name,
//
//
//                                                  ) ));

//                                                                Navigator.push(
//                                                                    context,
//                                                                    PageTransition(
//                                                                        type:
//                                                                        PageTransitionType
//                                                                            .rightToLeft,
//                                                                        child: PublisherDetailsState(
//                                                                          publisherId: publisherListDetails[index]
//                                                                              .id,
//                                                                          publisherName: publisherListDetails[index]
//                                                                              .name,
//                                                                          pageDirection: 2,)));

                                                              //;
                                                            },
                                                            child:

                                                            AnimationConfiguration
                                                                .staggeredGrid(
                                                                position: index,
                                                                duration: const Duration(
                                                                    milliseconds: 375),
                                                                columnCount: publisherListDetails
                                                                    .length,
                                                                child: ScaleAnimation(
                                                                    child: FadeInAnimation(
                                                                        child: Container(
                                                                            height: SizeConfig
                                                                                .heightMultiplier *
                                                                                9,
                                                                            width: SizeConfig
                                                                                .widthMultiplier *
                                                                                30,
//                              height: animation.value,
//                              width: animation.value,
                                                                            decoration: BoxDecoration(
                                                                                border: Border
                                                                                    .all(
                                                                                    color: Colors
                                                                                        .white30)),
//                                        padding: EdgeInsets.only(
//                                            left: 5.0, right: 5.0, top: 0.5),


                                                                            child: Card(
                                                                                shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius
                                                                                        .circular(
                                                                                        3)),
                                                                                semanticContainer: true,


                                                                                color: Color
                                                                                    .fromRGBO(
                                                                                    32,
                                                                                    32,
                                                                                    32,
                                                                                    5),
                                                                                elevation: 8.0,

                                                                                child: Container(

                                                                                  child: Row(
                                                                                    //  mainAxisSize: MainAxisSize.max,
                                                                                    children: <
                                                                                        Widget>[
//
//      ),
//      )),

                                                                                      Expanded(
                                                                                          child:

                                                                                          Container(
                                                                                            // color: Colors.white30,
//                                              height:
//                                                  SizeConfig.heightMultiplier *
//                                                      5,
                                                                                            width:
                                                                                            SizeConfig
                                                                                                .widthMultiplier *
                                                                                                30,
                                                                                            padding: EdgeInsets
                                                                                                .all(
                                                                                                5),
                                                                                            // alignment: Alignment.topLeft,
                                                                                            child: publisherListDetails
                                                                                                .length ==
                                                                                                0
                                                                                                ?
                                                                                            Text(
                                                                                              "No search result found :(",
                                                                                              style: AppTheme
                                                                                                  .subTitleLights,
                                                                                              textScaleFactor: 1.0,
                                                                                              softWrap: true,
                                                                                            )
                                                                                                : Text(
                                                                                              '${publisherListDetails[index]
                                                                                                  .name}',
                                                                                              style: AppTheme
                                                                                                  .subTitleLights,
                                                                                              textScaleFactor: 1.0,
                                                                                              softWrap: true,
                                                                                            ),
                                                                                          )),

                                                                                    ],
                                                                                  ),
                                                                                )))
                                                                    ))));
                                                      },
                                                    ))))


                                    )

                                  ],):Container(
                                      height: SizeConfig.heightMultiplier*60,
                                      alignment: Alignment.center,
                                      child: Text("No result found :(",style: AppTheme.mainTitles,),);
                                }),


                            // SearchBoxExampleState().build(context),
                            // searchBoxExampleState.searchText(),


                            //   SearchBoxExampleState().build(context),

                            //     !mounted? Text( SearchBoxExampleState().myval()):Text("SAD "),
//                        state.mounted? Text(                            SearchBoxExampleState().widget.text.toString()
//                        ):Text("SAD "),

//                            ValueListenableBuilder(
//                              valueListenable: valueNotifier,
//                              builder: (context, value, child) {
//                                return Text(value);
//                              },
//                            ),


                            //SearchBoxExampleState().myval().isEmpty
                            // Text(SearchBoxExampleState().updateErrorText(SearchBoxExampleState().editingController.text)),


                            // appState.searchs(),
                            //Text(appState.getDisplayText),

                            //   SearchWidgetState(),
//
//                ValueListenableBuilder(
//                  valueListenable: notebe,
//                  builder: (BuildContext context,String vl,Widget child)
//                  {
//
//                    return SearchBoxExampleState().editingController.text.isNotEmpty?add():Text(        appState.getDisplayText,
//                    );
//                  },
//                ),

//                            SearchWidgetState(),
////                            appState.getDisplayText.contains(searchBoxExample.searchList)? searchBoxExample.SeachBox():
////                                Text("Trying"),
//
//                            searchBoxExample.searchList.contains(appState.getDisplayText)?searchBoxExample.searchList:
//                                Text("trying"),


//
//                            appState.getDisplayText.isEmpty ?Container(child:Text("ok")) :
//
//                FutureBuilder(
//          future:
//          restApiClient.showSearchedPublisher(  appState.getDisplayText)
//              .then((GamePublisherPOJO responses) {
//          //  GamePublisherPOJO publisherSearchedResponse;
//          publisherSearchedResponse = responses;
//          //  editingController.text="   ";
//          print("INSIDE"+editingController.text);
//          print("object" +responses.results.length.toString());
//          publisherListDetails = new List();
//          searchBoxExample.searchList=new List();
//
//
//          for(int i=0;i<publisherSearchedResponse.results.length;i++) {
//            searchBoxExample.searchList.add(
//                publisherSearchedResponse.results[i].name);
//            searchList.add(publisherSearchedResponse.results[i].name);
//            print("serach object"+searchBoxExample.searchList[i].toString());
//          }
//          publisherListDetails.addAll(
//          publisherSearchedResponse.results);
//          // pageCount = 1;
//          }),
//          builder:
//          (BuildContext context,
//          AsyncSnapshot snapshot) {
//          if (snapshot.hashCode == null) {
//          return Container(
//          height: SizeConfig.heightMultiplier *
//          20,
//          child: FlareActor('assets/loader.flr',
//          alignment: Alignment.center,
//          fit: BoxFit.contain,
//          animation: "loader"
//
//
//          ));
//          }
//          return Column(children: <Widget>[
//
//            searchBoxExample.SeachBox(),
//
//          ],);
//          }),


                            //: Container(height: SizeConfig.heightMultiplier*5,),


//            Expanded(
//              child: Container(

                            //child:

                            //  publisherListLv==null?
//                                loaderPublisherListLv == null?       Center(
//          child: Container(
//          height: SizeConfig
//              .heightMultiplier * 20,
//
//          child: FlareActor(
//          'assets/loader.flr',
//          alignment: Alignment.center,
//          fit: BoxFit.contain,
//          animation: "loader"
//
//
//          ))) :


                            Opacity(


                                opacity: editingController.text
                                    .trim()
                                    .isNotEmpty ? 0.0 : 1.0,
                                child:
                                FutureBuilder(
                                    future: restApiClient
                                        .showPublisherList("com.gamersgram/1",pageCount)
                                        .then((GamePublisherPOJO responses) {
                                      publisherListLv = responses;
                                      loaderPublisherListLv = responses;
                                    }

                                    ),
                                    builder:
                                        (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hashCode == 0) {
                                        print("Data");
                                      }
                                      else {
                                        print("Data receved");
                                      }

                                      if (loaderPublisherListLv == null) {
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
                                              child: publisherListWidget(),


                                            )


                                            //     footerWidget()

                                          ],);
                                      }
                                    })),


                            //   ],)


                            // )),


                            // Divider(color: Colors.red,thickness: 2.0,),


//                    ],
//                  ),

                          ]),
                        )
                      ],
                      // ),


                    )

                // )


                );
          //);
        },
      );
    });
  }
}
