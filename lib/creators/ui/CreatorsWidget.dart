import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/creators/details/CreatorDetails.dart';
import 'package:gamersgram/creators/model/GameCreatorsPOJO.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

Widget gameCreatorsWidget(GameCreatorsPOJO creatorsList) {
 // print("INSIDE STORE");
  return
    Align(alignment: Alignment.topCenter,
        child: Directionality(
            textDirection: TextDirection.ltr,

            child: new Container(
                height: SizeConfig.heightMultiplier * 24,
                child:
                ListView.builder(
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  // physics: const NeverScrollableScrollPhysics(),


                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: creatorsList == null ? 0 : creatorsList.results
                      .length,
                  itemBuilder: (context, index) {
                    print("Lenght of store" +creatorsList.results.length.toString());
                    return  new GestureDetector(

                        onTap: () {
                          /*
                              Switching and  passing data to TvShowDetailsPage
                            */


//
//                            storeList.results[index].clip==null ?
//
//                            Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) => CreatorDetailsState(id: creatorsList.results[index].id,creatorImageUrl: creatorsList.results[index].image,
//                                ) ));



                          YoutubeArguments creatorDetailsArguments=new YoutubeArguments(
                              gameName:  creatorsList.results[index]
                                  .name,
                              gameId:  creatorsList.results[index]
                                  .id,
                              imgUrl: creatorsList.results[index].image,
                              flag: 1
                          );
                          Navigator.pushNamed(context, CreatorDetails.routeName,arguments: creatorDetailsArguments);

//                            Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) => GameDetailsStates(screenShots:gameList.results[index].short_screenshots,gameName: gameList.results[index].name,
//                                  released: gameList.results[index].released,
//                                  rating: gameList.results[index].rating,
//                                  stores: gameList.results[index].stores,
//                                  clip: gameList.results[index].clip.clip,
//                                  genres: gameList.results[index].genres,
//                                  platforms: gameList.results[index].platforms,
//                                  flag: 1,
//
//
//                                ) ))


                          ;
                        },
                        child: AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: creatorsList.results.length,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Container(
                                      width: SizeConfig.widthMultiplier * 40,

                                      padding: EdgeInsets.only(left: 1 *
                                          SizeConfig.heightMultiplier,
                                          right: 1 *
                                              SizeConfig.heightMultiplier,
                                          bottom: 1 *
                                              SizeConfig.heightMultiplier),
                                      child: Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          creatorsList.results[index]
                                              .image !=
                                              null
                                              ? Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .white30)),
//                                                      padding: EdgeInsets.only(left: 1 * SizeConfig.heightMultiplier,right:1 * SizeConfig.heightMultiplier,
//                                                      bottom: 1 * SizeConfig.heightMultiplier),

                                            height: SizeConfig
                                                .heightMultiplier *
                                                17,
                                            width: SizeConfig
                                                .widthMultiplier *
                                                34,

                                            child:


                                            CachedNetworkImage(
                                              imageUrl: creatorsList
                                                  .results[index]
                                                  .image,
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
                                            child: Text("NO Image"),
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
                                                  7.8,
                                              width: SizeConfig
                                                  .widthMultiplier *
                                                  34,
                                              padding: EdgeInsets.only(left: 1 *
                                                  SizeConfig.heightMultiplier,
                                                  top: 2),
                                              child: Text(
                                                creatorsList.results[index]
                                                    .name,
                                                style: AppTheme.subTitleLights,
                                                textScaleFactor: 1.2,

                                                //  textAlign: TextAlign.center,
                                              ),
                                            ),),
                                          //),
                                        ],
                                      )),))));


                  },
                ))) );
}
