import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/pages/auth/LoginPage.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:provider/provider.dart';


class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}




class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  PreferencesApp bloc;
  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/introimg/s1.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/introimg/s2.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/introimg/s3.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/introimg/s4.jpg",
      ),
    );
  }

  void onDonePress() {
    bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
    bloc.savePrefernsestutorialscreen(true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));

  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffff345f4f),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return  Text("Done");
  }

  Widget renderSkipBtn() {
    return Text("Skip",style: GoogleFonts.ptSerif(fontSize: 15),);
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,

                    fit: BoxFit.cover,
                  )),
              // Container(
              //   child: Text(
              //     currentSlide.title,
              //     style: currentSlide.styleTitle,
              //     textAlign: TextAlign.center,
              //   ),
              //   margin: EdgeInsets.only(top: 20.0),
              // ),
              // Container(
              //   child: Text(
              //     currentSlide.description,
              //     style: currentSlide.styleDescription,
              //     textAlign: TextAlign.center,
              //     maxLines: 5,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              //   margin: EdgeInsets.only(top: 20.0),
              // ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
       renderSkipBtn: this.renderSkipBtn(),
       colorSkipBtn: Colors.white,
       highlightColorSkipBtn: Colors.black,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.white,
      highlightColorDoneBtn: Colors.black,

      // Dot indicator
      colorActiveDot: Color(0xffff63ffdc),
      colorDot: Colors.white,
      sizeDot: 13.0,
      //typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides:Color(0xffff345f4f),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      // shouldHideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}

