
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/genres/details/GenresDetails.dart';
import 'package:gamersgram/genres/model/GenresPOJO.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';



/*
    Genres list
     */

//Widget genresGalleryWidget(GenresPOJO genresList)
//{
//  // print("INSIDE STORE");
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
//                  itemCount: genresList == null ? 0 : genresList.results.length,
//                  itemBuilder: (context, index) {
//                   // print("Lenght of store" +genresList.results.length.toString());
//                    return  new GestureDetector(
//
//                        onTap: () {
//                          /*
//                              Switching and  passing data to TvShowDetailsPage
//                            */
//
//
////
////                            storeList.results[index].clip==null ?
////
//                          Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => GenresDetailsState(id: genresList.results[index].id,
//                              ) ));
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
//                              ;
//                        },
//                        child: AnimationConfiguration.staggeredGrid(
//                            position: index,
//                            duration: const Duration(milliseconds: 375),
//                            columnCount: genresList.results.length,
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
//                                                  genresList.results[index] .image_background!=null?   CircleAvatar(
//                                                    radius: 60.0,
//                                                    backgroundImage:
//                                                    NetworkImage("${genresList.results[index].image_background}"),
//                                                    backgroundColor: Colors.transparent,
//
//
//                                                  ):Container(
//                                                    child: Text("NO image"),
//                                                  )
//
//                                                  ,
//
//                                                  Container(
//
//                                                    padding: EdgeInsets.all(10),
//                                                    child: Text(
//                                                      '${genresList.results[index].name}',
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


Widget genresGalleryWidget(GenresPOJO genresList) {
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
                itemCount: genresList == null ? 0 : genresList.results.length,
                itemBuilder: (context, index) {
                  //     print("Lenght of tags" +tagsList.results.length.toString());

                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: genresList.results.length,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                            child: Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.heightMultiplier + 2),
                                //    height: SizeConfig.heightMultiplier * 12,

                                child: GestureDetector(
                                    onTap: () {

                                      YoutubeArguments genresDetailsArguments=new YoutubeArguments(gameName: genresList.results[index].name,
                                      gameId: genresList.results[index].id,flag: 1);
                                      Navigator.pushNamed(context, GenresDetails.routeName,arguments: genresDetailsArguments);
//                                      Navigator.push(
//                                          context,
//                                          NavSlideFromRight(
//                                              page: GenresDetailsState(
//                                                id: genresList.results[index]
//                                                    .id,
//                                                genresName: genresList
//                                                    .results[index].name,
//
//                                              )));

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
                                        width: SizeConfig.widthMultiplier * 37,

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
                                                  Icons.category,
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
                                                genresList.results[index].name,
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
