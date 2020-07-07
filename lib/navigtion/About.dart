import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/creators/ui/CreatorHomePage.dart';
import 'package:gamersgram/dashboard/homepage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
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


class About extends StatelessWidget {
  static const String routeName="/About";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(21, 21, 21, 5),

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
//                                   Navigator.pushNamed(context,
//
//                                        '/');

                                    Navigator.of(context, rootNavigator: true).pop(context);


                                  },
                                )),
                            Container(
                                width: SizeConfig.widthMultiplier *
                                    80,

                                alignment: Alignment.center,
                                child:
                                Text("About",
                                  style: AppTheme.mainTitles,
                                  textScaleFactor: 1.2,)),


                          ],))),
//              Container(
//
//              padding: EdgeInsets.only(top: 5),
//              height: SizeConfig.heightMultiplier * 100,
//                      child:

                Container(

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
                  child: SingleChildScrollView(

                    // color: Colors.yellowAccent,

                    // height: SizeConfig.heightMultiplier * 10,
                    child:

    Container(
      alignment: Alignment.center,
//    scrollDirection:
//    Axis.vertical,

    height: SizeConfig.heightMultiplier*90,
    width: SizeConfig.widthMultiplier*90,
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


    child:
        Center(child:
    Column(children: <Widget>[

    Container(
      alignment: Alignment.center,
//      height: SizeConfig
//          .heightMultiplier *
//        10,
//
//        decoration:
//        BoxDecoration(
//            border: Border.all(color:Colors.white30,width: 2),
//            shape: BoxShape.circle,),


    child: Image.asset("assets/gz.png",
    height: SizeConfig.heightMultiplier * 12,
    )),



      Text(

            "Gamergram is a place where you can get all the information about the gaming industry "
            "and stay up to date with upcoming games. Gamergram is developed for gamers by gamers. "
            "Thanks to rawg.io for the data API's."





        ,
        style: AppTheme
            .subTitleLights,
        textScaleFactor:
        1.1,
        textAlign: TextAlign.justify,
        softWrap: true,
      ),

    ],)),


    padding: EdgeInsets
        .only(
    left: SizeConfig
        .heightMultiplier +
    5,
    right: SizeConfig
        .heightMultiplier +
    5),
//
    )),







                  ),


                ])
          )]));

  }
}

