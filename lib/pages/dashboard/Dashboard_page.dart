import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/pages/auth/LoginPage.dart';
import 'package:kensington/pages/dashboard/dashbordpages/HomePage.dart';
import 'package:kensington/pages/dashboard/fav/FavroiteScreen.dart';

import 'package:kensington/pages/imprintpage/ImprintPage.dart';
import 'package:kensington/pages/notification/NotificationPage.dart';
import 'package:kensington/pages/privacypolicy/PrivacyPolicy.dart';
import 'package:kensington/pages/profile/ProfilePage.dart';
import 'package:kensington/pages/savesearchpages/savesesearch/SaveSearch.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/sellproperty/SellProperty.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreentate createState() => new _HomeScreentate();
}

class _HomeScreentate extends State<HomeScreens> {
  int counter = 0;
  int _page = 0;
  PageController _c;
  int _selectedIndex = 0;
  int selectionScreen = 0;
  var name, mobile;
  int langindex = -1;
  PreferencesApp bloc;
  bool _value1 = true;
  String language;
  int _selectedDrawerIndex = 0;
  final List<String> lang = <String>['DE', 'EN', 'ES'];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey);
  static const List<Widget> _widgetOptions = <Widget>[];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void switchAccounts() {
    this.setState(() {});
  }

  CountModel countModel;
  void getcount() {
    Provider.of<LoginProvider>(context, listen: false)
        .count_notification()
        .then((value) {
      if (value) {
        // DialogUtils.hideProgress(context);

        countModel =
            Provider.of<LoginProvider>(context, listen: false).getcount();
        if (countModel.status == "success") {
          setState(() {
            counter = countModel.propertyCount;
          });
        }
      }
    });
  }

  @override
  void initState() {
    bloc = Provider.of<LoginProvider>(context, listen: false).bloc;
    bloc.langSelected(false);
    _c = new PageController(
      initialPage: _page,
    );
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).handleStartUpLogic();
    showDemoActionSheet();
    main();
    notif_arrived1();
  }

  void _value1Changed(bool value) {
    setState(() {
      _value1 = value;
      if (_value1) {
        CustomWidget.showtoast(context, translate('landing_screen.sub_news'));
      } else {
        CustomWidget.showtoast(context, translate('landing_screen.uns_news'));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void showDemoActionSheet() {
    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {
      setState(() {
        changeLocale(context, value);
      });
    });
  }

  Future<void> main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      language = prefs.getString('language');
      if (language == null) {
        language = "en-GB";
      }
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              translate('drawer_lng.sure'),
              style: GoogleFonts.ptSerif(),
            ),
            content: new Text(
              translate('drawer_lng.exit_app'),
              style: GoogleFonts.ptSerif(),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  translate('drawer_lng.no'),
                  style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor),
                ),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text(translate('drawer_lng.yes'),
                    style:
                        GoogleFonts.ptSerif(color: ColorConstant.kGreenColor)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar:
            // here the desired height
            AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/appicon/icon.png',
            height: 34,
          ),
          actions: [
            new Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      notif_arrived();
                    }),
                counter != 0
                    ? new Positioned(
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
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            ),
            SizedBox(
              width: 20,
            ),
          ],
          backgroundColor: ColorConstant.kGreenColor,
        ),
        drawer: Container(
          width: 345,
          color: ColorConstant.kdrwerbgColor,
          child: Drawer(
            child: new ListView(
              children: <Widget>[
                Container(
                  color: ColorConstant.kdrwerbgColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.0,
                      ),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  language = "de-DE";
                                  bloc = Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .bloc;
                                  bloc.langSelected(true);
                                });
                                bloc = Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .bloc;
                                bloc.savelanguage("de-DE");
                                showDemoActionSheet();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreens()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 40,
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: language == "de-DE"
                                      ? new BoxDecoration(
                                          color: ColorConstant.kGreenColor,
                                        )
                                      : null,
                                  child: new Center(
                                      child: Text(
                                    "DE",
                                    style: GoogleFonts.ptSerif(
                                      color: language == "de-DE"
                                          ? Colors.white
                                          : ColorConstant.kGreenColor,
                                      fontSize: 20,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  language = "en-GB";
                                  bloc = Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .bloc;
                                  bloc.langSelected(true);
                                });
                                bloc = Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .bloc;
                                bloc.savelanguage("en-GB");
                                showDemoActionSheet();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreens()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                decoration: language == "en-GB"
                                    ? new BoxDecoration(
                                        color: ColorConstant.kGreenColor,
                                      )
                                    : null,
                                margin: EdgeInsets.only(left: 2, right: 2),
                                width: 40,
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: new Center(
                                      child: Text(
                                    "EN",
                                    style: GoogleFonts.ptSerif(
                                      color: language == "en-GB"
                                          ? Colors.white
                                          : ColorConstant.kGreenColor,
                                      fontSize: 20,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  language = "es-ES";
                                  bloc = Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .bloc;
                                  bloc.langSelected(true);
                                });
                                bloc = Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .bloc;
                                bloc.savelanguage("es-ES");
                                showDemoActionSheet();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreens()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 2, right: 15),
                                width: 40,
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: language == "es-ES"
                                      ? new BoxDecoration(
                                          color: ColorConstant.kGreenColor,
                                        )
                                      : null,
                                  child: new Center(
                                      child: Text(
                                    "ES",
                                    style: GoogleFonts.ptSerif(
                                      color: language == "es-ES"
                                          ? Colors.white
                                          : ColorConstant.kGreenColor,
                                      fontSize: 20,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SaveSearch(
                                        saveserchfrom: "sidedrawer",
                                      )));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.save_search'),
                              style: GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfilePage()));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.prof'),
                              style: GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FavroiteScreen(
                                        fromwhre: "drawerdashboard",
                                      )));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.fav'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SellProperty(
                                          saveserchfrom: "sidedrawer")));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.sale_pro'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String language1 = prefs.getString('language');

                          switch (language1) {
                            case 'en-GB':
                              _launchURL(
                                  "https://www.kensington-international.com/destinations/");
                              break;
                            case 'es-ES':
                              _launchURL(
                                  "https://www.kensington-international.com/es/destinos/");
                              break;
                            case 'de-DE':
                              _launchURL(
                                  "https://www.kensington-international.com/de/standorte/");
                              break;
                            default:
                              _launchURL(
                                  "https://www.kensington-international.com/imprint/");
                              break;
                          }
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.showrooms'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () {
                          try {
                            launch("market://details?id=" +
                                "com.developer.kensington");
                          } on PlatformException catch (e) {
                            launch(
                                "https://play.google.com/store/apps/details?id=" +
                                    "com.developer.kensington");
                          } finally {
                            launch(
                                "https://play.google.com/store/apps/details?id=" +
                                    "com.developer.kensington");
                          }
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.share'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () async {
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // String language1 = prefs.getString('language');

                          // switch (language1) {
                          //   case 'en-GB':
                          //     _launchURL("https://www.kensington-international.com/imprint/");
                          //     break;
                          //   case 'es-ES':
                          //     _launchURL("https://www.kensington-international.com/spanien/es/");
                          //     break;
                          //   case 'de-DE':
                          //     _launchURL("https://www.kensington-international.com/de/impressum/");
                          //     break;
                          //   default:
                          //     _launchURL("https://www.kensington-international.com/imprint/");
                          //     break;
                          // }

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String language1 = prefs.getString('language');

                          switch (language1) {
                            case 'en-GB':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ImprintPage(
                                            langcode: "en",
                                          )));
                              break;
                            case 'es-ES':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ImprintPage(
                                            langcode: "es",
                                          )));
                              break;
                            case 'de-DE':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ImprintPage(
                                            langcode: "de",
                                          )));
                              break;
                            default:
                              break;
                          }
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                translate('drawer_lng.imprint'),
                                style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String language1 = prefs.getString('language');

                          switch (language1) {
                            case 'en-GB':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PrivacyPolicy(
                                            langcode: "en",
                                          )));
                              break;
                            case 'es-ES':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PrivacyPolicy(
                                            langcode: "es",
                                          )));
                              break;
                            case 'de-DE':
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PrivacyPolicy(
                                            langcode: "de",
                                          )));
                              break;
                            default:
                              break;
                          }
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.privacy_policy'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () {
                          showAlertDialog(context);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: ColorConstant.kGreyColor,
                              size: 35,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              translate('drawer_lng.logout'),
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      new Divider(
                        color: ColorConstant.kGreenColor,
                        thickness: 0.7,
                      ),
                      SizedBox(
                        height: 44.0,
                      ),
                      Container(
                        color: ColorConstant.kdrwerbgColor,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, right: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32.0,
                                      width: 32.0, // fixed width and height
                                      child: Image.asset(
                                          'assets/drawericon/location.png'),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      translate('drawer_lng.address_text'),
                                      style: GoogleFonts.ptSerif(
                                          color: ColorConstant.kGreenColor,
                                          fontSize: 13),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                UrlLauncher.launch('tel:${'+41715444700'}');
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 20, right: 4),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 32.0,
                                        width: 32.0, // fixed width and height
                                        child: Image.asset(
                                            'assets/drawericon/phone.png'),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text("+41715444700",
                                          style: GoogleFonts.ptSerif(
                                              color: ColorConstant.kGreenColor,
                                              fontSize: 13)),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20, right: 4),
                                child: InkWell(
                                  onTap: () {
                                    launchMailto(
                                        'muhammed.ashar@kensington-international.com');
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 32.0,
                                        width: 32.0, // fixed width and height
                                        child: Image.asset(
                                            'assets/drawericon/mail.png'),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                          "muhammed.ashar@kensington-international.com",
                                          style: GoogleFonts.ptSerif(
                                              color: ColorConstant.kGreenColor,
                                              fontSize: 13)),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              children: [
                                //  Container(
                                //
                                //    height: 32.0,
                                //    width: 32.0,
                                //    margin:EdgeInsets.only(left:20),// fixed width and height
                                //    child:
                                // //Icon(  Icons.check_box_sharp,size: 25,color: ColorConstant.kGreenColor,),
                                //
                                //  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                        checkColor: ColorConstant.kWhiteColor,
                                        activeColor: ColorConstant.kGreenColor,
                                        value: _value1,
                                        onChanged: _value1Changed),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  translate('drawer_lng.newsletter'),
                                  style: GoogleFonts.ptSerif(
                                      color: ColorConstant.kGreenColor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 44.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.facebook.com/kensingtoninternational?ref=hl");
                                  },
                                  child: SizedBox(
                                    height: 34.0,
                                    width: 34.0, // fixed width and height
                                    child:
                                        Image.asset('assets/drawericon/fb.png'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://twitter.com/KensingtonFPI");
                                  },
                                  child: SizedBox(
                                    height: 34.0,
                                    width: 34.0, // fixed width and height
                                    child: Image.asset(
                                        'assets/drawericon/twitter.png'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.youtube.com/user/kensingtonchannel");
                                  },
                                  child: SizedBox(
                                    height: 34.0,
                                    width: 34.0, // fixed width and height
                                    child: Image.asset(
                                        'assets/drawericon/youtube.png'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://instagram.com/kensingtonfinestproperties?igshid=kbgsh722y82g");
                                  },
                                  child: SizedBox(
                                    height: 34.0,
                                    width: 34.0, // fixed width and height
                                    child: Image.asset(
                                        'assets/drawericon/instagram.png'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.linkedin.com/company/kensington-finest-properties-international-ag");
                                  },
                                  child: SizedBox(
                                    height: 34.0,
                                    width: 34.0, // fixed width and height
                                    child: Image.asset(
                                        'assets/drawericon/linkedin.png'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 34.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )

//              ),
              ],
            ),
          ),
        ),
        body:
            // IndexedStack(
            //   index: _selectedIndex,
            //   children: <Widget>[
            //      HomePage(),
            //     SaveSearch(saveserchfrom: "savedashboard"),
            //     FavroiteScreen(fromwhre: "bottemdashboard",),
            //
            //     // // PackagesPage(),
            //     // ProfilePage(),
            //     //SearchPage(),
            //
            //   ],
            // ),

            new PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
            });
          },
          children: <Widget>[
            HomePage(),
            SaveSearch(saveserchfrom: "savedashboard"),
            FavroiteScreen(
              fromwhre: "bottemdashboard",
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorConstant.kGreenColor,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: translate('landing_screen.search'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: translate('drawer_lng.save_search')),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: translate('drawer_lng.fav'),
            ),
          ],
          // currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          //
          //
          //
          //
          // onTap: _onItemTapped,
          currentIndex: _page,
          onTap: (index) {
            this._c.animateToPage(index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut);
          },
        ),
      ),
    );
  }

  Future<void> notif_arrived() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notifi = prefs.getBool('notification_arr');
    if (notifi == null) {
      notifi = false;
    }
    if (notifi) {
      counter = 0;
    } else {
      getcount();
      bloc = Provider.of<LoginProvider>(context, listen: false).bloc;
      bloc.savenotifiArrived(true);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NotificationPage()));
  }

  Future<void> notif_arrived1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notifi = prefs.getBool('notification_arr');
    if (notifi == null) {
      notifi = false;
    }
    if (notifi) {
      counter = 0;
    } else {
      getcount();
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(translate('drawer_lng.no'),
          style: TextStyle(
              color: ColorConstant.kGreenColor, fontFamily: 'PTSerif')),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(translate('drawer_lng.yes'),
          style: TextStyle(
              color: ColorConstant.kGreenColor, fontFamily: 'PTSerif')),
      onPressed: () {
        bloc = Provider.of<LoginProvider>(context, listen: false).bloc;
        bloc.removePrefenses();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        translate('drawer_lng.confirm'),
        style:
            TextStyle(color: ColorConstant.kGreenColor, fontFamily: 'PTSerif'),
      ),
      content: Text(translate('drawer_lng.sur_logout'),
          style: TextStyle(
              color: ColorConstant.kGreenColor, fontFamily: 'PTSerif')),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
_launchURL(String url1) async {
  String url = url1;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchMailto(String mail) async {
  final mailtoLink = Mailto(
    to: [mail],
  );
  await launch('$mailtoLink');
}
