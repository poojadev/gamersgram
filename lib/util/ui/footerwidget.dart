


import 'package:flutter/material.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
//
// abstract class Footer extends StatefulWidget {
//  @override
//  _FooterState createState() => _FooterState();
//}
///*
//         pagination footer; this will show page numbers
//         logic : get total count of the result ,then
//    */
  Widget footerWidget() {
  print("INSIDE Footer");
  //   print("wee" +pages.length.toString());

//      return FractionallySizedBox(
//          widthFactor: 1,
  //child:Container(
  //   padding: EdgeInsets.only(left: 20,right: 20),
//              decoration: new BoxDecoration(
//                  color: Color.fromRGBO(32, 32, 34, 40),
//                  borderRadius: new BorderRadius.only(
//                      topLeft: const Radius.circular(40.0),
//                      topRight: const Radius.circular(40.0))),
  //  child:

  return Card(
    elevation: 11,
    //color: Color.fromRGBO(32, 32, 34, 40),
    color: Colors.blue,
    shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28))),
    // height: 60.0,
    child: Row(children: <Widget>[
      Expanded(
        child: Container(
          // padding: EdgeInsets.only(left: 18,right: 18),
          color: Color.fromRGBO(32, 32, 34, 40),
          child: IconButton(icon: new Icon(Icons.home),
              iconSize:  6 * SizeConfig.imageSizeMultiplier,
              color: Colors.white, onPressed: (){}),
        ),
      ),

      Expanded(
        flex: 1,

        child: Container(
          padding: EdgeInsets.only(left: 18,right: 18),
          color: Color.fromRGBO(32, 32, 34, 40),
          child: IconButton(icon: new Icon(Icons.home),
              iconSize:  6 * SizeConfig.imageSizeMultiplier,
              color: Colors.white, onPressed: (){}),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 18,right: 18),

          decoration: BoxDecoration(
            color: Color.fromRGBO(32, 32, 34, 40),
            // border: Border.all(color: Colors.black),
          ),
          child: IconButton(icon: new Icon(Icons.home),
              iconSize: 6 * SizeConfig.imageSizeMultiplier,
              color: Colors.white, onPressed: (){}),
        ),
      ),

    ],),


    //  )
    // )

  );
}
//class _FooterState extends State<Footer> {
//  @override
//  Widget build(BuildContext context) {
//    return footerWidget();
//  }
//}
