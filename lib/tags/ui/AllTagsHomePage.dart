import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/generated/i18n.dart';
import 'package:gamersgram/publishers/detail/PublisherDetails.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:dio/dio.dart';
import 'package:gamersgram/tags/TagsPOJO.dart';
import 'package:gamersgram/tags/details/TagWiseGameList.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();

class AllTagsHomePage extends StatelessWidget {
  // This widget is the root of your application.

  static const routeName = '/alltagshomepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AllTagsHomePageState(),
    );
  }
}

class AllTagsHomePageState extends StatefulWidget {
  AllTagsHomePageState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AllTagsHomePageState createState() => _AllTagsHomePageState();
}

class _AllTagsHomePageState extends State<AllTagsHomePageState> {
  int pageCount = 1;
  int count;
  List<int> pages = new List();
  GlobalKey<AutoCompleteTextFieldState<TagResult>> key = new GlobalKey();

  // AutoCompleteTextField searchTextField;
  AutoCompleteTextField<TagResult> textField;
  TextEditingController editingController = new TextEditingController();

  //List<Result>publisherSuggestionsAc=new List();

  //List<GamePublisherResult>publisherDetailsResult=new List();

  String currentText = "@#%";


  //  publisherSuggestionsAc=new List();

  int pageNumber = 1;


  List<TagResult> allTagsListDetails = new List();
  GameTagsPOJO tagSearchResponse;

  // platformListDetailsResult=new List();
  @override
  Widget build(BuildContext context) {
    print("PAGECONT" + SizeConfig.heightMultiplier.toString());
    GameTagsPOJO allTagsList;

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
                        color: pageCount == index ? Colors.red : Colors.black,
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
                            ))

                      //  subtitle: Text('${games.result[index].platformDetails[0].details.id}'),
                    )
                        : Container(),
                  );
                },
              )));
    }

    Widget allTagsListWidget() {
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

            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: allTagsList == null ? 0 : allTagsList.results.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    /*
                              Switching and  passing data to TvShowDetailsPage
                            */

//
                    YoutubeArguments tagwiseGameArguments=new YoutubeArguments(tagId: allTagsList.results[index].id,
                        tagName: allTagsList.results[index].name,flag: 2);
                    Navigator.pushNamed(context, "/TagWiseGameListState",arguments: tagwiseGameArguments);

                  },
                  child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: allTagsList.results.length,
                      child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: Container(
                                  height: SizeConfig.heightMultiplier * 9,
                                  width: SizeConfig.widthMultiplier * 30,
//                              height: animation.value,
//                              width: animation.value,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white30)),
//                                        padding: EdgeInsets.only(
//                                            left: 5.0, right: 5.0, top: 0.5),

                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3)),
                                      semanticContainer: true,
                                      color: Color.fromRGBO(32, 32, 32, 5),
                                      elevation: 8.0,
                                      child: Container(
                                        child: Row(
                                          //  mainAxisSize: MainAxisSize.max,
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

                                            Expanded(
                                                child: Container(
                                                  // color: Colors.white30,
//                                              height:
//                                                  SizeConfig.heightMultiplier *
//                                                      5,
                                                  width:
                                                  SizeConfig.widthMultiplier * 30,
                                                  padding: EdgeInsets.all(5),
                                                  // alignment: Alignment.topLeft,
                                                  child: Text(
                                                    '${allTagsList.results[index].name}',
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
            resizeToAvoidBottomInset: false,
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  bottomNavigationBar:
                  Opacity(


                      opacity: editingController.text
                          .trim()
                          .isNotEmpty ? 0.0 : 1.0,
                      child: FutureBuilder(
                          future: restApiClient
                              .showGameTags("com.gamersgram/1",1)
                              .then((GameTagsPOJO responses) {
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
                                            Navigator.pushNamed(context,

                                              '/')   ;                                         },
                                          )),
                                      Container(
                                          width:
                                              SizeConfig.widthMultiplier * 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Tags List",
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.2,
                                          )),
                                    ],
                                  ))),



                          Container(
                            height: SizeConfig.heightMultiplier * 9,
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
                                                hintText: "Search Tags",
                                                fillColor: Colors.white30),
                                            controller: editingController,

//
                                            onSubmitted: (c) {
//                                              setState(() {
//                                                currentText = c;
//
//                                                allTagsListDetails =
//                                                new List();
//                                                editingController.text
//                                                    .length == 0
//                                                    ?
//                                                editingController.text = "   "
//                                                    : Container();
//                                                ;
//
//                                                print("onSubmitted" +
//                                                    currentText);
//                                                ;
//                                                //   print("INSIDE"+editingController.text);
//
//                                              });
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
                                                  allTagsListDetails =
                                                  new List();
                                                });

                                                print("empty" + currentText);
                                                Container(child: Text(""),);
                                              }

                                              // });


                                            },



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

                          editingController.text
                              .trim()
                              .isEmpty
                              ? Container(child: Text(""))
                              : FutureBuilder(
                              future:
                               restApiClient
                              .showSearchedTags(  "com.gamersgram/1",  editingController.text
                               )
                              .then((GameTagsPOJO responses) {
                            tagSearchResponse = responses;
                            allTagsListDetails = new List();

                            allTagsListDetails
                              .addAll(
                                tagSearchResponse.results);
                                // pageCount = 1;
                              }),
                              builder:
                                  (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (tagSearchResponse == null) {
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
                                  tagSearchResponse.results.length!=0?

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

                                                    itemCount: allTagsListDetails ==
                                                        null
                                                        ? 0
                                                        : allTagsListDetails
                                                        .length,
                                                    itemBuilder: (context,
                                                        index) {
                                                      return new GestureDetector(

                                                          onTap: () {
                                                            YoutubeArguments tagwiseGameArguments=new YoutubeArguments(gameId: allTagsListDetails[index].id,
                                                            tagName: allTagsListDetails[index].name,flag: 2);
                                                            Navigator.pushNamed(context, "/TagWiseGameListState",arguments: tagwiseGameArguments);

//                                                            Navigator.of(context).push(MaterialPageRoute(
//                                                                builder: (context) => TagWiseGameListState(id:allTagsList.results[index].id,
//                                                                  tagName:allTagsList.results[index].name ,pageDirection: 2,
//
//
//                                                                ) ));
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
                                                              columnCount: allTagsListDetails
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
                                                                                          child: allTagsListDetails
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
                                                                                            '${allTagsListDetails[index]
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

                                ],):Container(height: SizeConfig.heightMultiplier*10,alignment: Alignment.center,

                                  child: Text("No result found :(",style: AppTheme.mainTitles,),);
                              }),


//            Expanded(
//              child: Container(

                          //child:

                          //  publisherListLv==null?

                          Opacity(


                              opacity: editingController.text
                                  .trim()
                                  .isNotEmpty ? 0.0 : 1.0,
                              child:
                              FutureBuilder(
                                  future: restApiClient
                                      .showGameTags("com.gamersgram/1",pageCount)
                                      .then((GameTagsPOJO responses) {
                                    allTagsList = responses;
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

                                    if (allTagsList == null) {
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
                                            child: allTagsListWidget(),


                                          )


                                          //     footerWidget()

                                        ],);
                                    }
                                  })),
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

