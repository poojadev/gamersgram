import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gamersgram/util/ui/AppTheme.dart';
import 'package:gamersgram/util/ui/sizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';

class Suggestions extends StatelessWidget {
 static const String routeName="/Suggestions";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,


      body: SuggestionStates(),);
  }
}

class SuggestionStates extends StatefulWidget {
  @override
  _SuggestionStatesState createState() => _SuggestionStatesState();
}

class _SuggestionStatesState extends State<SuggestionStates> {




  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController suggestionController = TextEditingController();

  String name, email,suggestion;

  final _formKey = GlobalKey<FormState>();
  FocusNode namefocusNode = FocusNode();
  FocusNode emailfocusNode = FocusNode();
  FocusNode suggestionfocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
   // Firestore.instance.collection("user").document().setData({'email':_emailController.text.toString(),'password':_passwordController.text.toString()});
    Function(String) usernameValidator = (String username){
      if(username.isEmpty){
        return 'Username empty';
      }else if(username.length < 3){
        return 'Username short';
      }

      return null;
    };


    Widget FormUI() {
      return new Column(
          children: <Widget>[

      TextFormField(
      decoration: new InputDecoration(hintText: 'Email ID'),
      keyboardType: TextInputType.emailAddress,
      maxLength: 32,
      controller: emailController,
     validator: (value) {
      if (value.isEmpty) {
      return 'Please enter email text';
      }
      return null;
      },

      onSaved: (String val) {
      email = val;
      }

      ),

      TextFormField(
      validator: (value) {
      if (value.isEmpty) {
      return 'Please enter Name text';
      }
      return null;
      },
      decoration: new InputDecoration(hintText: 'Password'),
      maxLength: 32,
      //   keyboardType: TextInputType.
      controller: nameController,
      onSaved: (String val) {
      name = val;
      }


      )]);
    }


    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        backgroundColor: Colors.transparent,
        content:

//        new Row(
//          children: [
        Container(
        height: SizeConfig.heightMultiplier * 20,



            child: Center(
                child: FlareActor('assets/loader.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "loader"


                )))
//          ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
     );
    }

    bool _hasInputError = false;

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return
              Scaffold(
                  resizeToAvoidBottomInset:false,
                  backgroundColor: Color.fromRGBO(21, 21, 21, 5),
                  //bottomNavigationBar: footerWidget(),

                  body: CustomScrollView(
                    slivers: <Widget>[
//                    SliverAppBar(
//                      pinned: true,
//                      expandedHeight: 256.0,
////                      flexibleSpace: FlexibleSpaceBar(
////                        title: Text('Title'),
////                      ),
//                    ),
                      SliverList(
                        delegate: SliverChildListDelegate([
//                        Container(child:  Column(children: <Widget>[
//
//                        ],),),

                          Container(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.heightMultiplier + 10),
                              width: SizeConfig.widthMultiplier * 100,
                              height: SizeConfig.heightMultiplier * 12,
                              child: Card(
                                  color: Color.fromRGBO(21, 21, 21, 2),
                                  elevation: 6,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width:
                                          SizeConfig.widthMultiplier * 10,
                                          child: GestureDetector(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.white,
                                                      size: 6 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
//                                                Navigator.pushNamed(
//                                                    context,
//                                                    "/");

                                                Navigator.of(context, rootNavigator: true).pop(context);

                                              })),
                                      Container(
                                          width:
                                          SizeConfig.widthMultiplier * 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Suggestions" ,
                                            style: AppTheme.mainTitles,
                                            textScaleFactor: 1.2,
                                          ))
                                    ],
                                  ))),



            Form(
                key: _formKey,

                child:

           Container(
                             height: SizeConfig.heightMultiplier*70,
                             width: SizeConfig.widthMultiplier*96,
                             padding: EdgeInsets.all(SizeConfig.heightMultiplier+10),

                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
mainAxisSize: MainAxisSize.min,


                              children: <Widget>[

Container(
  height: SizeConfig.heightMultiplier*12,
  width: SizeConfig.widthMultiplier*87,
  child:                                 TextFormField(
  keyboardType: TextInputType.text,
  controller: nameController,
  autovalidate: true,
  //                                    suffixIcon: Icon(Icons.airport_shuttle),

  validator: (String value) {
    if(value.isEmpty) {
      return 'Pleas enter your name';
    }
    else {
      return null;
    }
  },
  decoration: InputDecoration(hintText: "Name",
      errorText: _hasInputError ? 'Pleas enter your name' : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: BorderSide(
          //  color: Colors.blue,
          width:0,
          style: BorderStyle.none,
        ),
      ),
      fillColor: Colors.white12,
      suffixIcon: Icon(Icons.person,color: Colors.white12,textDirection: TextDirection.rtl,),

      filled: true),
),



          ),
                                SizedBox(height: 4,),

                                Container(
                                  height: SizeConfig.heightMultiplier*12,
                                  width: SizeConfig.widthMultiplier*87,
                                  child:                                 TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: emailController,
                                    autovalidate: true,
                                    validator: (String value) {
                                      if(value.isEmpty) {
                                        return ' ';
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    //                                    suffixIcon: Icon(Icons.airport_shuttle),


                                    decoration: InputDecoration(hintText: "Email",

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                            //  color: Colors.blue,
                                            width:0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                     //   errorText: _hasInputError ? 'Pleas enter your suggestions' : null,

                                        fillColor: Colors.white12,
                                        suffixIcon: Icon(Icons.email,color: Colors.white12,textDirection: TextDirection.rtl,),

                                        filled: true),
                                  ),



                                ),

          SizedBox(height: 4,),


                                Container(
                                  height: SizeConfig.heightMultiplier*12,
                                  width: SizeConfig.widthMultiplier*87,
                                  child:                                 TextFormField(

                                    keyboardType: TextInputType.text,
                                    controller: suggestionController,
                                    autovalidate: true,
                                    maxLines: null,

                                    //                                    suffixIcon: Icon(Icons.airport_shuttle),

                                    validator: (String value) {
                                      if(value.isEmpty) {
                                        return 'Pleas enter your suggestions';
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(hintText: "Suggestions",
                                        errorText: _hasInputError ? 'Pleas enter your suggestions' : null,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: BorderSide(
                                            //  color: Colors.blue,
                                            width:0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        fillColor: Colors.white12,
                                        suffixIcon: Icon(Icons.comment,color: Colors.white12,textDirection: TextDirection.rtl,),

                                        filled: true),
                                  ),
//                                  padding: EdgeInsets.all(SizeConfig.heightMultiplier+10),



                                ),




            Container(
              height: SizeConfig.heightMultiplier*13,
              width: SizeConfig.widthMultiplier*90,
              padding: EdgeInsets.all(SizeConfig.heightMultiplier+10),

              // child:Padding(padding:  EdgeInsets.only(left:20.0,right: 20.0,top: 15.0),
                child:
                RaisedButton(
                  elevation: 5.0,
                  textColor: Colors.white,
                  textTheme: ButtonTextTheme.primary,
                  color: Colors.black54,
                  child: Text("Submit Suggestions",textScaleFactor: 1.2,style: AppTheme.mainTitles,),
                  onPressed: () async{


           //   nameController.text.isNotEmpty && suggestionController.text.isNotEmpty?

              showLoaderDialog(context);

          Firestore.instance.collection("gamerzone_suggestions").document().
          setData({
          'userName': nameController.text,
          'email': emailController.text.toString(),
          'suggestions': suggestionController.text.toString()
          }).then((doc) {
            print("OHH MAN :(");
            Navigator.pop(context);

            showDialog(
                context: context,

                builder: (context) {

                  return AlertDialog(
                    backgroundColor: Colors.black54,
                    //   title: Text(title),
                    content: Text("Thank you!! for your valuable suggestions",style: AppTheme.mainTitles,),
                    actions: <Widget>[
                      FlatButton(

                        child: Text('Ok',style: AppTheme.textGridTitle,),
                        onPressed: () {
                           Navigator.of(context).pop();
                          nameController.clear();
                          suggestionController.clear();
                          emailController.clear();
                        },
                      )
                    ],
                  );
                }
            );
          });
                    //:context;




          },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),),)




                          ],),))
//

                          //     Column(children: <Widget>[

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

