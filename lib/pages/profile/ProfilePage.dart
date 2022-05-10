import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/ProfileShowModel.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/search/item_detail_screen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/ColorLoader3.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:kensington/utils/cus_widget/image_widget.dart';
import 'package:kensington/utils/cus_widget/image_widget_fav.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';






class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool _statuschangepasssword = false;
  final FocusNode myFocusNode = FocusNode();
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(pattern);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDemoActionSheet();
    getprofile();
    notif_arrived1();
  }
  Future<void> notif_arrived1() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notifi = prefs.getBool('notification_arr');
    if(notifi==null){
      notifi=false;
    }
    if(notifi){
      counter=0;
    }
    else{
      getcount();


    }


  }
  List<ProfileResult> profilelist ;
  ProfileShowModel profileShowModel;
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController oldpassword = new TextEditingController();
  TextEditingController newpassword = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  bool _obscureText = true;
  bool _obscureTextnewpass = true;
  bool _obscureTextconfirm = true;
  String _password;


  Future getprofile () async{

    Provider.of<LoginProvider>(context, listen: false)
        .user_profile()
        .then((value) {
      if (value) {
        setState(() {
          var str;
          profileShowModel = Provider.of<LoginProvider>(context, listen: false).getprofile();
          if (profileShowModel.status == "success") {
            profilelist=profileShowModel.result;

setState(() {
  name.text= profilelist[0].userName;
  email.text= profilelist[0].userEmail;
});

          }
        });


      }
    });
  }
  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  FavModel user;
  FavModel passworfuser;
  void updateprofile(BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .update_profile(name.text.toString(),email.text.toString())
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="success"){
          CustomWidget.showtoast(
              context, translate('profile.profile_updated'));
          setState(() {
            _status = true
;


            getprofile();

          });
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:countryid,region_name:region_name,location_name:location_name,looking_for:looking_for,property_type:property_type,fromwhere: "mainsearch",region_name_real: region_name_real,)));

        }

      }

    });

  }
  void resetprofile(BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .reset_password(oldpassword.text.toString(),newpassword.text.toString())
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        passworfuser = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(passworfuser.status=="success"){
          CustomWidget.showtoast(
              context, translate('profile.password_updated'));
          setState(() {
            _statuschangepasssword = false;
            ;

          });


        }
        if(passworfuser.status=="unsuccess"){
          CustomWidget.showtoast(
              context, translate('profile.toast_old'));



        }

      }

    });

  }
  CountModel countModel;
  int counter=0;
  void getcount() {

    Provider.of<LoginProvider>(context, listen: false)
        .count_notification()
        .then((value) {
      if (value) {
        // DialogUtils.hideProgress(context);

        countModel = Provider.of<LoginProvider>(context, listen: false).getcount();
        if(countModel.status=="success"){
          setState(() {
            counter=countModel.propertyCount;
          });
        }


      }

    });

  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: CustomWidget.getappbar(context,counter),
        body:
        profilelist == null
            ? Align(

            alignment: Alignment.center,
            child: ColorLoader3(radius: 20.0, dotRadius: 6.0)):
         Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[

                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      new Text(
                                        translate('profile.my_profile'),
                                        style: GoogleFonts.ptSerif(
                                            fontSize: 25.0, color: ColorConstant.kGreenColor
                                        ),

                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Text(translate('sell_property.sell_name'),style: GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 13
                            ) ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),

                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child:
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 2),
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Color(0xfffff0eff5)

                                      )
                                      ,
                                      child: TextField(
controller: name,
                                          enabled: !_status,
                                          autofocus: !_status,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: ColorConstant.edittextcolor,
                                                fontFamily: "PTSerif"

                                            ),

                                          ),
                                     style:    GoogleFonts.ptSerif(
                                          color: ColorConstant.edittextcolor
                                      ),
                                      ),
                                    ),
                                    // new TextField(
                                    //   decoration: const InputDecoration(
                                    //     hintText: "Enter Your Name",
                                    //   ),
                                    //   enabled: !_status,
                                    //   autofocus: !_status,
                                    //
                                    // ),
                                  ),
                                ],
                              )),
                          Padding(

                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Text(translate('sell_property.sell_email'),style: GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 13
                            ) ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child:    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 2),
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Color(0xfffff0eff5)

                                      )
                                      ,
                                      child: TextField(
controller: email,
                                          enabled: !_status,
                                          autofocus: !_status,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,

                                            hintStyle: TextStyle(
                                                color: ColorConstant.edittextcolor,
                                                fontFamily: "PTSerif"

                                            ),
                                          ),
                                        style:    GoogleFonts.ptSerif(
                                            color: ColorConstant.edittextcolor
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Visibility(
                            visible: _status,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: _changeButton()),
                          ),
                          Visibility(
                            visible: _statuschangepasssword,
                              child: getchangepassword()),



                          !_status ? _getActionButtons(context) : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
  Widget _getActionButtonspassword() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text( translate('profile.save_pass'),
                        style:    GoogleFonts.ptSerif(
                         color: Colors.white
                    )
                    ),

                    color: ColorConstant.kGreenColor,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if(validationchangepassword()){

                        Provider.of<LoginProvider>(context, listen: false)
                            .setLoading(true);
                        if( Provider.of<LoginProvider>(context, listen: false)
                            .isLoading()){
                          DialogUtils.showProgress(context);
                          resetprofile(context);
                        }


                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text(translate('profile.Cancel'),
    style:    GoogleFonts.ptSerif(
    color: Colors.white
    )),

                    color: ColorConstant.kGreenColor,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _statuschangepasssword = false;

                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  Widget _getActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text(translate('profile.Save'),  style:    GoogleFonts.ptSerif(
                        color: Colors.white
                    )),

                    color: ColorConstant.kGreenColor,
                    onPressed: () {



                          FocusScope.of(context).requestFocus(new FocusNode());


                          if(validationDetails()){
                            Provider.of<LoginProvider>(context, listen: false)
                                .setLoading(true);
                            if( Provider.of<LoginProvider>(context, listen: false)
                                .isLoading()){
                              DialogUtils.showProgress(context);
                              updateprofile(context);
                            }
                          }


                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text(translate('profile.Cancel'),  style:    GoogleFonts.ptSerif(
                        color: Colors.white
                    )),

                    color: ColorConstant.kGreenColor,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _status = true;

                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  bool validationDetails() {


    if (name.text.isEmpty) {
      CustomWidget.showtoast(
          context, translate('login.fill_name'));
      return false;
    }
    else if (email.text.isEmpty) {
      CustomWidget.showtoast(
          context, translate('login.fill_email'));
      return false;
    }
    else if (!regex.hasMatch(email.text)) {

      CustomWidget.showtoast(
          context,translate('profile.valid_email'));
      return false;
    }

    return true;
  }
  bool validationchangepassword() {


    if (oldpassword.text.isEmpty) {
      CustomWidget.showtoast(
          context,translate('profile.old_pass'));
      return false;
    }
    else if (newpassword.text.isEmpty) {
      CustomWidget.showtoast(
          context, translate('profile.fill_new'));
      return false;
    }
    else if (newpassword.text.length<6) {
      CustomWidget.showtoast(
          context,   translate('login.passdigit'));
      return false;
    }

    else if (newpassword.text!=confirmpassword.text) {
      CustomWidget.showtoast(
          context, translate('profile.password_same'));
      return false;
    }


    return true;
  }
  Widget _changeButton() {

    return
      RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: ColorConstant.kGreenColor)
        ),
        onPressed: () {
          setState(() {
            _statuschangepasssword = true;
          });
        },

        color: Color(0xffff345f4f),
        padding: EdgeInsets.only(left:28.0,right:28,top:10,bottom: 10),
        child:Text(
          translate('profile.change_pass'),
          style:    GoogleFonts.ptSerif(
              fontSize: 20, color: Colors.white
          ),),
      );

  }
  Widget getchangepassword() {
    return    Column(
      children: <Widget>[

        new Container(
          color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[


                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),

                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child:
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 25),
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xfffff0eff5)

                            )
                            ,
                            child: TextField(
                                controller: oldpassword,
                                obscureText: _obscureText,
                                enabled: _statuschangepasssword,
                                autofocus: _statuschangepasssword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:  translate('profile.old_password'),
                                  hintStyle: TextStyle(
                                      color: ColorConstant.edittextcolor,
                                      fontFamily: "PTSerif"

                                  ),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText ? Icons.visibility_off : Icons.visibility,
                                      color: ColorConstant.kGreenColor,
                                    ),
                                    onPressed: () {
                                      // use _setState that belong to StatefulBuilder
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),


                                ),
                              style:    GoogleFonts.ptSerif(
                                  color: ColorConstant.edittextcolor
                              ),
                            ),
                          ),
                          // new TextField(
                          //   decoration: const InputDecoration(
                          //     hintText: "Enter Your Name",
                          //   ),
                          //   enabled: !_status,
                          //   autofocus: !_status,
                          //
                          // ),
                        ),
                      ],
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child:    Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 25),
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xfffff0eff5)

                            )
                            ,
                            child: TextField(
                                controller: newpassword,
                                obscureText: _obscureTextnewpass,
                                enabled: _statuschangepasssword,
                                autofocus: _statuschangepasssword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:  translate('profile.new_Save'),
                                  hintStyle: TextStyle(
                                      color: ColorConstant.edittextcolor,
                                      fontFamily: "PTSerif"

                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureTextnewpass ? Icons.visibility_off : Icons.visibility,
                                      color: ColorConstant.kGreenColor,
                                    ),
                                    onPressed: () {
                                      // use _setState that belong to StatefulBuilder
                                      setState(() {
                                        _obscureTextnewpass = !_obscureTextnewpass;
                                      });
                                    },
                                  ),
                                ),
                              style:    GoogleFonts.ptSerif(
                                  color: ColorConstant.edittextcolor
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child:    Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 25),
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xfffff0eff5)

                            )
                            ,
                            child: TextField(
                                controller: confirmpassword,
                                obscureText: _obscureTextconfirm,
                                enabled: _statuschangepasssword,
                                autofocus: _statuschangepasssword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:  translate('profile.confirm_pass'),
                                  hintStyle: TextStyle(
                                      color: ColorConstant.edittextcolor,
                                      fontFamily: "PTSerif"

                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureTextconfirm ? Icons.visibility_off : Icons.visibility,
                                      color: ColorConstant.kGreenColor,
                                    ),
                                    onPressed: () {
                                      // use _setState that belong to StatefulBuilder
                                      setState(() {
                                        _obscureTextconfirm = !_obscureTextconfirm;
                                      });
                                    },
                                  ),
                                ),
                              style:    GoogleFonts.ptSerif(
                                  color: ColorConstant.edittextcolor
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),




                _statuschangepasssword ? _getActionButtonspassword() : new Container(),
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: ColorConstant.kGreenColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          _statuschangepasssword = false;

          _status = false;
        });
      },
    );
  }
}



