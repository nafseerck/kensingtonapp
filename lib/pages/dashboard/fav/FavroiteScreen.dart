import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LoginResponse.dart';
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
class FavroiteScreen extends StatefulWidget {
  String properyid,fromwhre;
  FavroiteScreen({
    Key key,this.properyid,this.fromwhre
  }) : super(key: key);

  @override
  SearchListingPageState createState() => SearchListingPageState();
}
class SearchListingPageState extends State<FavroiteScreen> {

  Map<dynamic, dynamic> data;
  List result;
  List<Result> searchlist ;
  SearchModel _searchModel;
  Result house;
  FavModel user;
  String url;
  List<dynamic> list1;
  List<String> photourl=[];
   Future gersearchresult () async{

    Provider.of<LoginProvider>(context, listen: false)
        .fav_result()
        .then((value) {
      if (value) {
        setState(() {
          var str;
          _searchModel = Provider.of<LoginProvider>(context, listen: false).getsearchresult();
          print(_searchModel);
          if (_searchModel.status == "success") {
            searchlist=_searchModel.result;
            if(searchlist.length!=0){
              for(int i=0;i<searchlist.length;i++){
                house=searchlist[i];
                str = searchlist[i].imglist;
                print(str);
                if(str=="[]"){
                  url="";
                }

                else{
                  if(str==""){
                    url="";
                  }
                  else{
                    if(str==null){
                      url="";
                    }
                   else{
                      list1  = json.decode(str);

                      //  for(int j =0;j<list1.length;j++){
                      url = list1[0]['url_md'];

                      photourl.add(url);
                    }
                  }

                }



               // }


              }

              //print( "urllinks"+photourl.toString());

            }
            else{
              searchlist=[];
            }



            // for(int j =0;j<list1.length;j++){
            //   url = list1[0]['url_md'];
            //   print( "urllinks"+ApiClient.BASE_URL+searchlist[0].folder+"/"+url);
            // }


          }
        });


      }
    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDemoActionSheet();

    gersearchresult();
    notif_arrived1();
  }
  void deleteFavroite(property_id,BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .delete_favorite_property(property_id)
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="200"){

          CustomWidget.showtoast(
              context, translate('favroite.property_remove'));
        }
       setState(() {
         searchlist.clear();
         photourl.clear();
         searchlist=null;
         gersearchresult();
       });

      }

    });

  }

  // @override
  // void didUpdateWidget(covariant FavroiteScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   gersearchresult();
  //   print("priya");
  //   // if(searchlist!=null){
  //   //   searchlist.clear();
  //   //   photourl.clear();
  //   //   searchlist=null;
  //   //   gersearchresult();
  //   // }
  //
  //
  // }
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
    var screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.kWhiteColor,
      ),
    );
    return Scaffold(
      backgroundColor: ColorConstant.kWhiteColor,
      appBar:widget.fromwhre=="drawerdashboard"?CustomWidget.getappbar(context,counter):null,
      body:
      searchlist == null
          ? Align(

          alignment: Alignment.center,
          child: ColorLoader3(radius: 20.0, dotRadius: 6.0)) :searchlist.length==0?Align(child:

          Text(
            translate('favroite.nofav'),
      style:    GoogleFonts.ptSerif(
          fontSize: 20, color: ColorConstant.kGreenColor
      ),)
        ,alignment: Alignment.center,):
      SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              Row(

                children: [
                  CustomWidget.getheading1(translate('favroite.fav_result')),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(top:5.0),
                      child: Text(

                        "("+searchlist.length.toString()+")",
                        style: GoogleFonts.ptSerif(
                            fontSize: 15,
                            color: ColorConstant.kGreyColor

                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],),


              SizedBox(
                height: 8,
              ),
              Column(
                children: List.generate(
                  searchlist.length,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailScreen(
                              properyid: searchlist[index].vtObjektnrExtern,
                                  region_name :searchlist[index].region_name!=null?searchlist[index].region_name:"All",
                                ),
                              ),
                            );
                          },
                          child:
                          Container(

                              width: screenWidth,
                              margin: EdgeInsets.only(left: 12, right: 12),
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),



                                // DecorationImage(
                                //   fit: BoxFit.fill,
                                //   image: AssetImage(
                                //  ApiClient.BASE_URL+house.folder+ApiClient.Last_IMAGE_URL
                                //   ),
                                // ),
                              ),
                              child:
                              Stack(

                                children: [
                                  FadeInImage.assetNetwork(
                                    placeholder: "assets/appicon/defalt_image.jpg",
                                    image: searchlist[index].folder!=null?ApiClient.BASE_URL+searchlist[index].folder+"/"+photourl[index]:"",




                                    height:230 ,
                                    width: screenWidth ,
                                    fit: BoxFit.fill,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child:  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          right: 10
                                      ),
                                      child:
                                      GestureDetector(
                                        onTap: (){
                                          Provider.of<LoginProvider>(context, listen: false)
                                              .setLoading(true);
                                          if( Provider.of<LoginProvider>(context, listen: false)
                                              .isLoading()){
                                            DialogUtils.showProgress(context);
                                            deleteFavroite(searchlist[index].vtObjektnrExtern,context);
                                          }
                                        },
                                        child: Icon(

                                          Icons.favorite,
                                          size: 26.0,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ),

                                  )

                                ],)

                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: <Widget>[
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //         top: 10,
                            //       ),
                            //       child:
                            //       Icon(
                            //         Icons.favorite_border,
                            //         size: 26.0,
                            //         color: Colors.white,
                            //       ),
                            //
                            //     ),
                            //   ],
                            // ),
                          ),

                        ),

                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12,top:5),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child:
                          Row(

                            children: [

                              Text(
                                "\u2022 " +
                                    searchlist[index].flWohnflaeche!=null? NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(searchlist[index].flWohnflaeche)) :"",

                                style:   GoogleFonts.ptSerif(
                                    fontSize: 15, color: ColorConstant.kGreyColor
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                "\u2022 " +
                                    searchlist[index].flAnzahlZimmer.toString() +
                                    " "+translate('advance_search.Rooms') ,
                                style:   GoogleFonts.ptSerif(
                                    fontSize: 15, color: ColorConstant.kGreyColor
                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Text(

                                  "\u2022 ${searchlist[index].prKaufpreis==null?searchlist[index].prkaltmiete=="0.00"?translate('search_lang.price_req'):
                                  NumberFormat.currency(locale: 'es',symbol: "€").format(double.parse(searchlist[index].prkaltmiete))
                                      : searchlist[index].prKaufpreis=="0.00"?translate('search_lang.price_req'):NumberFormat.currency(locale: 'es',symbol: "€").format(double.parse(searchlist[index].prKaufpreis))
                                  }",
                                  style:   GoogleFonts.ptSerif(
                                      fontSize: 15, color: ColorConstant.kGreyColor
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],),


                        ),


                        InkWell(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailScreen(
                                  properyid: searchlist[index].vtObjektnrExtern,
                                  region_name :searchlist[index].region_name!=null?searchlist[index].region_name:"All",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 12, right: 12,top:5),
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    searchlist[index].geoOrt.toString(),
                                    style: GoogleFonts.ptSerif(
                                        fontSize: 20,
                                        color: ColorConstant.kGreenColor

                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),




                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(

                                  searchlist[index].ftObjekttitel.toString(),
                                  style: GoogleFonts.ptSerif(
                                      fontSize: 15,
                                      color: ColorConstant.kGreyColor

                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: new Divider(
                            color: ColorConstant.kGreenColor,
                            thickness: 2.0,
                          ) ,
                        )


                      ],
                    )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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


}



