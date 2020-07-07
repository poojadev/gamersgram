/*
        Game Platform list
     */
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/platforms/platformdescription/ui/PlatformDetailsWithGaames.dart';
import 'package:gamersgram/network/restApiClient.dart';
import 'package:gamersgram/platforms/model/PlatformListPOJO.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';


//Widget platformListWidget(PlatformList platformList) {
//  return
//    Align(alignment: Alignment.topCenter,
//        child: Directionality(
//            textDirection: TextDirection.ltr,
//
//            child: new Container(
//                height: 200.0,
//                child:
//                ListView.builder(
//                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                  // physics: const NeverScrollableScrollPhysics(),
//
//
//                  scrollDirection: Axis.horizontal,
//                  shrinkWrap: true,
//                  itemCount: platformList == null ? 0 :5,
//                  itemBuilder: (context, index) {
//                    return new GestureDetector(
//
//                        onTap: () {
//                          /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//
//
//
//
//
//                          print("Passing id "+ platformList.results[index].id.toString());
//                          Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => PlatformDetailsStates(platformId:platformList.results[index].id
//
//
//                              ) ))
//
//
//                          ;
//                        },
//                        child:
//
//                        AnimationConfiguration.staggeredGrid(
//                            position: index,
//                            duration: const Duration(milliseconds: 375),
//                            columnCount: platformList.results.length,
//                            child: ScaleAnimation(
//                                child: FadeInAnimation(
//                                    child: Container(
//                                        height: 200,
//                                        width: 170,
////                              height: animation.value,
////                              width: animation.value,
//
//                                        padding: EdgeInsets.only(
//                                            left: 5.0, right: 5.0, top: 0.5),
//
//
//                                        child: Card(
//                                            shape:  RoundedRectangleBorder(
//                                                borderRadius: BorderRadius.circular(3)),
//                                            semanticContainer: true,
//
//
//                                            color: Color.fromRGBO(32, 32, 32, 5),
//                                            elevation: 10.0,
//
//                                            child: Container(
//
//                                              child: Column(
//                                                //  mainAxisSize: MainAxisSize.max,
//                                                children: <Widget>[
//                                                  Container(
//
//
//                                                    height: 120,
//
//
//                                                    child: Image.network(
//                                                      platformList.results[index]
//                                                          .image_background,
//                                                      fit: BoxFit.fill,
//                                                    ),
//
//                                                  ),
//
//                                                  Container(
//                                                    padding: EdgeInsets.all(10),
//                                                    child: Text(
//                                                      '${platformList.results[index].name}',
//                                                      style: TextStyle(color: Colors.white,),softWrap: true,
//                                                    ),
//                                                  ),
//
//                                                ],
//                                              ),
//                                            )))
//                                ))));
//
//
//                  },
//                ))) );
//}
//
//


Widget platformListWidget(PlatformList platformList) {
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
                itemCount: platformList == null ? 0 : platformList.results
                    .length,
                itemBuilder: (context, index) {
                  //     print("Lenght of tags" +tagsList.results.length.toString());

                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: platformList.results.length,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                            child: Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.heightMultiplier + 2),
                                //    height: SizeConfig.heightMultiplier * 12,

                                child: GestureDetector(
                                    onTap: () {




                                      YoutubeArguments platformArguments = new YoutubeArguments(
                                          gameId: platformList.results[index].id,
                                          gameName: platformList.results[index].name,
                                          flag: 1
                                      );
                                      Navigator.pushNamed(context, PlatformDetailsWithGames.routeName,arguments: platformArguments);

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
                                        width: SizeConfig.widthMultiplier * 35,

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
                                                child: Icon(
                                                  Icons.videogame_asset,
                                                  color: Colors.white,
                                                  size: 6 * SizeConfig
                                                      .imageSizeMultiplier,

                                                ),
                                              )),

                                          Expanded(
                                            child:
                                            Container(

                                              padding: EdgeInsets.only(left: 1 *
                                                  SizeConfig.heightMultiplier),
                                              child: Text(
                                                platformList.results[index]
                                                    .name,
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
