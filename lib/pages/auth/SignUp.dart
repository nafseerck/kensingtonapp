import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/auth/VerifyEmail.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/pages/privacypolicy/PrivacyPolicy.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  SignupPage({
    Key key,
  }) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  PreferencesApp bloc;
  bool _value1 = false;
  bool _value2 = false;
  static final validCharacters = RegExp(r'^[a-zA-Z]+$');
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(pattern);
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  @override
  void initState() {
    super.initState();
    showDemoActionSheet();
  }

  void showDemoActionSheet() {
    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {
      changeLocale(context, value);
    });
  }

  LoginResponse user;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> _getUser() async {
    String fcmToken = await _fcm.getToken();
    Provider.of<LoginProvider>(context, listen: false)
        .signupUser("${name.text} ${lastname.text}", email.text, password.text, fcmToken)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();
        print(user.msg);
        if (user.msg == "User added successfully.") {
          CustomWidget.showtoast(
              context, "We have sent one time password on your entered email address.");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VerifyEmail(
                        email: email.text,
                        id: user.userId,
                      )));
          // bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
          // bloc.savePrefernses(user.userId,email.text);
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          //     HomeScreens()), (Route<dynamic> route) => false);
        } else if (user.msg == "User Already Exists.") {
          CustomWidget.showtoast(
              context, translate('signup_screen.already_exist'));
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
              image: DecorationImage(
            image: AssetImage("assets/images/house_1.png"),
            fit: BoxFit.cover,
          )),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    height: height * 0.80,
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
                                height: innerHeight * 0.82,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: CustomWidget.getheading(
                                            translate(
                                                'signup_screen.welcome_user'))),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                          translate(
                                              'signup_screen.join_signup'),
                                          style: TextStyle(
                                              color: ColorConstant.kGreyColor,
                                              fontSize: 16,
                                              fontFamily: 'PTSerif')),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                        Row(

                                          children: [
                                            Container(
                                              height: 48,
width: 160,

                                              margin: EdgeInsets.only(
                                                  left: 25),
                                              padding: EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  color: Color(0xfffff0eff5)),
                                              child: TextField(
                                                  controller: name,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: translate(
                                                        'signup_screen.name'),
                                                    hintStyle: TextStyle(
                                                        color: ColorConstant
                                                            .edittextcolor,
                                                        fontFamily: "PTSerif"),
                                                  )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 48,
width: 165,
                                                margin: EdgeInsets.only(
                                                  right: 25,left: 5),
                                                padding: EdgeInsets.only(left: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                    color: Color(0xfffff0eff5)),
                                                child: TextField(
                                                    controller: lastname,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:'last name',
                                                      hintStyle: TextStyle(
                                                          color: ColorConstant
                                                              .edittextcolor,
                                                          fontFamily: "PTSerif"),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                          Container(
                                            height: 48,

                                            margin: EdgeInsets.only(
                                                left: 25, right: 25, top: 8),
                                            padding: EdgeInsets.only(left: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Color(0xfffff0eff5)),
                                            child: TextField(
                                                controller: email,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      translate('login.email'),
                                                  hintStyle: TextStyle(
                                                      color: ColorConstant
                                                          .edittextcolor,
                                                      fontFamily: "PTSerif"),
                                                )),
                                          ),
                                          Container(
                                            height: 48,
                                            margin: EdgeInsets.only(
                                                left: 25, right: 25, top: 8),
                                            padding: EdgeInsets.only(left: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Color(0xfffff0eff5)),
                                            child: TextField(
                                                controller: password,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: translate(
                                                      'login.password'),
                                                  hintStyle: TextStyle(
                                                      color: ColorConstant
                                                          .edittextcolor,
                                                      fontFamily: "PTSerif"),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {

                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          if (validationDetails()) {
                                            Provider.of<LoginProvider>(context,
                                                    listen: false)
                                                .setLoading(true);
                                            if (Provider.of<LoginProvider>(
                                                    context,
                                                    listen: false)
                                                .isLoading()) {
                                              DialogUtils.showProgress(context);
                                              _getUser();

                                            }
                                          }
                                        },
                                        child: _submitButton()),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 24.0,
                                                width: 24.0,
                                                child: new Checkbox(
                                                    checkColor: ColorConstant
                                                        .kWhiteColor,
                                                    activeColor: ColorConstant
                                                        .kGreenColor,
                                                    value: _value1,
                                                    onChanged: _value1Changed),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'I agree to the',
                                                style: GoogleFonts.ptSerif(
                                                    color: ColorConstant
                                                        .kGreenColor,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  'privacy policy',
                                                  style: GoogleFonts.ptSerif(
                                                      color: ColorConstant
                                                          .kGreenColor,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 16),
                                                ),
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PrivacyPolicy(langcode: "en",)));
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, top: 14),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 24.0,
                                                width: 24.0,
                                                child: Checkbox(
                                                    checkColor: ColorConstant
                                                        .kWhiteColor,
                                                    activeColor: ColorConstant
                                                        .kGreenColor,
                                                    value: _value2,
                                                    onChanged: _value1Changed1),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  'Subscribe to our newsletter',
                                                  style: GoogleFonts.ptSerif(
                                                      color: ColorConstant
                                                          .kGreenColor,
                                                      fontSize: 16),
                                                ),
                                                onTap: () {
                                                  //_launchURL();
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: height * 0.70 / 7,
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
                  _createAccountLabel()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate('signup_screen.already'),
            style: GoogleFonts.ptSerif(fontSize: 16, color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              translate('login.sign_in_text'),
              style: GoogleFonts.ptSerif(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(left: 20, right: 20, top: 9, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffff345f4f)),
      child: Text(
        translate('login.sign_up'),
        style: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _value1Changed1(bool value) => setState(() => _value2 = value);

  bool validationDetails() {
    if (name.text.isEmpty) {
      CustomWidget.showtoast(context, translate('signup_screen.fill_name'));
      return false;
    }
    if (lastname.text.isEmpty) {
      CustomWidget.showtoast(context, 'Please enter last name');
      return false;
    }
    else if (email.text.isEmpty) {
      CustomWidget.showtoast(context, translate('login.fill_email'));
      return false;
    }
    else if (!regex.hasMatch(email.text)) {
      CustomWidget.showtoast(
          context,   'Enter valid email address. Check the extra space or invalid character in email id.');

      return false;
    }
    else if (password.text.isEmpty) {
      CustomWidget.showtoast(context, translate('login.fill_password'));
      return false;
    }
    else if (password.text.length<6) {
      CustomWidget.showtoast(
          context,   'password should be 6 digit');
      return false;
    }
    else if (!_value1) {
      CustomWidget.showtoast(context, "Please accept the Privacy Policy");
      return false;
    }
    // else if (!_value2) {
    //   CustomWidget.showtoast(
    //       context, "Please subscribe Newsletter to get new updates.");
    //   return false;
    // }

    return true;
  }

  _launchURL(String url1) async {
    String url = url1;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
