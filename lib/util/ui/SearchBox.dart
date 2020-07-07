

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/SearchPOJO.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

String text;

 // ignore: must_be_immutable
 class SearchBoxExample extends StatefulWidget {

   SearchBoxExample({Key key,

     this.text}) : super(key: key);
  @override
  SearchBoxExampleState createState() => SearchBoxExampleState();
   String text;

 }

 class SearchBoxExampleState extends State<SearchBoxExample> {
  var keyss = new GlobalKey<SearchBoxExampleState>();


   TextEditingController editingController=new TextEditingController();
  List<String>searchList=new List();
void editval()
{
  setState(() {

  });
}


  bool signedIn() {
    setState((

        ) {});
    return true;
  }
bool flag=false;


  Widget searchText()
  {
    return
      Container(
        height: SizeConfig.heightMultiplier * 8,

//                              decoration: BoxDecoration(color: Colors.white30,
//                                  borderRadius: BorderRadius.all(Radius.circular(10))),

        width: SizeConfig.widthMultiplier*100,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
        child: Row(children: <Widget>[

          Container(
              width: SizeConfig.widthMultiplier*60,
              height: SizeConfig.heightMultiplier * 8,

              //   padding: EdgeInsets.all(5),
              child: new Theme(
                  data: new ThemeData(
                    primaryColor: Colors.redAccent,
                    primaryColorDark: Colors.red,
                  ),
                  child: new TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(40.0),
                        ),

                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Search Publisher",
                        fillColor: Colors.white30),
                    //controller: editingController,

//
                    onSubmitted: (c){
                      setState(() {
                        // currentText=c;

                        searchList=new List();
                        editingController.text.length==0? editingController.text="   ":Container();
                        ;

                        //  print("onSubmitted" + currentText);
                            ;
                        //   print("INSIDE"+editingController.text);

                      });




                    },

                    onChanged: (c)
                    {
                      setState(() {

                      // editingController.text.trim().isEmpty? publisherListDetails=new List():Container(child: Text(""),);

                      // editingController.text.trim().isEmpty? editingController.text="   ":Container(child: Text(""),);

                      //  editingController.text.trim().isEmpty ?Container(child:Text("")):currentText;
                        editingController.text.isNotEmpty? editingController.text:Container();

                        if(editingController.text.trim().isEmpty)
                      {
                       // setState(() {
                          searchList=new List();

                       // });

                         print("empty" + searchList.length.toString());
                        Container(child: Text(""),);

                      }

                    });


                    },



                  ))),

          GestureDetector(
              key: keyss,

              onTap: ()
              {
              //  editingController.text=text;

           //     print("onTap clciked"+  editingController.text);

               //add();
                print("onTap clciked"+ flag.toString());

                updateErrorText(editingController.text);




//                if(mounted) {
//                  setState(() {
////                                        publisherListDetails.clear();
//                    //     editingController.text.length==0?currentText="@#%":Container();
//                    // currentText= "@#%";
////                                        editingController.text.isEmpty?  editingController.clear():Container();
////                                        editingController.text.isEmpty?  publisherListDetails=new List():Container();
//
//                    print("object editingController.text" +
//                        editingController.text);
//                  });
//                }
              },

              child:
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 6 * SizeConfig
                      .imageSizeMultiplier,


                ),
              ))






        ],),);
  }




List<String>searchLists=new List();
  Widget SeachBox() {
    return Column(children: <Widget>[

      Align(

          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            //textDirection: TextDirection.ltr,
              scrollDirection: Axis.vertical,

              child: new Container(
                  height: SizeConfig
                      .heightMultiplier * 40,

                  child: Scrollbar(


                      child: ListView.builder(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        // physics: const NeverScrollableScrollPhysics(),


                        scrollDirection: Axis
                            .vertical,
                        shrinkWrap: true,

                        itemCount: searchLists ==
                            null
                            ? 0
                            : searchLists
                            .length,
                        itemBuilder: (context,
                            index) {
                          return new GestureDetector(

                              onTap: () {
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

                              AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: searchLists.length,
                                  child: ScaleAnimation(
                                      child: FadeInAnimation(
                                          child: Container(
                                              height: SizeConfig
                                                  .heightMultiplier * 9,
                                              width: SizeConfig
                                                  .widthMultiplier * 30,
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
                                                      borderRadius: BorderRadius
                                                          .circular(3)),
                                                  semanticContainer: true,


                                                  color: Color.fromRGBO(
                                                      32, 32, 32, 5),
                                                  elevation: 8.0,

                                                  child: Container(

                                                    child: Row(
                                                      //  mainAxisSize: MainAxisSize.max,
                                                      children: <Widget>[
//
//      ),
//      )),

                                                        Expanded(child:

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
                                                              .all(5),
                                                          // alignment: Alignment.topLeft,
                                                          child: searchLists
                                                              .length == 0 ?
                                                          Text(
                                                            "No search result found :(",
                                                            style: AppTheme
                                                                .subTitleLights,
                                                            textScaleFactor: 1.0,
                                                            softWrap: true,
                                                          )
                                                              : Text(
                                                            '${searchLists[index]}',
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

    ],);
  }



 // ValueNotifier<String> textHasErrorNotifier ;
 String test;
  Widget getPrefixText(text)
  {



    return Text(text);
  }

  String myval()
  {
    if(mounted) {
      print("POOOO");
      setState(() {
        test = editingController.text.toString();
      });
    }
    return editingController.text;
  }

  updateErrorText(String text) {
    var result = (text == null || text == "");
    editingController.text = text;
  }
    @override
  Widget build(BuildContext context) {
      //editingController=new TextEditingController();

      ValueNotifier<String>    textHasErrorNotifier=  ValueNotifier(editingController.text);




      return Column(

      children: <Widget>[

        searchText(),

        ValueListenableBuilder(
          valueListenable: textHasErrorNotifier,
         // child: getPrefixText(textHasErrorNotifier.value),
          builder: (BuildContext context, String hasError, Widget child) {
            return Column(children: <Widget>[
              searchText(),

               // getPrefixText(textHasErrorNotifier.value),


//              TextField(
//              controller: editingController,
//              onChanged: (c)
//              {
//
//                updateErrorText(c);
//
//               // myval();
//
//                editingController.text.isNotEmpty? editingController.text:Container();
//                var result = c;
//                textHasErrorNotifier.value = c;
//                test=textHasErrorNotifier.value;
//                text=c;
//                flag=true;
//
//                print("textHasErrorNotifier" +     textHasErrorNotifier.value);
//                print("textHasErrorNotifier c" +     c);
//                print( flag);
//
//                if(editingController.text.trim().isEmpty)
//                {
//
//
//                  print("empty" + searchList.length.toString());
//                  Container(child: Text(""),);
//
//                }
//              },
//              decoration: InputDecoration(
//                // prefix: child,
//                fillColor: Colors.grey[100],
//                filled: true,
//                // errorText: hasError ? 'Invalid value entered...' : null,
//                enabledBorder: OutlineInputBorder(
//                  borderSide: BorderSide(
//                    color: Colors.grey,
//                  ),
//                  borderRadius: BorderRadius.circular(6.0),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderSide:
//                  BorderSide(color: Colors.blueAccent, width: 0.0),
//                  borderRadius: BorderRadius.circular(6.0),
//                ),
//                errorBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: Colors.red, width: 0.0),
//                  borderRadius: BorderRadius.circular(6.0),
//                ),
//                focusedErrorBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: Colors.red, width: 0.0),
//                  borderRadius: BorderRadius.circular(6.0),
//                ),
//              ),
//            ),





            ],);



          },
        ),
             //SeachBox()
      //],


      ]);



  }
}




