import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/pages/notification/NotificationPage.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class CustomWidget {



  static Widget getText(String text,{FontWeight fontWeight = FontWeight.bold,Color textColor = Colors.black,
    double fontSize=16.0}) {
    return
      Text(
        text != null ? text : "",
        style: new TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,

        ),

        //  textAlign: textAlign,
      );
  }
  static Widget geterrortext(String text,{Color textColor = Colors.red,
    double fontSize=14.0}) {
    return
    Container(
      // padding: const EdgeInsets.only(top:3.0,left: 4,right: 4),
      // margin:const EdgeInsets.only(top:4.0) ,
      // decoration: new BoxDecoration(
      //   color: Color(0xffef5350),
      //   border: new Border.all(
      //       color: Color(0xffef5350),
      //
      //       style: BorderStyle.solid),
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(20.0),
      //     topLeft: Radius.circular(0.0),
      //     bottomRight: Radius.circular(0.0),
      //     bottomLeft: Radius.circular(20.0),
      //   ),
      // ),
      child:   Text(
      text != null ? text : "",
      style: GoogleFonts.ptSerif(
        fontSize: fontSize,

        color: textColor,
      )

      //  textAlign: textAlign,
    ),)
    ;
  }
  static Widget getFlatBtn(BuildContext context, String text, {
    onPressed,Color textColor}) {
    return new FlatButton(
      textColor: textColor,
      onPressed: onPressed,
      padding: EdgeInsets.all(0.0),
      child: new Text(text, style: new TextStyle(fontSize: 16.0),),);
  }
  static Widget getTextsmall(String text,{FontWeight fontWeight = FontWeight.bold,Color textColor = ColorConstant.kGreyColor,
    double fontSize=14.0}) {
    return new Text(
      text != null ? text : "",

      style:
    GoogleFonts.ptSerif(
      fontSize: fontSize,


      color: textColor,
    )

      //  textAlign: textAlign,
    );
  }
  static Widget textquick(String text,{FontWeight fontWeight = FontWeight.bold,Color textColor = ColorConstant.kGreyColor,
    double fontSize=18.0}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,


          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static Widget getTextmedium(String text,{FontWeight fontWeight = FontWeight.bold,Color textColor = ColorConstant.kGreenColor,
    double fontSize=15.0}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,


          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static Widget getTextsearch(String text,{FontWeight fontWeight = FontWeight.bold,Color textColor = ColorConstant.kGreenColor,
    double fontSize=16.0}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,


          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static Widget getheading(String text,{Color textColor =  ColorConstant.kGreenColor,
    double fontSize=40.0,fontFamily = 'PTSerif'}) {
    return new Text(
      text != null ? text : "",

      style:
      GoogleFonts.ptSerif(
        fontSize: fontSize,


        color: textColor,
      )

      //  textAlign: textAlign,
    );
  }


  static Widget getheading1(String text,{Color textColor =  ColorConstant.kGreenColor,
    double fontSize=30.0,fontFamily = 'PTSerif'}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,


          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static Widget getheadingadva(String text,{Color textColor =  ColorConstant.kGreenColor,
    double fontSize=20.0,fontFamily = 'PTSerif'}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,


          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static Widget getprefernceheading(String text,{Color textColor =  ColorConstant.kGreenColor,
    double fontSize=18.0,fontFamily = 'PTSerif',FontWeight fontWeight=FontWeight.bold}) {
    return new Text(
        text != null ? text : "",

        style:
        GoogleFonts.ptSerif(
          fontSize: fontSize,
fontWeight: fontWeight,

          color: textColor,
        )

      //  textAlign: textAlign,
    );
  }
  static void showtoast(BuildContext context,String msg){
    Toast.show(msg, context, duration:4 , gravity:  Toast.BOTTOM);

  }
  static Widget getappbar1 ( BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:  Image.asset(
        'assets/appicon/icon.png',

        height: 34,
      ),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: ColorConstant.kGreenColor,


    );
  }

  static Widget getappbar ( BuildContext context,counter) {
    return AppBar(
      centerTitle: true,
      title:  Image.asset(
        'assets/appicon/icon.png',

        height: 34,
      ),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: ColorConstant.kGreenColor,
      actions: [
        // Icon(
        //
        //   Icons.notifications,
        //   size: 25.0,
        //   color: Colors.white,
        // ),
        new Stack(
          children: <Widget>[
            new IconButton(icon: Icon(Icons.notifications), onPressed: () {
              notif_arrived(context);
            }),
            counter != 0 ? new Positioned(
              right: 11,
              top: 11,
              child: new Container(
                padding: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  color: ColorConstant.countercolor,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '$counter',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ) : new Container()
          ],
        ),
        // Image.asset(
        //   'assets/profile/user.png',
        //      height: 25,
        //   color: Colors.white,
        //   width: 25,
        //
        // ),
        SizedBox(width: 20,),


      ],
    );
  }
  static PreferencesApp bloc;
  static Future<void> notif_arrived(BuildContext context) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notifi = prefs.getBool('notification_arr');
    if(notifi==null){
      notifi=false;
    }
    if(notifi){
      //counter=0;
    }
    else{
     // getcount();
      bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
      bloc.savenotifiArrived(true);

    }
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationPage()));


  }











}