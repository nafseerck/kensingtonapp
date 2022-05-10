import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/auth/Forget.dart';
import 'package:kensington/pages/auth/verifyLogin.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/pages/privacypolicy/PrivacyPolicy.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translations.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SignUp.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageeState createState() => _LoginPageeState();
}

class _LoginPageeState extends State<LoginPage> {
  PreferencesApp bloc;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _value1 = false;
  bool _value2 = false;
  double opacity = 1.0;

  static final validCharacters = RegExp(r'^[a-zA-Z]+$');
  static Pattern pattern =
      //r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(pattern);
  bool varifyboolean=false;
@override
  void initState() {

    super.initState();
    showDemoActionSheet();
  }
  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }
  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }

LoginResponse user;
  final FirebaseMessaging _fcm=FirebaseMessaging();

Future<void> _getUser() async {
  String fcmToken = await _fcm.getToken();
  Provider.of<LoginProvider>(context, listen: false)
      .fetchUser(email.text.toString(),password.text.toString(),fcmToken)
      .then((value) {
    if (value) {
      DialogUtils.hideProgress(context);

      user = Provider.of<LoginProvider>(context, listen: false).getUSer();
print(user.msg);
      if (user.msg == "You have successfully login.") {
        bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
        bloc.savePrefernses(user.userId,email.text);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomeScreens()), (Route<dynamic> route) => false);
      }
      else if(user.msg=="Email Id and Password doesn't Exist."){
        CustomWidget.showtoast(
            context, translate('login.wrong_email'));
      }
      else if(user.msg=="Your Email Not Varified. Please Varify Your Email."){
        varifyboolean=true;

        CustomWidget.showtoast(
            context, translate('login.email_verif'));
      }

    }

  });

}
@override
Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage("assets/images/house_1.png"),
              fit: BoxFit.cover,)
        ),

      ),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [

                  Container(
                    height: height * 0.73,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.80,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 20),

                                        child:
                                        CustomWidget.getheading(translate('login.welcome_message'))

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),

                                      child: Text(translate('login.sign_in'),
                                          style: TextStyle(
                                              color:     ColorConstant.kGreyColor,
                                              fontSize: 16, fontFamily: 'PTSerif')),
                                    ),
                                    Container(

                                      margin: EdgeInsets.only(top:20,bottom: 10),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Container(
                                            height: 48,
                                            margin: EdgeInsets.only(left: 25, right: 25),
                                            padding: EdgeInsets.only(left: 15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Color(0xfffff0eff5)

                                            )
                                            ,
                                            child: TextField(

                                                controller: email,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:translate('login.email'),
                                                  hintStyle: TextStyle(
                                                      color: ColorConstant.edittextcolor,
                                                      fontFamily: "PTSerif"

                                                  ),
                                                )
                                            ),
                                          ),
                                          Container(
                                            height: 48,
                                            margin: EdgeInsets.only(left: 25, right: 25,top:8),
                                            padding: EdgeInsets.only(left: 15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Color(0xfffff0eff5)

                                            )
                                            ,
                                            child: TextField(
                                                obscureText: true,
                                                controller: password,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:translate('login.password'),
                                                  hintStyle: TextStyle(
                                                      color: ColorConstant.edittextcolor,
                                                      fontFamily: "PTSerif"

                                                  ),
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if (validationDetails()){
                                          Provider.of<LoginProvider>(context, listen: false)
                                              .setLoading(true);
                                          if( Provider.of<LoginProvider>(context, listen: false)
                                              .isLoading()){
                                            DialogUtils.showProgress(context);
                                            _getUser();
                                          }

                                        }

                                      },
                                      child: _submitButton(),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => Forget()));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top:10),

                                        child: Text(translate('login.forget_password'),
                                            style: TextStyle(
                                                color: Color(0xffff1d6150),
                                                fontSize: 16, fontFamily: 'PTSerif')),
                                      ),),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => verifyLogin()));
                                      },
                                      child:
                                          Visibility(visible:varifyboolean,
                                          child:
                                          Container(
                                            padding:  EdgeInsets.only(top:10),

                                            child: Text("Verify your email",
                                                style: TextStyle(
                                                    color: Color(0xffff1d6150),
                                                    fontSize: 16, fontFamily: 'PTSerif')),
                                          )
                                       )
                                   ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top:4),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//
//                                         children: <Widget>[
//                                           Row(
// mainAxisAlignment: MainAxisAlignment.center,
//                                             children: <Widget>[
//                                               SizedBox(
//                                                 height: 24.0,
//                                                 width: 24.0,
//                                                 child: Checkbox(
//                                                     checkColor: ColorConstant.kWhiteColor,
//                                                     activeColor: ColorConstant.kGreenColor,
//
//                                                     value: _value1,
//                                                     onChanged: _value1Changed),
//                                               ),
//                                               SizedBox(width: 5,),
//                                                Text('I agree to the',style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 16),),
//                                               SizedBox(width: 2,),
//                                               InkWell(child:  Text(
//                                                 'privacy policy',
//                                                 style:
//                                                 GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,
//                                                   decoration: TextDecoration.underline,fontSize: 16),
//
//
//                                               ),
//                                                 onTap: (){
//                                                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PrivacyPolicy(langcode: "en",)));
//                                                 },)
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left:25.0),
//                                       child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: <Widget>[
//                                           Row(
//
//                                             children: <Widget>[
//                                               new Checkbox(
//                                                   checkColor: Colors.white,
//                                                   activeColor: Color(0xFF27AE60),
//                                                   value: _value2,
//                                                   onChanged: _value1Changed1),
//
//                                               InkWell(child:  Text(
//                                                 'Subscribe Newsletter',
//                                                 style: TextStyle(
//                                                   color: Color(0xFF10AEC6),
//                                                   decoration: TextDecoration.underline,
//                                                 ),
//
//                                               ),
//                                                 onTap: (){
//                                                   //_launchURL();
//                                                 },)
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),

                                  ],
                                ),
                              ),
                            ),

                            Positioned(
                              top: height * 0.70/6,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/appicon/icon.png',
                                    width: innerWidth * 0.14,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                 Align(
                   alignment: Alignment.bottomCenter,
                   child:  _createAccountLabel(),)
                ],
              ),
            ),
        ),

      )
    ],
  );
}


Widget _createAccountLabel() {
  return  Container(
    margin: EdgeInsets.symmetric(vertical: 50),
    padding: EdgeInsets.all(15),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          translate('login.dont_have'),
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'PTSerif',
              fontSize: 16),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignupPage()));
          },
          child:  Text(
            translate('login.sign_up'),
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'PTSerif Heavy',
              fontWeight: FontWeight.w700,),
          ),)
      ],
    ),
  );
}
Widget _submitButton() {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 12),
    margin: EdgeInsets.only(left: 20,right: 20,top:9,bottom: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Color(0xffff1d6150)
       ),
    child: Text(
      translate('login.sign_in_text'),
        style: GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
    ),
  );
}
  _launchURL(String url1) async {
    String url = url1;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value1Changed1(bool value) => setState(() => _value2 = value);
  bool validationDetails() {


    if (email.text.isEmpty) {
      CustomWidget.showtoast(
          context,   translate('login.fill_email'));
      return false;
    }
    else if (!regex.hasMatch(email.text)) {
      CustomWidget.showtoast(
          context,   'Enter valid email address. Check the extra space or invalid character in email id.');

      return false;
    }
    else if (password.text.isEmpty) {
      CustomWidget.showtoast(
          context,   translate('login.fill_password'));
      return false;
    }
    else if (password.text.length<6) {
      CustomWidget.showtoast(
          context,   'password should be 6 digit');
      return false;
    }

    // else if (!_value1) {
    //   CustomWidget.showtoast(
    //       context,   "Please accept the Privacy Policy");
    //   return false;
    // }
    // else if (!_value2) {
    //   CustomWidget.showtoast(
    //       context,   "Please subscribe Newsletter to get new updates.");
    //   return false;
    // }
    return true;
  }
}
