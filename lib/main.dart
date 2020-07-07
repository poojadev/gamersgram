import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamersgram/creators/details/CreatorDetails.dart';
import 'package:gamersgram/creators/ui/CreatorHomePage.dart';
import 'package:gamersgram/game/GameData/GameDetails.dart';
import 'package:gamersgram/game/GameData/YoutubeArguments.dart';
import 'package:gamersgram/game/allgames/AllGameList.dart';
import 'package:gamersgram/game/gamedashboard/releasecalender/gamereleasecalender.dart';
import 'package:gamersgram/game/gamedashboard/monthlytrending/monthlytrendinggames.dart';
import 'package:gamersgram/game/gamedashboard/newgamesdashboard.dart';
import 'package:gamersgram/game/gamedashboard/nextweekrelease/nextweekrelease.dart';
import 'package:gamersgram/game/gamedashboard/popularoftheyear/populargameslastyear.dart';
import 'package:gamersgram/game/gamedashboard/searchyourfavgame/searchyourfavgames.dart';
import 'package:gamersgram/genres/details/GenresDetails.dart';
import 'package:gamersgram/genres/ui/GenresHomePage.dart';
import 'package:gamersgram/navigtion/About.dart';
import 'package:gamersgram/navigtion/suggestions.dart';
import 'package:gamersgram/platforms/platformdescription/ui/PlatformDetailsWithGaames.dart';
import 'package:gamersgram/platforms/ui/PlatformHomePage.dart';
import 'package:gamersgram/publishers/detail/PublisherDetails.dart';
import 'package:gamersgram/publishers/model/GamePublisherPOJO.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/stores/details/StoreDetails.dart';
import 'package:gamersgram/stores/ui/StoresHomePage.dart';
import 'package:gamersgram/tags/details/TagWiseGameList.dart';
import 'package:gamersgram/tags/ui/AllTagsHomePage.dart';

import 'package:gamersgram/util/splashscreen.dart';
import 'package:gamersgram/util/ui/ConnectionStatusSingleton.dart';
import 'package:gamersgram/util/ui/MyHttpOverrides.dart';
import 'package:page_transition/page_transition.dart';

import 'dashboard/homepage.dart';
import 'game/gamelist/GameListPOJO.dart';

// void main() {
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
//     runApp(new TagsHomePage());
//   });
// }
//List<GamePublisherResult>passArgus;
//List<Screenshots> screenShots;
//String released;
//double rating;
//List<Stores> stores;
//String clip;
//List<Genres> genres;
//List<Platforms> platforms;
//int flag;
//int gameId;
//String description;
//String clips;
//String website;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton
      .getInstance();
  connectionStatus.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      _) {
    HttpOverrides.global = MyHttpOverrides();
    const String homeRoute = '/';

    runApp(


        new MaterialApp(
          initialRoute: '/splashscreen' ,


          onGenerateRoute: (RouteSettings settings) {

            YoutubeArguments creatorDetailsArguments = settings.arguments;
            YoutubeArguments publisherDetailArguments = settings.arguments;
            YoutubeArguments platformDetailArguments = settings.arguments;
            YoutubeArguments genresDetailArguments = settings.arguments;
            YoutubeArguments storeDetailArguments = settings.arguments;
            YoutubeArguments tagDetailArguments = settings.arguments;



//            if (settings.name =="/GameYoutubePlayerStates") {
//              // Cast the arguments to the correct type: ScreenArguments.
//             YoutubeArguments args = settings.arguments;
//
////              print("MAIN" +args.gameName);
//
//              // Then, extract the required data from the arguments and
//              // pass the data to the correct screen.
//              return MaterialPageRoute(
//                builder: (context) {
//                  return GameYoutubePlayerStates(
//                    user: args,
//                  );
//                },
//              );
//            }

            Object arguments1;

            switch (settings.name) {
              case '/splashscreen':
                return

                  PageTransition(
                    child:SplashScreenState(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

              case '/':
                return

                  PageTransition(
                    child:Homepage(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

                break;
              case '/publisherhomepage':
                return

                  PageTransition(
                    child:PublisherHomePage(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

                break;
              case PublisherDetails.routeName:
                return

                  PageTransition(
                    child:PublisherDetailsState(publisherDetailsArguments: publisherDetailArguments,),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

                break;

              case '/platformhomepage':
                return    PageTransition(
                  child:PlatformHomePage(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/PlatformDetailsWithGames':
                return
                  PageTransition(
                    child:PlatformDetailsStates(platformDetailsArguments:platformDetailArguments ,),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

                break;

              case '/genreshomepage':


              return  PageTransition(
                  child: GenresHomePage(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
//                return MaterialPageRoute(
//
//
//                    builder: (context)=> GenresHomePage());
                break;
              case GenresDetails.routeName:
                return

                 // MaterialPageRoute(
                      PageTransition(
                        child: GenresDetailsState(genresDetailsArguments: genresDetailArguments,),
                        type: PageTransitionType.rotate,
                        settings: settings,
                      );

                  //  builder: (context)=>GenresDetailsState(genresDetailsArguments: genresDetailArguments,));
                break;


              case '/storeshomepage':

                return
                  PageTransition(
                    child:StoresHomePage(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );
                break;
              case StoreDetails.routeName:


            return
              PageTransition(
                child:StoreDetailsState(storeDetailsArguments: storeDetailArguments,),
                type: PageTransitionType.rotate,
                settings: settings,
              );


                break;
              case '/alltagshomepage':
                return
                  PageTransition(
                    child:AllTagsHomePage(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

              case '/creatorhomepage':
                return
                  PageTransition(
                    child:CreatorHomePage(),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );
                break;

              case '/CreatorDetailsState':
                return
                  PageTransition(
                    child:CreatorDetailsState(creatorDetailsArguments: creatorDetailsArguments,),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );


                break;

              case '/gamenewsdashboard':
                return      PageTransition(
                  child:GameNewsDashboard(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/allgamelist':

                return     PageTransition(
                  child:AllGamesList(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/PopularGamesLastYear':
                return     PageTransition(
                  child:PopularGamesLastYear(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/MonthlyTrendingGames':
                return      PageTransition(
                  child:MonthlyTrendingGames(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/NextWeekRelease':
                return      PageTransition(
                  child:NextWeekRelease(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
break;
              case '/GameReleaseCalendar':
                return      PageTransition(
                  child:GameReleaseCalendar(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );


 break;
              case '/SearchGameHomePage':
                return      PageTransition(
                  child:SearchGameHomePage(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;



              case '/Suggestions':
                return      PageTransition(
                  child:Suggestions(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );
                break;

              case '/GameDetailsStates':
                YoutubeArguments args = settings.arguments;

                return
                  PageTransition(
                    child:GameDetailsStates(user: args,),
                    type: PageTransitionType.rotate,
                    settings: settings,
                  );

                break;

              case '/About':
                return    PageTransition(
                  child:About(),
                  type: PageTransitionType.rotate,
                  settings: settings,
                );

                  break;

                  case '/TagWiseGameListState':
                    return

                      PageTransition(
                        child:TagWiseGameListState(tagWiseGameArguments:tagDetailArguments ,),
                        type: PageTransitionType.rotate,
                        settings: settings,
                      );

                    break;
              default:
                return MaterialPageRoute(
                    builder: (_) =>
                        Scaffold(
                          body: Center(
                              child: Text('No route defined for ${settings.name}')),
                        ));

            }
          },
          // initialRoute: '/',
//      routes: {
//        // When navigating to the "/" route, build the FirstScreen widget.
//        '/': (context) => Homepage(),
//        // When navigating to the "/second" route, build the SecondScreen widget.
//        '/publisherhomepage': (context) => PublisherHomePage(),
//
//     //  '/PublisherDetailsState': (context) => PublisherDetails(),
//        '/platformhomepage': (context) => PlatformHomePage(),
//
//
//      },
        ));
  });
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
