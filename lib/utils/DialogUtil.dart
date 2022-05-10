import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ColorLoader3.dart';
import 'package:flutter_translate/flutter_translate.dart';
class DialogUtils {
  static AlertDialog _progress;
BuildContext _context;
  static void showProgress(context) {
    showDemoActionSheet(context);
    if (context == null) {
      return;
    }
    if (_progress == null) {
      var bodyProgress = new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          ColorLoader3(radius:20.0,dotRadius:6.0),
           Container(
            margin: const EdgeInsets.only(left: 25.0),
            child: new Text(
              translate('search_lang.pleasewait'),
              style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
      _progress = new AlertDialog(
        content: bodyProgress,
      );
    }

    showDialog(builder: (context) => _progress, context: context, barrierDismissible: true);

  }

  static void hideProgress(context) {
    if (context == null) {
      return;
    }
    if(_progress!=null){
      Navigator.pop(context);
      _progress=null;
    }

  }

  static void showMessageDialog(BuildContext context,String msg){
    AlertDialog dialog=new AlertDialog(
      content: new Text(msg ,style: new TextStyle(color: Colors.blue),),
      actions: <Widget>[
        new FlatButton(onPressed: (){Navigator.pop(context);},
            child: new Text("OK",style: new TextStyle(color: Colors.blue)))
      ],);
    showDialog(builder: (context) => dialog, context: context);
  }
  static void showtoast(BuildContext context,String msg){
    Toast.show(msg, context, duration:4 , gravity:  Toast.BOTTOM);

  }

  static void showDemoActionSheet(BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
}
