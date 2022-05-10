import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';




class RequestSend extends StatefulWidget {
  RequestSend({
    Key key,
  }) : super(key: key);

  @override
  _RequestSendState createState() => _RequestSendState();
}

class _RequestSendState extends State<RequestSend> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController description = new TextEditingController();
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(pattern);
  @override
  void initState() {

    super.initState();
    showDemoActionSheet();
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
  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  LoginResponse user;
  void _getUser() {

    Provider.of<LoginProvider>(context, listen: false)
        .sendRequest(name.text,email.text,phone.text,description.text)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();
if(user.msg=="Request Sent"){
  CustomWidget.showtoast(
      context,translate('sell_property.request'));
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
    return Scaffold(

      backgroundColor: Colors.white,
      appBar:CustomWidget.getappbar(context,counter),
      body: ListView(children: [
      Align(
      child: Image.asset(

      'assets/appicon/logo.png',
        height: 50,

      ),
      ),
        Container(
          alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),

            child:
            CustomWidget.getheading(translate('sell_property.send_re'))

        ),
        Container(
          margin: EdgeInsets.only(top: 10),

          child: Text(translate('sell_property.enter_detail'),textAlign: TextAlign.center,
              style:
      GoogleFonts.ptSerif(
          color:Colors.grey,
          fontSize: 16

    ),
            ),
        ),
        Container(
          margin: EdgeInsets.only(top:10,bottom: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40,top:15),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xfffff0eff5)

                )
                ,
                child: TextField(
controller: name,

                    inputFormatters: [new WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: translate('sell_property.full_n'),
                      hintStyle: TextStyle(
                          color: ColorConstant.edittextcolor,
                          fontFamily: "PTSerif"

                      ),
                    )
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40,top:15),
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
                      hintText: translate('login.email'),
                      hintStyle: TextStyle(
                          color: ColorConstant.edittextcolor,
                          fontFamily: "PTSerif"

                      ),
                    )
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40,top:15),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xfffff0eff5)

                )
                ,
                child: TextField(
                  controller: phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: "",

                      border: InputBorder.none,
                      hintText: translate('sell_property.phone_n'),
                      hintStyle: TextStyle(
                          color: ColorConstant.edittextcolor,
                          fontFamily: "PTSerif"

                      ),
                    )
                ),
              ),


            ],
          ),
        ),
        Container(
          height: 200,
          margin: EdgeInsets.only(left: 40, right: 40,top: 10),
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xfffff0eff5)

          )
          ,
          child: TextField(
controller: description,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: translate('sell_property.desc_req_text'),
                hintStyle: TextStyle(
                    color: ColorConstant.edittextcolor,
                    fontFamily: "PTSerif"

                ),
              )
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
/*
          child: new ElevatedButton(onPressed: () => _launchURL('nck@kensington-international.com', 'Flutter Email Test', 'Hello Flutter'), child: new Text('Send mail'),),
*/


        )

      ],),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.only(left: 40,right: 40,top:20,bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffff345f4f)
      ),
      child: Text(
        translate('sell_property.send_re'),
        style:     GoogleFonts.ptSerif(
          fontSize: 20, color: Colors.white
      ),
      ),
    );
  }
  bool isValidEmail(email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
  bool validationDetails() {


    if (name.text.isEmpty) {
      CustomWidget.showtoast(
          context, translate('sell_property.name_sale'));
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
    else if (phone.text.isEmpty) {
      CustomWidget.showtoast(
          context, translate('sell_property.sell_phone'));
      return false;
    }
    else if (phone.text.length != 12) {
      CustomWidget.showtoast(context, translate('sell_property.sell_mobile_vali'));
      return false;
    }
    else if (description.text.isEmpty) {
      CustomWidget.showtoast(
          context,translate('sell_property.desc_req'));
      return false;
    }

    return true;
  }

}
