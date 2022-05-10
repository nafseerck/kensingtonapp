
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/search/SearchListingPage.dart';
import 'package:kensington/pages/search/item_detail_screen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:kensington/utils/model/data_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../color_constants.dart';

class ImageWidget extends StatefulWidget {

  Result house;
  List<Result> houselist;
  int imgpath_index;
  List<String> imageList;
  final Function() onbtnTap;
  final Function() onbtnTapdelete;
  String countryid,region_name,location_name,looking_for,property_type,region_name_real;
  ImageWidget({
    Key key,
    this.house,
    this.imgpath_index,
    this.countryid,
    this.region_name,this.location_name,this.looking_for,this.property_type,this.region_name_real,
    this.onbtnTap,
    this.onbtnTapdelete
  }) : super(key: key);
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<ImageWidget> {

  // ImageWidget(
  //
  //   this.house,
  //   this.imgpath_index,
  //     this.countryid,
  //     this.region_name,this.location_name,this.looking_for,this.property_type,this.region_name_real,
  //     this.onbtnTap,
  //
  // );
  String isfav="0";
  FavModel user;
  void _saveFavroite(property_id,BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .save_favorite_property(property_id,widget.region_name==null?"All":widget.region_name)
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="200"){
          CustomWidget.showtoast(
              context, translate('search_lang.save_fav'));
          widget.onbtnTap();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:countryid,region_name:region_name,location_name:location_name,looking_for:looking_for,property_type:property_type,fromwhere: "mainsearch",region_name_real: region_name_real,)));

        }

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
  // Future<void> main() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   language1 = prefs.getString('language');
  //   if(language1=="de-DE"){
  //     language1=Translations.languages[1];
  //   }
  //   else if(language1=="en-GB"){
  //     language1= Translations.languages.first;
  //   }
  //   else if(language1=="es-ES"){
  //     language1=  Translations.languages.last;
  //   }
  //   else if(language1==null){
  //     language1=Translations.languages.first;
  //   }
  // }
  void deleteFavroite(property_id,BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .delete_favorite_property(property_id)
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="200"){
          CustomWidget.showtoast(
              context, translate('search_lang.delete_fav'));
          widget.onbtnTapdelete();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:countryid,region_name:region_name,location_name:location_name,looking_for:looking_for,property_type:property_type,fromwhere: "mainsearch",region_name_real: region_name_real,)));
        }

      }

    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDemoActionSheet();
  }



  @override
  Widget build(BuildContext context) {
    List<String> photourl=[];
    String url;

    var str = widget.house.imglist;
    if(str=="[]"){
      url="";
    }

    else{
      if(str==""){
        url="";
      }
      else{
        List<dynamic> list1  = json.decode(str);
        for(int j =0;j<list1.length;j++){
          url = list1[0]['url_md'];


        }
      }

    }

    final oCcy = new NumberFormat("##,##,###", "en_INR");
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailScreen(
                  properyid: widget.house.vtObjektnrExtern,
region_name: widget.region_name==null?"All":widget.region_name,
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
                    image: ApiClient.BASE_URL+widget.house.folder+"/"+url,
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
                      widget.house.isfavroite=="0"? GestureDetector(
                        onTap: (){

                          Provider.of<LoginProvider>(context, listen: false)
                              .setLoading(true);
                          if( Provider.of<LoginProvider>(context, listen: false)
                              .isLoading()){
                          DialogUtils.showProgress(context);
                          _saveFavroite(widget.house.vtObjektnrExtern,context);

                          }
                        },

                        child: Icon(

                          Icons.favorite_border,
                          size: 26.0,
                          color: Colors.white,
                        ),
                      ):GestureDetector(
                        onTap: (){

                          Provider.of<LoginProvider>(context, listen: false)
                              .setLoading(true);
                          if( Provider.of<LoginProvider>(context, listen: false)
                              .isLoading()){
                            DialogUtils.showProgress(context);
                            deleteFavroite(widget.house.vtObjektnrExtern,context);
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

                    widget.house.flWohnflaeche!=null? NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(widget.house.flWohnflaeche)) :"",

                style:   GoogleFonts.ptSerif(
                    fontSize: 15, color: ColorConstant.kGreyColor
                ),
              ),
              SizedBox(width: 15,),
              Text(


                    widget.house.flAnzahlZimmer !=null? "\u2022 "+widget.house.flAnzahlZimmer.toString() +
                    " "+translate('advance_search.Rooms'):"" ,
                style:   GoogleFonts.ptSerif(
                    fontSize: 15, color: ColorConstant.kGreyColor
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Text(
                  "\u2022 ${widget.house.prKaufpreis==null?widget.house.prkaltmiete=="0.00"?translate('search_lang.price_req'):
                  NumberFormat.currency(locale: 'es',symbol: "€").format(double.parse(widget.house.prkaltmiete))
                      : widget.house.prKaufpreis=="0.00"?translate('search_lang.price_req'):NumberFormat.currency(locale: 'es',symbol: "€").format(double.parse(widget.house.prKaufpreis))
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
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailScreen(
                  properyid: widget.house.vtObjektnrExtern,
                  region_name: widget.region_name,
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
    widget. house.geoOrt.toString(),
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




        Visibility(
          visible:  widget.house.ftObjekttitel.toString()==""?false:true ,
          child: Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(

                    widget.house.ftObjekttitel.toString(),
                    style: GoogleFonts.ptSerif(
                        fontSize: 15,
                        color: ColorConstant.kGreyColor

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
      child: new Divider(
        color: ColorConstant.kGreenColor,
        thickness: 2.0,
      ) ,
    )



      ],
    );
  }
}


