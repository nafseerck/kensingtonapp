import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kensington/PanaromaView/PanoromaPage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/PropertDetailModel.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/request/RequestSend.dart';
import 'package:kensington/pages/slider/FullScreen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translation_widget.dart';
import 'package:kensington/transalation/translations.dart';
import 'package:kensington/utils/ColorLoader3.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/cus_widget/house_widget.dart';
import 'package:kensington/utils/cus_widget/menu_widget.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:kensington/utils/model/data_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class ItemDetailScreen extends StatefulWidget {
  String properyid,region_name;
  ItemDetailScreen({
    Key key,this.properyid,this.region_name
  }) : super(key: key);

  @override
  ItemDetailScreenPageState createState() => ItemDetailScreenPageState();
}
class ItemDetailScreenPageState extends State<ItemDetailScreen> {
  FavModel user;
  String url;
  List<String> properties=[];
  int index = 1;
  List<ResultProperty> propertylist ;
  PropertDetailModel propertDetailModel;
  ResultProperty house;
  Future getpropertyresult () async{

    Provider.of<LoginProvider>(context, listen: false)
        .property_detail(widget.properyid)
        .then((value) {
      if (value) {
        setState(() {
          propertDetailModel = Provider.of<LoginProvider>(context, listen: false).getpropertydetail();
          if (propertDetailModel.status == "success") {
            propertylist=propertDetailModel.result;
            for(int i=0;i<propertylist.length;i++){
              house=propertylist[i];

              var str = propertylist[i].imglist;
              List<dynamic> list1  = json.decode(str);
              for(int j =0;j<list1.length;j++){
                url = list1[j]['url_md'];


                properties.add(ApiClient.BASE_URL+house.folder+"/"+url);
              }
            }



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
  void _saveFavroite(property_id,BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .save_favorite_property(property_id,widget.region_name)
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="200"){
          CustomWidget.showtoast(
              context, translate('search_lang.save_fav'));

setState(() {
  propertylist.clear();
  propertylist=null;
  getpropertyresult();
});
        }

      }

    });

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
              context,translate('search_lang.delete_fav'));
          setState(() {
            propertylist.clear();
            propertylist=null;
            getpropertyresult();
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
    //main();
    getpropertyresult();
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

    var screenWidth = MediaQuery.of(context).size.width;
    final oCcy = new NumberFormat("##,##,###", "en_INR");
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.kWhiteColor,
      ),
    );
    return Scaffold(
        appBar:CustomWidget.getappbar(context,counter),
        backgroundColor: ColorConstant.kWhiteColor,

        body: ListView(children: [
          propertylist == null
              ? Align(

              alignment: Alignment.center,
              child: ColorLoader3(radius: 20.0, dotRadius: 6.0)) :propertylist.length==0?Align(child: CustomWidget.getText(translate('item_detail.itemdetail')),alignment: Alignment.center,): Container(
          padding: EdgeInsets.only( bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullscreenSliderDemo(
                           imageListslider: properties,
                          ),
                        ),
                      );


                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 0, bottom: 10),
                      margin: EdgeInsets.all(0),
                      child: SizedBox(

                        width: screenWidth,
child: CarouselSlider(
    options: CarouselOptions(
      viewportFraction: 1.0,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),

    autoPlayAnimationDuration: Duration(milliseconds: 800),
      onPageChanged: (index, reason) {
        setState(() {
         // _currentIndex = index;
        });
      },


    ),
  items: properties.map((it) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(),
      child:
      ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child:
        FadeInImage.assetNetwork(
            placeholder: "assets/appicon/defalt_image.jpg",
            fit: BoxFit.cover,
            image: it),
      ),


    );
  }).toList(),

),


                      ),
                    ),
                  ),

                  SizedBox(height: 15,),
              Visibility(
                visible: house.virtualLink!=null?true:false,
                child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 15,
                  left: 15,),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => WebViewExample(link: house.virtualLink,)));
                  },
                  child: Row(children: [
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.transparent,
                              width: 10.0
                          ),

                        ),
                        child:

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/degree.png',

                            ),
                            SizedBox(width: 2,),
                            Text(
                              "Virtual tour",
                              // translate('item_detail.call'),
                              style:    GoogleFonts.ptSerif(
                                  fontSize: 16, color: ColorConstant.kGreenColor
                              ),
                            ),
                          ],)
                    ),


                  ],),
                ),
              ),) ,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      right: 15,
                      left: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[

                        Column(
                          children: [
                            MenuWidget(
                              iconImg:house.isfavroite=="0"?  Icons.favorite_border:Icons.favorite,
                              iconColor: ColorConstant.kWhiteColor,
                              conBackColor: Colors.transparent,
                              isfav: house.isfavroite,
                              onbtnTap: (){
if(house.isfavroite=="0"){
  Provider.of<LoginProvider>(context, listen: false)
      .setLoading(true);
  if( Provider.of<LoginProvider>(context, listen: false)
      .isLoading()){
    DialogUtils.showProgress(context);
    _saveFavroite(house.vtObjektnrExtern,context);

  }
}
else{
  Provider.of<LoginProvider>(context, listen: false)
      .setLoading(true);
  if( Provider.of<LoginProvider>(context, listen: false)
      .isLoading()){
    DialogUtils.showProgress(context);
    deleteFavroite(house.vtObjektnrExtern,context);
  }
}
                              },
                            ),
                            SizedBox(height: 15,),
                            MenuWidget(
                              iconImg: Icons.message,
                              iconColor: ColorConstant.kWhiteColor,
                              conBackColor: Colors.transparent,
                              onbtnTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => RequestSend()));
                              },
                            ),
                          ],)
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible:house.ftObjekttitel!=""?true:false ,
                child: Container(

                  padding: EdgeInsets.only(left: 15, top: 10,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Container(color: ColorConstant.kGreenColor,
                              width: 6,
                              height: 30,
                            ),
                            SizedBox(width: 8,),

                                SizedBox(
                                  width: 350,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child:  SelectableText(
                                      house.ftObjekttitel,

                                      style:
                                      GoogleFonts.ptSerif(
                                        color: ColorConstant.kGreenColor,
                                        fontSize: 20,

                                      ),
                                    ),
                                  ),
                                )



                          ],),



                        ],
                      ),

                    ],
                  ),
                ),
              ),

             Container(
               child: Padding(
                 padding: const EdgeInsets.only(left: 10),
                 child: HouseWidget(
                   house: house,
                   region_name: widget.region_name,


                 ),
               ),
             ),
              Visibility(

                visible:house.ftObjektbeschreibung!=""?true:false ,
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,

                            top:10,
                          ),
                          child: Row(children: [
                            Container(color: ColorConstant.kGreenColor,
                              width: 6,
                              height: 30,
                            ),
                            SizedBox(width: 8,),
                            Text(
                              translate('item_detail.des'),
                              style:
                              GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 20,

                              ),
                            ),
                          ],),
                        ),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 15,
                                top: 10,
                                bottom: 20,
                              ),
                              child:

                              SelectableText(
                                house.ftObjektbeschreibung.toString(),
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.ptSerif(
                                  fontSize: 15,
                                  color: ColorConstant.kGreyColor,
                                ),
                              ),



                            )),
                    ],)


              ),


              Visibility(
                visible:house.ftLage!=""?true:false ,


                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,

                        top:10,
                      ),
                      child: Row(children: [

                        Container(color: ColorConstant.kGreenColor,
                          width: 6,
                          height: 30,
                        ),
                        SizedBox(width: 8,),
                        Text(
                          translate('item_detail.des_loc'),
                          style:
                          GoogleFonts.ptSerif(
                            color: ColorConstant.kGreenColor,
                            fontSize: 20,

                          ),
                        ),
                      ],),
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 15,
                            top: 10,
                            bottom: 20,
                          ),
                          child:

                          SelectableText(
                            house.ftLage.toString(),
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.ptSerif(
                              fontSize: 15,
                              color: ColorConstant.kGreyColor,
                            ),
                          ),



                        )),
                  ],
                )

              ),

              Visibility(

                visible:house.ftAusstattBeschr!=""?true:false ,
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,

                            top:10,
                          ),
                          child: Row(children: [
                            Container(color: ColorConstant.kGreenColor,
                              width: 6,
                              height: 30,
                            ),
                            SizedBox(width: 8,),
                            Text(
                              translate('item_detail.furni'),
                              style:
                              GoogleFonts.ptSerif(
                                color: ColorConstant.kGreenColor,
                                fontSize: 20,

                              ),
                            ),
                          ],),
                        ),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 15,
                                top: 10,
                                bottom: 20,
                              ),
                              child:

                              SelectableText(
                                house.ftAusstattBeschr!=null? house.ftAusstattBeschr.toString():"",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.ptSerif(
                                  fontSize: 15,
                                  color: ColorConstant.kGreyColor,
                                ),
                              ),



                            )),
                      ],
                    )

              ),

              Visibility(

                visible:house.zaEpPrimaerenergietraeger==null&&house.zaEpEndenergiebedarf==null&&house.zaEpWertklasse==null&&house.zaEpGueltigBis==null?false:true,
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,

                            top:10,
                          ),
                          child: Row(children: [
                            Container(color: ColorConstant.kGreenColor,
                              width: 6,
                              height: 30,
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                              child: Text(
                                translate('item_detail.cer_energy'),
                                style:
                                GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,
                                  fontSize: 20,

                                ),
                              ),
                            ),
                          ],),
                        ),
                        Visibility(
                          visible:house.zaEpPrimaerenergietraeger==null?false:house.zaEpPrimaerenergietraeger==""?false:house.zaEpPrimaerenergietraeger=="0.00"?false:true ,


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38,
                                  right: 15,

                                  top:10,
                                ),
                                child: Row(
                                  children: [

                                    Text(
                                      translate('item_detail.primry_energy')+": ",
                                      style: GoogleFonts.ptSerif(
                                        fontSize: 16,
                                        color: ColorConstant.kGreyColor,
                                      ),
                                    ),
                                    Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            right: 15,


                                          ),
                                          child:
                                          SelectableText(
                                            house.zaEpPrimaerenergietraeger!=null? house.zaEpPrimaerenergietraeger.toString():"",
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.ptSerif(
                                              fontSize: 16,
                                              color:ColorConstant.kGreenColor,

                                            ),
                                          ),




                                        )),



                                  ],
                                ),
                              ),
                            ],),
                        ),
                        Visibility(
                          visible:house.zaEpEndenergiebedarf==null?false:house.zaEpEndenergiebedarf==""?false:house.zaEpEndenergiebedarf=="0.00"?false:true ,


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38,
                                  right: 15,

                                  top:10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      translate('item_detail.energy_con')+": "+"",
                                      style: GoogleFonts.ptSerif(
                                        fontSize: 16,
                                        color: ColorConstant.kGreyColor,
                                      ),
                                    ),






                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                left: 38,
                                right: 15,
                                top:2,
                              ),
                                child: SelectableText(
                                  house.zaEpEndenergiebedarf!=null? "${house.zaEpEndenergiebedarf.toString()+" kWh/m\u00B2.a"}":"",

                                  style: GoogleFonts.ptSerif(
                                    fontSize: 16,
                                    color:ColorConstant.kGreenColor,

                                  ),
                                ),
                              ),
                            ],),
                        ),
                        Visibility(
                          visible:house.zaEpWertklasse==null?false:house.zaEpWertklasse==""?false:house.zaEpWertklasse=="0.00"?false:true ,


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38,
                                  right: 15,

                                  top:10,
                                ),
                                child: Row(
                                  children: [

                                    Text(
                                      translate('item_detail.value_class')+": "+" ",
                                      style: GoogleFonts.ptSerif(
                                        fontSize: 16,
                                        color: ColorConstant.kGreyColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(

                                              right: 15,


                                            ),
                                            child:
                                            SelectableText(
                                              house.zaEpWertklasse!=null? house.zaEpWertklasse.toString():"",
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.ptSerif(
                                                fontSize: 16,
                                                color:ColorConstant.kGreenColor,

                                              ),
                                            ),




                                          )),
                                    ),



                                  ],
                                ),
                              ),
                            ],),
                        ),
                        Visibility(
                          visible:house.zaEpGueltigBis==null?false:house.zaEpGueltigBis==""?false:house.zaEpGueltigBis=="0.00"?false:true ,


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 38,
                                  right: 15,

                                  top:10,
                                ),
                                child: Row(
                                  children: [

                                    SelectableText(
                                      translate('item_detail.energy_until')+" ",
                                      style: GoogleFonts.ptSerif(
                                        fontSize: 16,
                                        color: ColorConstant.kGreyColor,
                                      ),
                                    ),
                                    Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            right: 15,


                                          ),
                                          child:
                                          SelectableText(
                                            house.zaEpGueltigBis!=null? house.zaEpGueltigBis.toString():"",
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.ptSerif(
                                              fontSize: 16,
                                              color:ColorConstant.kGreenColor,

                                            ),
                                          ),




                                        )),



                                  ],
                                ),
                              ),
                            ],),
                        ),

                    ],)

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: house.ktTelZentrale!=null?true:false,
                    child: GestureDetector(
                        onTap: (){
                          FlutterPhoneDirectCaller.callNumber('${house.ktTelZentrale}');
                          //UrlLauncher.launch('tel:${house.ktTelZentrale}');
                        },
                        child: _callButton()),
                  ),
                  GestureDetector(
                      onTap: (){

                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => RequestSend()));
                      },
                      child: _submitButton()),
                ],

              )
            ],
          ),
        ),
        ],)
    );

  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _submitButton() {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 8),
      width: 150,
      margin: EdgeInsets.only(top:10,bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xffff345f4f)
      ),
      child: Text(
        translate('item_detail.req'),
        style:    GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }
  Widget _callButton() {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(top:10,bottom: 10,right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xffff345f4f)
      ),
      child: Text(
        translate('item_detail.call'),
        style:    GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }
}

_launchURL(String url1) async {
  String url = url1;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
// TranslationWidget(
// message: house.ftObjektbeschreibung.toString(),
// toLanguage:  language1,
// builder: (translatedMessage) =>      Text(
// translatedMessage,
// textAlign: TextAlign.justify,
// style: GoogleFonts.ptSerif(
// fontSize: 15,
// color: ColorConstant.kGreyColor,
// ),
// ),
// ),