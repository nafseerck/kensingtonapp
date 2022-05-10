import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/auth/ChangePassword.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
class VerifyEmail extends StatefulWidget {
String email,id;
  VerifyEmail({
    Key key,this.email,this.id
  }) : super(key: key);

  @override
  _LoginPageeState createState() => _LoginPageeState();
}

class _LoginPageeState extends State<VerifyEmail> {
  TextEditingController otp = new TextEditingController();
  PreferencesApp bloc;
  LoginResponse user;
  void _getUser() {

    Provider.of<LoginProvider>(context, listen: false)
        .verifyemailotp(otp.text.toString(),widget.email)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();

        if(user.msg=="Email varified Success.")
        {

          bloc = Provider.of<LoginProvider>(context,listen: false).bloc;

          bloc.savePrefernses(user.userId,widget.email);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              HomeScreens()), (Route<dynamic> route) => false);

        }

        else if(user.msg=="Invaild Otp"){
          CustomWidget.showtoast(
              context, "otp does not match");
        }
      }

    });

  }
  void _getUserResendOtp() {

    Provider.of<LoginProvider>(context, listen: false)
        .resenotp(widget.email)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();

        if(user.msg=="An OTP send your Register email, Please Chack Your email..")
        {
CustomWidget.showtoast(context, "We have sent one time password on your entered email address");


        }
        else{
          CustomWidget.showtoast(context, user.msg);
        }



      }

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // CustomWidget.showtoast(
    //     context, "We have sent one time password on your entered email address.");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:CustomWidget.getappbar1(context),
      body: Column(children: [
        Container(
            margin: EdgeInsets.only(top: 20),

            child:
            CustomWidget.getheading("OTP Verify")

        ),
        Container(
          margin: EdgeInsets.only(top: 10),

          child: Text('Enter your OTP',textAlign: TextAlign.center,
              style: GoogleFonts.ptSerif(
                color:ColorConstant.kGreyColor,
                fontSize: 16,
              )
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:20,bottom: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              Container(
                height: 50,
                margin: EdgeInsets.only(left: 30, right: 30,top:15),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xfffff0eff5)

                )
                ,
                child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: otp,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter one time password",
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
        Padding(
          padding: const EdgeInsets.only(right:30.0,top:10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  Provider.of<LoginProvider>(context, listen: false)
                      .setLoading(true);
                  if( Provider.of<LoginProvider>(context, listen: false)
                      .isLoading()) {
                    DialogUtils.showProgress(context);
                    _getUserResendOtp();
                  }
                },


                child: Text("Resend OTP",

                  style: TextStyle(
                    fontFamily: "PTSerif",
                    color: ColorConstant.kGreenColor,fontSize: 15,
                  ),),
              ),
            ],),
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
            child: _submitButton())
      ],),
    );
  }


  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.only(left: 30,right: 30,top:10,bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorConstant.kGreenColor
      ),
      child: Text(
        'Verify',
        style: GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }
  bool validationDetails() {
    if (otp.text.isEmpty) {
      CustomWidget.showtoast(
          context, "please fill otp");
      return false;
    }




    return true;
  }
}