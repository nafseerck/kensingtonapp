import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/LoginPage.dart';
import 'dashboard/Dashboard_page.dart';
import 'onbording/Onboardingpage.dart';






class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool iscomplete=false;
  PreferencesApp bloc;
  void handleTimeout() {
    main();
  }
  startTimeout() async {

    var duration = const Duration(seconds: 2);
    return new Timer(duration, handleTimeout);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
    bloc.langSelected(false);
    startTimeout();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage("assets/splash/splashscreen.jpg"),
                  fit: BoxFit.cover,)
            ),

          )
        ],
      ),
    );
  }
  Future<void> main() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    iscomplete=prefs.getBool("first_time");

if(iscomplete==null){
  iscomplete=false;
}
    if(!iscomplete){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
    }

    else{
      if(userid!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreens()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }

    }
  }
}
