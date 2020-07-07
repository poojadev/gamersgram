import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/details/CreatorDetails.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/util/constants.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

var dio = new Dio()..options.baseUrl = AppConstants.BASE_URL;
RestApiClient restApiClient = new RestApiClient(dio);
AppConstants appConstants = new AppConstants();

class CreatorHomePage extends StatelessWidget {
  static const routeName = '/creatorhomepage';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,

      body: CreatorHomePageState(),
    );
  }
}

class CreatorHomePageState extends StatefulWidget {
  CreatorHomePageState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CreatorHomePageState createState() => _CreatorHomePageState();
}

class _CreatorHomePageState extends State<CreatorHomePageState> {
  GlobalKey<AutoCompleteTextFieldState<CreatorsResult>> key = new GlobalKey();
  GameCreatorsPOJO creatorList;

  GameCreatorsPOJO creatorSearchResponse;

  int pageCount = 1;
  int count;
  List<int> pages = new List();

//  List<PlatformListDetails>platformListDetails=new List();
//  List<PlatformListDetails>platformListDetailsResult=new List();

//



//
//
//
//
//
//
//    platformListDetails=new List();

  String currentText = "@#%";
  GameCreatorsPOJO creatorListDetails;
  List<CreatorsResult> allCreatorListDetails = new List();

  AutoCompleteTextField<CreatorsResult> textField;
  TextEditingController editingController = new TextEditingController();
  String tagName;
  Widget allCreatorList(GameCreatorsPOJO creatorList) {
    return Container(
        //  padding: EdgeInsets.only(left: 5,right: 5),
//        decoration: BoxDecoration(
//          //  color: Colors.red,
//            borderRadius:
//            BorderRadius
//                .all(Radius
//                .circular(
//                1)),
//            border: Border.all(color:
//            Colors.white30)
//        ),
        height: pages.length == 0
            ? SizeConfig.heightMultiplier * 73
            : SizeConfig.heightMultiplier * 63,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          //  physics: const ScrollPhysics(),

          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: creatorList == null ? 0 : creatorList.results.length,
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  /*
                              Switching and  passing data to TvShowDetailsPage
                            */

                  print("creators objcet"+  creatorList.results[index]
                      .name);
                  YoutubeArguments creatorDetailsArguments=new YoutubeArguments(
                    gameName:  creatorList.results[index]
                              .name,
                    gameId:  creatorList.results[index]
                        .id,
                    imgUrl: creatorList.results[index].image,
                    flag: 2
                  );
                  Navigator.pushNamed(context, CreatorDetails.routeName,arguments: creatorDetailsArguments);

//                  Navigator.push(context,
//                      PageTransition(type:
//                      PageTransitionType.leftToRight,
//                          child: CreatorDetailsState(
//                            id: creatorList.results[index].id,
//                            creatorImageUrl: creatorList
//                                .results[index].image,
//                            creatorName: creatorList.results[index]
//                                .name,
//                            pageDirection: 2,
//                          )));

                },
                child: AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: creatorList.results.length,
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
                              creatorList.results[index].image != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                      height:
                                          SizeConfig.imageSizeMultiplier * 20,
                                      width: SizeConfig.widthMultiplier * 34,

                                      child: CachedNetworkImage(
                                        imageUrl:
                                            creatorList.results[index].image,
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
                                                    alignment: Alignment.center,
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
                                          SizeConfig.imageSizeMultiplier * 20,
                                      width: SizeConfig.widthMultiplier * 34,
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
                                      border:
                                          Border.all(color: Colors.white30)),
                                  height: SizeConfig.heightMultiplier * 6.8,
                                  width: SizeConfig.widthMultiplier * 34,
                                  padding: EdgeInsets.only(
                                      left: 1 * SizeConfig.heightMultiplier,
                                      top: 2),
                                  child: Text(
                                    creatorList.results[index].name,
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
  }

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
                                        creatorList = null;

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


  // platformListDetailsResult=new List();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return  Scaffold(
              resizeToAvoidBottomInset:false,
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  bottomNavigationBar: Opacity(


                      opacity: editingController.text
                          .trim()
                          .isNotEmpty ? 0.0 : 1.0,
                      child: FutureBuilder(
                          future: restApiClient
                              .showGameCreators("com.gamersgram/1",1)
                              .then((GameCreatorsPOJO responses) {
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
                                              Navigator.pushNamed(context,"/");
//                                              Navigator.push(context,
//
//                                                  PageTransition(type:
//                                                  PageTransitionType
//                                                      .leftToRight,
//                                                      child: Homepage()));
                                            },
                                          )),
                                      Container(
                                          width: SizeConfig.widthMultiplier *
                                              80,

                                          alignment: Alignment.center,
                                          child:
                                          Text("Creators List",
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.3,)),


                                    ],))),

                          // footerWidget(),

//                  Container(
//                    padding: EdgeInsets.only(left: 2,right: 2,top: 10),
//                    color: Colors.black45,
//
//
//
//                    child:
//

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
                                                hintText: "Search Creators",
                                                fillColor: Colors.white30),
                                            controller: editingController,
                                            onSubmitted: (c) {
//                                              setState(() {
//                                                currentText = c;
//
//                                                allCreatorListDetails =
//                                                new List();
//                                                editingController.text.length ==
//                                                    0
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
          editingController.text.isEmpty? setState(() {

                                              // editingController.text.trim().isEmpty? publisherListDetails=new List():Container(child: Text(""),);

                                              // editingController.text.trim().isEmpty? editingController.text="   ":Container(child: Text(""),);

                                              //  editingController.text.trim().isEmpty ?Container(child:Text("")):currentText;
                                              if (editingController.text
                                                  .trim()
                                                  .isEmpty) {
                                                setState(() {
                                                  allCreatorListDetails =
                                                  new List();
                                                });

                                                print("empty" + currentText);
                                              }

                                               })                    :                            Container(child: Text(""),);



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

                          editingController.text
                              .trim()
                              .isEmpty
                              ? Container(child: Text(""))
                              : FutureBuilder(
                              future:
                              restApiClient.showSearchedCreator("com.gamersgram/1",
                                  editingController.text)
                                  .then((GameCreatorsPOJO responses) {
                                //  GamePublisherPOJO publisherSearchedResponse;
                                creatorSearchResponse = responses;
                                //  editingController.text="   ";
                                print("INSIDE" + editingController.text);
                                print("object" +
                                    responses.results.length.toString());
                                allCreatorListDetails = new List();

                                allCreatorListDetails.addAll(
                                    creatorSearchResponse.results);
                                // pageCount = 1;
                              }),
                              builder:
                                  (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (creatorSearchResponse == null) {
                                  return Container(
                                      height: SizeConfig.heightMultiplier *
                                          20,
                                      child: FlareActor('assets/loader.flr',
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                          animation: "loader"


                                      ));
                                }
                                return  creatorSearchResponse.results.length!=0? Column(children: <Widget>[

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

                                                    itemCount: allCreatorListDetails ==
                                                        null
                                                        ? 0
                                                        : allCreatorListDetails
                                                        .length,
                                                    itemBuilder: (context,
                                                        index) {
                                                      return new GestureDetector(

                                                          onTap: () {

                                                            YoutubeArguments creatorDetailsArguments=new YoutubeArguments(
                                                                gameName:  allCreatorListDetails[index]
                                                                    .name,
                                                                gameId:  allCreatorListDetails[index]
                                                                    .id,
                                                                imgUrl: allCreatorListDetails[index].image,
                                                                flag: 2
                                                            );
                                                            Navigator.pushNamed(context, CreatorDetails.routeName,arguments: creatorDetailsArguments);

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
                                                              columnCount: allCreatorListDetails
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
                                                                                          child: allCreatorListDetails
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
                                                                                            '${allCreatorListDetails[index]
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

                                ],):Center(child: Text("No result found",style: AppTheme.mainTitles,),);
                              }),

//            Expanded(
//              child: Container(

                          //child:

          Visibility(
            visible:  editingController.text .isEmpty?true:false,


          //opacity: editingController.text .isNotEmpty?  0.0:1.0,

                              child:
                              FutureBuilder(
                                  future: restApiClient
                                      .showGameCreators("com.gamersgram/1",pageCount)
                                      .then((GameCreatorsPOJO responses) {
                                    creatorList = responses;
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

                                    if (creatorList == null) {
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
                                            child: allCreatorList(creatorList),


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
