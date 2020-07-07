

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gamersgram/publishers/ui/PublisherHomePage.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';

TextEditingController editingController=new TextEditingController();
List<String>searchList=new List();
ValueNotifier<String>    textHasErrorNotifier=  ValueNotifier(editingController.text);

class AppState with ChangeNotifier {
  AppState();


  updateErrorText(String text) {
    var result = (text == null || text == "");
    editingController.text = text;
  }


  List<String>searchLists=new List();

  Widget SeachBox() {
    return Container(
      height: SizeConfig.heightMultiplier * 9,
      width:SizeConfig.widthMultiplier*97,

      alignment: Alignment.center,
      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier),


      //  width: SizeConfig.widthMultiplier*100,
//                              padding: EdgeInsets.only(
//                                  left: 17, right: 17, top: 13),
      child: Row(children: <Widget>[
        Card(
            elevation: 6,
            color: Colors.white30,

            child:
            Container(
                width: SizeConfig.widthMultiplier*75,
                height: SizeConfig.heightMultiplier * 8,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white30,
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Search Games",
                          fillColor: Colors.white30),controller: editingController,


                    )))),
        SizedBox(width: SizeConfig.widthMultiplier,),
        Card(
            elevation: 6,
            color: Colors.white30,

            child:
            Container(
                width: SizeConfig.widthMultiplier*15,
                height: SizeConfig.heightMultiplier*8,
                color: Colors.white30,
                // padding: EdgeInsets.only(left: 5),

                child:FlatButton(
                  hoverColor: Colors.red,
                  highlightColor: Colors.black38,

                  child:      Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 6 * SizeConfig
                          .imageSizeMultiplier,


                    ),
                  ) ,



                  onPressed: (){

                    //    setState(() {

                //    setDisplayText(c);

                    editingController.text.isNotEmpty? setDisplayText(editingController.text):Container();
//                                        editingController.text.isEmpty?  publisherListDetails=new List():Container();

                    // });


                  },)
            )),





      ],),);
  }



  String myNewText = "abc";
  String _displayText = "";
  String _jsonResonse = "";
  bool _isFetching = false;

  void setDisplayText(String text) {
    _displayText = text;
    print("_displayText_displayText  c" + _displayText);

    notifyListeners();
  }

  String get getDisplayText => _displayText;
  Widget searchs() {
    searchLists=new List();

    return  SeachBox();
  }
}