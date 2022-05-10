import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/auth/ChangePassword.dart';
import 'package:kensington/pages/auth/OtpVerification.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';

import 'SignUp.dart';
import 'VerifyEmail.dart';



class verifyLogin extends StatefulWidget {
  String email,id;
  verifyLogin({
    Key key,this.email,this.id
  }) : super(key: key);

  @override
  _LoginPageeState createState() => _LoginPageeState();
}

class _LoginPageeState extends State<verifyLogin> {
  TextEditingController email = new TextEditingController();
   LoginResponse user;
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(pattern);
  void _getUserResendOtp() {
print(email.text);
    Provider.of<LoginProvider>(context, listen: false)
        .resenotp(email.text.toString())
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();
        print(user.msg);
        CustomWidget.showtoast(
            context, "We have sent one time password on your entered email address.");
        if(user.msg=="An OTP send your Register email, Please Chack Your email..")
        {

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VerifyEmail(email: email.text,id: "37",)));

        }

        else{
          CustomWidget.showtoast(context, user.msg);
        }



      }

    });

  }
  // LoginResponse user;
  // void _getUser() {
  //
  //   Provider.of<LoginProvider>(context, listen: false)
  //       .forgetpassword(email.text.toString())
  //       .then((value) {
  //     if (value) {
  //       DialogUtils.hideProgress(context);
  //
  //       user = Provider.of<LoginProvider>(context, listen: false).getUSer();
  //       print(user.msg);
  //       if(user.msg=="OTP Sent"){
  //
  //
  //
  //       }
  //
  //       else if(user.msg=="Email id does not match our record."){
  //         CustomWidget.showtoast(
  //             context, "no record found");
  //       }
  //     }
  //
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:CustomWidget.getappbar1(context),
      body: Column(children: [
        Container(
            margin: EdgeInsets.only(top: 20),

            child:
            CustomWidget.getheading("Verify Account")

        ),
        Container(
          margin: EdgeInsets.only(top: 10),

          child: Text('Enter your email ID',textAlign: TextAlign.center,
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
                    controller: email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "email",
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
                    .isLoading()) {
                  DialogUtils.showProgress(context);
                  _getUserResendOtp();
                }

                // Provider.of<LoginProvider>(context, listen: false)
                //     .setLoading(true);
                // if( Provider.of<LoginProvider>(context, listen: false)
                //     .isLoading()){
                //   DialogUtils.showProgress(context);
                //   _getUser();
                // }

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
        'Send OTP',
        style: GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }
  bool validationDetails() {
    if (email.text.isEmpty) {
      CustomWidget.showtoast(
          context, "please fill email");
      return false;
    }
    else if (!regex.hasMatch(email.text)) {
      CustomWidget.showtoast(
          context,   'Enter valid email address. Check the extra space or invalid character in email id.');

      return false;
    }




    return true;
  }
}
