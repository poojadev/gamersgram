



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/tags/TagsPOJO.dart';
import 'package:gamersgram/tags/details/TagWiseGameList.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

//Widget tagListWidget(GameTagsPOJO tagsList) {
//  return
//    Align(alignment: Alignment.topCenter,
//        child: Directionality(
//            textDirection: TextDirection.ltr,
//
//            child: new Container(
//                height: 50.0,
//                child:
//                ListView.builder(
//                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                  // physics: const NeverScrollableScrollPhysics(),
//
//
//                  scrollDirection: Axis.horizontal,
//                  shrinkWrap: true,
//                  itemCount: tagsList == null ? 0 : tagsList.results.length,
//                  itemBuilder: (context, index) {
//                    print("Lenght of tags" +tagsList.results.length.toString());
//                    return  new GestureDetector(
//
//                        onTap: () {
//                          /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//                          print("PRESSING");
//
//
////
////                            storeList.results[index].clip==null ?
////
//
////                            Navigator.of(context).push(MaterialPageRoute(
////                                builder: (context) => GameDetailsStates(screenShots:gameList.results[index].short_screenshots,gameName: gameList.results[index].name,
////                                  released: gameList.results[index].released,
////                                  rating: gameList.results[index].rating,
////                                  stores: gameList.results[index].stores,
////                                  clip: gameList.results[index].clip.clip,
////                                  genres: gameList.results[index].genres,
////                                  platforms: gameList.results[index].platforms,
////                                  flag: 1,
////
////
////                                ) ))
//
//
//                          ;
//                        },
//                        child: AnimationConfiguration.staggeredGrid(
//                            position: index,
//                            duration: const Duration(milliseconds: 375),
//                            columnCount: tagsList.results.length,
//                            child: ScaleAnimation(
//                                child: FadeInAnimation(
//                                    child: Container(
//                                   padding: EdgeInsets.only(left: 5,right: 5),
//                                   //   padding: EdgeInsets.all(10),
//
//                                      height: 20,
//                                    child:  RaisedButton(
//
//
//
//                                        child:  Text(
//                                          '${"#"+tagsList.results[index].name}',
//                                          style: TextStyle(color: Colors.white,),softWrap: true,
//                                        ),
//                                        elevation: 11,
//                                       // shape: CircleBorder(side: BorderSide(color: Colors.black12)),
//
//                    shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.only(
//                    topRight: Radius.circular(25.0),
//                    topLeft: Radius.circular(25.0),
//                    bottomRight: Radius.circular(25.0),
//                      bottomLeft: Radius.circular(25.0)
//                    ),),
//                                        color: Color.fromRGBO(40, 40, 40, 20) ,
//                                        onPressed: (){
//
//                                          Navigator.of(context).push(MaterialPageRoute(
//                                              builder: (context) => TagWiseGameListState(
//
//                                                tagName: tagsList.results[index].name,
//                                                id:  tagsList.results[index].id,
//                                              ) ));
//
//
//                                        },
//
//                                      ),
//                                            )
//                                ))));
//
//
//                  },
//                ))) );
//}
//
//


Widget tagListWidget(GameTagsPOJO tagsList) {
  return Align(
      alignment: Alignment.topCenter,
      child: Directionality(
          textDirection: TextDirection.ltr,
          child: new Container(
              height: SizeConfig.heightMultiplier * 11,
              child: ListView.builder(
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                // physics: const NeverScrollableScrollPhysics(),

                scrollDirection: Axis.horizontal,
//                shrinkWrap: true,

                shrinkWrap: true,
                itemCount: tagsList == null ? 0 : tagsList.results.length,
                itemBuilder: (context, index) {
                  //     print("Lenght of tags" +tagsList.results.length.toString());

                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: tagsList.results.length,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                            child: Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.heightMultiplier + 2),
                                //    height: SizeConfig.heightMultiplier * 12,

                                child: GestureDetector(
                                    onTap: () {
                                      YoutubeArguments tagwiseGameArguments=new YoutubeArguments(tagId: tagsList.results[index].id,
                                          tagName: tagsList.results[index].name,flag: 1);
                                      Navigator.pushNamed(context, "/TagWiseGameListState",arguments: tagwiseGameArguments);


//                                              Navigator.of(context).push(MaterialPageRoute(
//                                                  builder: (context) =>NavSlideFromRight(page: TagWiseGameListState(
//
//                                                    tagName: tagsList.results[index].name,
//                                                    id:  tagsList.results[index].id,
//                                                  )
//
//
//
//                                              )));

                                    },
                                    child: new Container(
                                        height: SizeConfig.heightMultiplier * 8,
                                        width: SizeConfig.widthMultiplier * 40,

                                        // padding: EdgeInsets.only(left: 10,right: 10),
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white30),
                                            color: Colors.transparent,
                                            borderRadius: new BorderRadius.only(
                                              //   bottomLeft:const Radius.circular(30.0) ,
                                                bottomRight:
                                                const Radius.circular(40.0),
                                                // topLeft: const Radius.circular(30.0),
                                                topRight: const Radius.circular(
                                                    40.0))),
                                        child: Row(children: <Widget>[
                                          //padding: EdgeInsets.all(5),
                                          //   padding: EdgeInsets.all(10),

                                          //  height: SizeConfig.heightMultiplier*10,
                                          Container(
                                              height:
                                              SizeConfig.heightMultiplier *
                                                  8,
                                              width:
                                              SizeConfig.widthMultiplier *
                                                  10,
                                              //  padding: EdgeInsets.only(left: 10),

                                              decoration: new BoxDecoration(
                                                  color: Colors.white30,
                                                  border: Border.all(
                                                      color: Colors.white30),
                                                  borderRadius: new BorderRadius
                                                      .only(
                                                    // bottomLeft:const Radius.circular(40.0) ,
                                                      bottomRight:
                                                      const Radius.circular(
                                                          40.0),
                                                      //   topLeft: const Radius.circular(40.0),
                                                      topRight:
                                                      const Radius.circular(
                                                          40.0))),
//                                                  child: Align(
//
//
//                                                    alignment: Alignment.center,
//                                                    child:Image.asset("assets/images/publisher.png"
//
//                                                    ),
//
//                                                  )
//                                              ),

                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '#',
                                                  style: AppTheme.textGridTitle,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1.5,

                                                ),
                                              )),

                                          Expanded(
                                            child:
                                            Container(

                                              padding: EdgeInsets.only(left: 1 *
                                                  SizeConfig.heightMultiplier),
                                              child: Text(
                                                tagsList.results[index].name,
                                                style: AppTheme.subTitleLights,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: 1.2,

                                              ),
                                            ),),
                                        ]))))),
                      ));
                },
              ))));
}
