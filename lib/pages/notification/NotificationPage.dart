import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/NotificationModel.dart';

import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/search/SearchListingPage.dart';
import 'package:kensington/pages/search/item_detail_screen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translation_widget.dart';
import 'package:kensington/transalation/translations.dart';
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
class NotificationPage  extends StatefulWidget {

  NotificationPage({
    Key key
  }) : super(key: key);

  @override
  SearchListingPageState createState() => SearchListingPageState();
}
class SearchListingPageState extends State<NotificationPage> {



  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      setState(() {
        changeLocale(context, value);
      });
    });
  }
  NotificationModel notificationModel;
  List<Result> notificationlist ;
  int counter=0;
  Future getnotification () async{

    Provider.of<LoginProvider>(context, listen: false)
        .notification_result()
        .then((value) {
      if (value) {
        if (mounted) {
          setState(() {
            notificationModel = Provider.of<LoginProvider>(context, listen: false).getNoti();
            if (notificationModel.status == "success") {
              notificationlist=notificationModel.result;


            }
          });
        }

      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDemoActionSheet();
    getnotification();
main();

  }
  String language1 ;
  Future<void> main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language1 = prefs.getString('language');
    if(language1=="de-DE"){
      language1=Translations.languages[1];
    }
    else if(language1=="en-GB"){
      language1= Translations.languages.first;
    }
    else if(language1=="es-ES"){
      language1=  Translations.languages.last;
    }
    else if(language1==null){
      language1=Translations.languages.first;
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstant.kdrwerbgColor,
      appBar:
      // here the desired height
      AppBar(
        centerTitle: true,
        title:  Image.asset(
          'assets/appicon/icon.png',

          height: 34,
        ),

        backgroundColor: ColorConstant.kGreenColor,




      ),




      body:    notificationlist == null
          ? Align(

          alignment: Alignment.center,
          child: ColorLoader3(radius: 20.0, dotRadius: 6.0)) :notificationlist.length==0?Align(child:

      Text(
        translate('notification.nonoti'),
        style:    GoogleFonts.ptSerif(
            fontSize: 20, color: ColorConstant.kGreenColor
        ),)
        ,alignment: Alignment.center,):
      ListView.builder(
          itemCount: notificationlist.length,
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){

                if(notificationlist[index].countryId==null){
                  CustomWidget.showtoast(
                      context, translate('notification.delet'));
                }
             else{
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SearchListingPage(
                    countryid:notificationlist[index].countryId,region_name:notificationlist[index].regionId,location_name:notificationlist[index].locationName,looking_for:notificationlist[index].lookingForName,property_type:notificationlist[index].propertyType,fromwhere:"advancesearch",plot_size_from:notificationlist[index].plotSizeFrom,plot_size_to:notificationlist[index].plotSizeTo,living_space_from:notificationlist[index].livingSpaceFrom,living_space_to:notificationlist[index].livingSpaceTo,rooms_from:notificationlist[index].roomsFrom,rooms_to:notificationlist[index].roomsTo,bedroom_from:notificationlist[index].bedroomFrom,bedroom_to:notificationlist[index].bedroomTo,bathroom_from:notificationlist[index].bedroomFrom,bathroom_to:notificationlist[index].bathroomTo,tarrace_from:notificationlist[index].terrace,price_from:notificationlist[index].priceFrom,price_to:notificationlist[index].priceTo,region_name_real: notificationlist[index].regionName,aircondition: notificationlist[index].airCondition,seaview:notificationlist[index].seaView,swimmingpool: notificationlist[index].swimmingPool ,)));
                }
              },
              child:

              Container(
                  margin: EdgeInsets.only(left: 28.0,right: 28.0,top: 13.0),
                  padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),


                  decoration: new BoxDecoration(
                    //  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                      borderRadius: BorderRadius.all( Radius.circular(10.0)),
                    color:notificationlist[index].countryId==null? ColorConstant.checkednotifbackgrond:ColorConstant.notifbackgrond,
                  ),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: <Widget>[
                          Icon(Icons.report_gmailerrorred_outlined,size: 25.0),
                          SizedBox(width: 5,),
                          Expanded(
                            child:
                            TranslationWidget(
                              message:  notificationlist[index].message,
                              toLanguage: language1,
                              builder:
                                  (translatedMessage) =>
                                      Text(translatedMessage,style:GoogleFonts.ptSerif(color: ColorConstant.kGreenColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                            ),

                          ),


                        ],
                      ),

                      SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      CustomWidget.getTextsmall(translate('notification.date')+": "+notificationlist[index].createdAt),
                    ],)
                    ],
                  )


              ),
            );
          }

      )


    );
  }




}



