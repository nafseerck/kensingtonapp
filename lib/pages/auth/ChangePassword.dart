import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/auth/LoginPage.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';





class ChangeePassword extends StatefulWidget {
  String email;
  ChangeePassword({
    Key key,this.email
  }) : super(key: key);

  @override
  _LoginPageeState createState() => _LoginPageeState();
}

class _LoginPageeState extends State<ChangeePassword> {

  TextEditingController password = new TextEditingController();
  TextEditingController confirm_pass = new TextEditingController();


  LoginResponse user;
  void _getUser() {

    Provider.of<LoginProvider>(context, listen: false)
        .new_password(widget.email,password.text.toString())
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getUSer();

        if(user.msg=="Password changed successfully")
        {


          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              LoginPage()), (Route<dynamic> route) => false);

        }

        else if(user.msg=="OTP does not match."){
          CustomWidget.showtoast(
              context, "otp does not match");
        }
      }

    });

  }
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
            CustomWidget.getheading("Change Password")

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
controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "new password",
                      hintStyle: TextStyle(
                          color: ColorConstant.edittextcolor,
                          fontFamily: "PTSerif"

                      ),
                    )
                ),
              ),
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
controller: confirm_pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "confirm password",
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
        'Change password',
        style: GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }
  bool validationDetails() {

     if (password.text.isEmpty) {
      CustomWidget.showtoast(
          context, "please fill new password");
      return false;
    }
    else if (confirm_pass.text.isEmpty) {
      CustomWidget.showtoast(
          context, "please fill confirm password");
      return false;
    }

    else if (password.text!=confirm_pass.text) {
      CustomWidget.showtoast(
          context, "password must be same as above");
      return false;
    }

    return true;
  }
}
