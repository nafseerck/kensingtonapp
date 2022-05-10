import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/SaveSearchModel.dart';

import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/AddSaveSearch.dart';
import 'package:kensington/pages/savesearchpages/EditSearch/EditNormalSearch.dart';
import 'package:kensington/pages/savesearchpages/SaveLandingPage.dart';
import 'package:kensington/pages/search/SearchListingPage.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translation_widget.dart';
import 'package:kensington/transalation/translations.dart';
import 'package:kensington/utils/ColorLoader3.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:kensington/utils/cus_widget/image_widget.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SaveSearch extends StatefulWidget {
  String saveserchfrom;

  SaveSearch({Key key, this.saveserchfrom}) : super(key: key);

  @override
  SearchListingPageState createState() => SearchListingPageState();
}

class SearchListingPageState extends State<SaveSearch> {
  Map<dynamic, dynamic> data;
  List result;

  SaveSearchModel _saveSearchModel;
  List<Result> savesearchlist;

  int counter = 0;

  Future gersearchresult() async {
    Provider.of<LoginProvider>(context, listen: false)
        .saved_result()
        .then((value) {
      if (value) {
        if (mounted) {
          setState(() {
            _saveSearchModel =
                Provider.of<LoginProvider>(context, listen: false)
                    .getsaveresult();
            if (_saveSearchModel.status == "success") {
              savesearchlist = _saveSearchModel.result;

             // print("priceto${savesearchlist[0].priceFrom}");
            }
          });
        }
      }
    });
  }

  FavModel user;

  void _deleteSaveSearch(property_id, BuildContext context, int index) {
    Provider.of<LoginProvider>(context, listen: false)
        .deltete_search(property_id)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if (user.status == "success") {
          Navigator.of(context).pop();
          CustomWidget.showtoast(
              context, translate('save_search.search_deletetoast'));
          setState(() {
            savesearchlist.clear();
            savesearchlist = null;
            gersearchresult();
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
    main();
    gersearchresult();
    notif_arrived1();
  }

  @override
  void didUpdateWidget(covariant SaveSearch oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // if(savesearchlist!=null){
    //   savesearchlist.clear();
    //   gersearchresult();
    // }
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

  CountModel countModel;

  void getcount() {
    Provider.of<LoginProvider>(context, listen: false)
        .count_notification()
        .then((value) {
      if (value) {
        // DialogUtils.hideProgress(context);

        countModel =
            Provider.of<LoginProvider>(context, listen: false).getcount();
        if (countModel.status == "success") {
          setState(() {
            counter = countModel.propertyCount;
          });
        }
      }
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
      appBar: widget.saveserchfrom == "sidedrawer"
          ? CustomWidget.getappbar(context, counter)
          : null,
      body: Container(
          child: savesearchlist == null
              ? Align(
                  alignment: Alignment.center,
                  child: ColorLoader3(radius: 20.0, dotRadius: 6.0))
              : savesearchlist.length == 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomWidget.getheading1(
                                  translate('drawer_lng.save_search')),
                              IconButton(
                                  icon: new Icon(
                                    Icons.add,
                                    color: ColorConstant.kGreenColor,
                                    size: 38,
                                  ),
                                  onPressed: () {
                                    if (savesearchlist.length == 3) {
                                      CustomWidget.showtoast(context,
                                          translate('save_search.three_pref'));
                                    } else {
                                      _navigateAndDisplaySelection(context);
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 4),
                          alignment: Alignment.center,
                          child: Align(
                            child: Text(
                              translate('save_search.no_save'),
                              style: GoogleFonts.ptSerif(
                                  fontSize: 20,
                                  color: ColorConstant.kGreenColor),
                            ),
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomWidget.getheading1(
                                  translate('drawer_lng.save_search')),
                              IconButton(
                                  icon: new Icon(
                                    Icons.add,
                                    color: ColorConstant.kGreenColor,
                                    size: 38,
                                  ),
                                  onPressed: () {
                                    if (savesearchlist.length == 3) {
                                      CustomWidget.showtoast(context,
                                          translate('save_search.three_pref'));
                                    } else {
                                      _navigateAndDisplaySelection(context);
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 8,
                            ),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: savesearchlist.length,
                              // Add one more item for progress indicator
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:savesearchlist[index].countryId,region_name:savesearchlist[index].regionId,location_name:savesearchlist[index].locationName,looking_for:savesearchlist[index].lookingFor,property_type:savesearchlist[index].propertyType,fromwhere: "mainsearch",region_name_real: savesearchlist[index].regionName,)));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomWidget.getprefernceheading(
                                                translate(
                                                        'save_search.prefer') +
                                                    " " +
                                                    "${index + 1}"),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {

                          String _countryname;
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    String language1 = prefs.getString('language');

                                                    switch (language1) {
                                                      case 'en-GB':
                                                   if(savesearchlist[index]
                                                       .countryName=="Worldwide"){
_countryname="Worldwide";
                                                   }
                                                   else if(savesearchlist[index]
                                                       .countryName=="Germany"){
                                                     _countryname="Germany";
                                                   }
                                                   else if(savesearchlist[index]
                                                       .countryName=="Switzerland"){
                                                     _countryname="Switzerland";
                                                   }
                                                   else if(savesearchlist[index]
                                                       .countryName=="Spain"){
                                                     _countryname="Spain";
                                                   }
                                                        break;
                                                      case 'es-ES':
                                                        if(savesearchlist[index]
                                                            .countryName=="Wordwide"){
_countryname="En todo el mundo";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Germany"){
                                                          _countryname="Alemania";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Switzerland"){
                                                          _countryname="Suiza";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Spain"){
                                                          _countryname="España";
                                                        }
                                                        break;
                                                      case 'de-DE':
                                                        if(savesearchlist[index]
                                                            .countryName=="Wordwide"){
                                                          _countryname="Weltweit";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Germany"){
                                                          _countryname="Deutschland";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Switzerland"){
                                                          _countryname="Schweiz";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Spain"){
                                                          _countryname="Spanien";
                                                        }
                                                        break;
                                                      default:
                                                        if(savesearchlist[index]
                                                            .countryName=="Worldwide"){
                                                          _countryname="Worldwide";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Germany"){
                                                          _countryname="Germany";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Switzerland"){
                                                          _countryname="Switzerland";
                                                        }
                                                        else if(savesearchlist[index]
                                                            .countryName=="Spain"){
                                                          _countryname="Spain";
                                                        }
                                                        break;
                                                    }
                                                    final result = await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => EditNormalSearch(
                                                                save_id: savesearchlist[index]
                                                                    .id,
                                                                counryid: savesearchlist[index]
                                                                    .countryId,
                                                                counryname: _countryname,
                                                                regionnid: savesearchlist[index]
                                                                    .regionId,
                                                                regionname: savesearchlist[index]
                                                                    .regionName,
                                                                lookingforid: savesearchlist[index]
                                                                    .lookingFor,
                                                                loactionname: savesearchlist[index].locationName == "0"
                                                                    ? "All"
                                                                    : savesearchlist[index]
                                                                        .locationName,
                                                                propertyid: savesearchlist[index]
                                                                    .propertyType,
                                                                propertyname:
                                                                    savesearchlist[index]
                                                                        .propertyTypeName,
                                                                lookingforname:
                                                                    savesearchlist[index].lookingForName,
                                                                plotsizefrom: savesearchlist[index].plotSizeFrom,
                                                                plotsizto: savesearchlist[index].plotSizeTo,
                                                                livingfrom: savesearchlist[index].livingSpaceFrom,
                                                                livingto: savesearchlist[index].livingSpaceTo,
                                                                roomfrom: savesearchlist[index].roomsFrom,
                                                                roomto: savesearchlist[index].roomsTo,
                                                                bedfrom: savesearchlist[index].bedroomFrom,
                                                                bedto: savesearchlist[index].bedroomTo,
                                                                batfrom: savesearchlist[index].bathroomFrom,
                                                                bathto: savesearchlist[index].bathroomTo,
                                                                pricefrom: savesearchlist[index].priceFrom,
                                                                priceto: savesearchlist[index].priceTo,
                                                                terrace: savesearchlist[index].terrace,
                                                                aircondition: savesearchlist[index].airCondition,
                                                                swiming: savesearchlist[index].swimmingPool,
                                                                seaview: savesearchlist[index].seaView,
                                                            araename:savesearchlist[index]
                                                                .areaName ==
                                                                null?"":savesearchlist[index].areaName,
                                                                areaid:savesearchlist[index].areaId==
                                                            null?"-1":savesearchlist[index].areaId
                                                            )));

                                                    if (result ==
                                                        "savesearch!") {
                                                      if (savesearchlist !=
                                                          null) {
                                                        savesearchlist.clear();
                                                        savesearchlist = null;
                                                        setState(() {
                                                          gersearchresult();
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Text(
                                                    translate(
                                                            'save_search.edit') +
                                                        " / ",
                                                    style: GoogleFonts.ptSerif(
                                                        fontSize: 15,
                                                        color: ColorConstant
                                                            .kGreyColor),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showAlertDialog(
                                                        savesearchlist[index]
                                                            .id,
                                                        context,
                                                        index);
                                                  },
                                                  child: Text(
                                                    translate(
                                                        'save_search.delet'),
                                                    style: GoogleFonts.ptSerif(
                                                        fontSize: 15,
                                                        color: ColorConstant
                                                            .kGreyColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        new Container(
                                          margin: EdgeInsets.only(
                                              bottom: 5, top: 2),
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                              //  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              color: ColorConstant.saveback),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CustomWidget.getTextmedium(
                                                            translate(
                                                                    'save_search.country_save') +
                                                                ": "),
                                                        TranslationWidget(
                                                          message:  savesearchlist[
                                                          index].countryName,
                                                          toLanguage: language1,
                                                          builder:
                                                              (translatedMessage) =>
                                                                  CustomWidget
                                                                      .getTextmedium(
                                                                      translatedMessage
                                                                     ),

                                                        ),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomWidget
                                                              .getTextmedium(
                                                                  translate(
                                                                          'save_search.region_save') +
                                                                      "  : "),
                                                          TranslationWidget(
                                                            message:   savesearchlist[
                                                            index]
                                                                .regionName,
                                                            toLanguage: language1,
                                                            builder:
                                                                (translatedMessage) =>
                                                                CustomWidget
                                                                    .getTextmedium(
                                                                    translatedMessage
                                                                ),

                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                                    Row(

                                                      children: [
                                                        CustomWidget.getTextmedium(
                                                            translate(
                                                                    'save_search.location_save') +
                                                                ": "),


                                                        savesearchlist[index]
                                                            .locationName ==
                                                            "0"?
                                                        CustomWidget.getTextmedium(
                                                            translate(
                                                                'landing_screen.all') +
                                                                    ", "
                                                                ): 
                                                        Expanded(
                                                          child: TranslationWidget(
                                                            message:  savesearchlist[
                                                            index]
                                                                .locationName,
                                                            toLanguage: language1,
                                                            builder:
                                                                (translatedMessage) =>
                                                                CustomWidget
                                                                    .getTextmedium(
                                                                    translatedMessage
                                                                ),

                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [

                                                      CustomWidget
                                                          .getTextmedium(
                                                          translate(
                                                              'save_search.lokking_forsave') +
                                                              ": "),
                                                      savesearchlist[index]
                                                          .lookingForName ==
                                                          "0"?
                                                      CustomWidget.getTextmedium(
                                                          translate(
                                                              'landing_screen.all') +
                                                              ", "
                                                      ): TranslationWidget(
                                                        message:  savesearchlist[
                                                        index]
                                                            .lookingForName,
                                                        toLanguage: language1,
                                                        builder:
                                                            (translatedMessage) =>
                                                            CustomWidget
                                                                .getTextmedium(
                                                                translatedMessage
                                                            ),

                                                      ),

                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(

                                              children: [
                                                CustomWidget.getTextmedium(
                                                    translate(
                                                            'save_search.pro_save') +
                                                        ": "),
                                                savesearchlist[index]
                                                    .propertyTypeName ==
                                                    "0"?
                                                CustomWidget.getTextmedium(
                                                    translate(
                                                        'landing_screen.all') +
                                                        ", "
                                                ): TranslationWidget(
                                                  message:  savesearchlist[
                                                  index]
                                                      .propertyTypeName,
                                                  toLanguage: language1,
                                                  builder:
                                                      (translatedMessage) =>
                                                      CustomWidget
                                                          .getTextmedium(
                                                          translatedMessage
                                                      ),

                                                ),
                                                SizedBox(width: 4,),
                                                CustomWidget.getTextmedium(
                                                    translate(
                                                        'save_search.araa_save') +
                                                        ": "),
                                                savesearchlist[index]
                                                    .areaName ==
                                                    null?
                                              "": savesearchlist[index]
                                                    .areaName ==
                                                    "0"?  CustomWidget.getTextmedium(
                                                    translate(
                                                        'landing_screen.all') +
                                                        ", "
                                                ): Expanded(
                                                  child: TranslationWidget(
                                                    message:  savesearchlist[
                                                    index]
                                                        .areaName,
                                                    toLanguage: language1,
                                                    builder:
                                                        (translatedMessage) =>
                                                        CustomWidget
                                                            .getTextmedium(
                                                            translatedMessage
                                                        ),

                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Visibility(
                                                      visible: savesearchlist[
                                                                      index]
                                                                  .plotSizeFrom ==
                                                              "All"
                                                          ? false
                                                          : true,
                                                      child: Row(
                                                        children: [
                                                          CustomWidget.getTextsmall(
                                                              translate(
                                                                      'item_detail.plotsize') +
                                                                  ": "),
                                                          CustomWidget.getTextsmall(
                                                              savesearchlist[
                                                                          index]
                                                                      .plotSizeFrom +
                                                                  "-" +
                                                                  savesearchlist[
                                                                          index]
                                                                      .plotSizeTo +
                                                                  " m\u00B2"),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child:
                                                      Visibility(
                                                        visible: savesearchlist[
                                                                        index]
                                                                    .livingSpaceFrom ==
                                                                "All"
                                                            ? false
                                                            : true,
                                                        child: Row(
                                                          children: [
                                                            CustomWidget
                                                                .getTextsmall(
                                                                    translate(
                                                                            'item_detail.living_area') +
                                                                        ": "),
                                                            CustomWidget.getTextsmall(savesearchlist[
                                                                        index]
                                                                    .livingSpaceFrom +
                                                                "-" +
                                                                savesearchlist[
                                                                        index]
                                                                    .livingSpaceTo +
                                                                " m\u00B2"),
                                                          ],
                                                        ),
                                                      )

                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Visibility(
                                                      visible: savesearchlist[
                                                                      index]
                                                                  .roomsFrom ==
                                                              "All"
                                                          ? false
                                                          : true,
                                                      child: Row(
                                                        children: [
                                                          CustomWidget.getTextsmall(
                                                              translate(
                                                                      'advance_search.Rooms') +
                                                                  ": "),
                                                          CustomWidget.getTextsmall(
                                                              savesearchlist[
                                                                          index]
                                                                      .roomsFrom +
                                                                  "-" +
                                                                  savesearchlist[
                                                                          index]
                                                                      .roomsTo),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Column(
                                                    children: [
                                                      Visibility(
                                                        visible: savesearchlist[
                                                                        index]
                                                                    .bedroomFrom ==
                                                                "All"
                                                            ? false
                                                            : true,
                                                        child: Row(
                                                          children: [
                                                            CustomWidget
                                                                .getTextsmall(
                                                                    translate(
                                                                            'advance_search.bedroom') +
                                                                        ": "),
                                                            CustomWidget.getTextsmall(savesearchlist[
                                                                        index]
                                                                    .bedroomFrom +
                                                                "-" +
                                                                savesearchlist[
                                                                        index]
                                                                    .bedroomTo),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Visibility(
                                                      visible: savesearchlist[
                                                                      index]
                                                                  .bathroomFrom ==
                                                              "All"
                                                          ? false
                                                          : true,
                                                      child: Row(
                                                        children: [
                                                          CustomWidget.getTextsmall(
                                                              translate(
                                                                      'advance_search.bathroom') +
                                                                  ": "),
                                                          CustomWidget.getTextsmall(
                                                              savesearchlist[
                                                                          index]
                                                                      .bathroomFrom +
                                                                  "-" +
                                                                  savesearchlist[
                                                                          index]
                                                                      .bathroomTo),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Column(
                                                    children: [
                                                      Visibility(
                                                        visible: savesearchlist[
                                                                        index]
                                                                    .priceFrom ==
                                                                "All"
                                                            ? false
                                                            : true,
                                                        child: Row(
                                                          children: [
                                                            CustomWidget
                                                                .getTextsmall(
                                                                    translate(
                                                                            'advance_search.price') +
                                                                        ": "),
                                                            CustomWidget.getTextsmall(
                                                               savesearchlist[
                                                                        index]
                                                                    .priceFrom+"-"+ savesearchlist[index]
                                                                .priceTo+ " €"),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomWidget.getTextsmall(translate(
                                                        'save_search.search_save') +
                                                    ": "),
                                                CustomWidget.getTextsmall(
                                                    savesearchlist[index]
                                                        .createdAt),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ));
                              },
                            )),
                      ],
                    )),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SaveLandingPage()));

    if (result == "savesearch!") {
      if (savesearchlist != null) {
        savesearchlist.clear();
        savesearchlist = null;
        setState(() {
          gersearchresult();
        });
      }
    }
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
  _navigateEdit(BuildContext context, saveid) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                EditNormalSearch(save_id: saveid)));

    if (result == "savesearch!") {
      if (savesearchlist != null) {
        savesearchlist.clear();
        savesearchlist = null;
        setState(() {
          gersearchresult();
        });
      }
    }
  }

  showAlertDialog(p_id, BuildContext context, position) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(translate('drawer_lng.no'),
          style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor)
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        translate('drawer_lng.yes'),
        style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor)
      ),
      onPressed: () {
        Provider.of<LoginProvider>(context, listen: false).setLoading(true);
        if (Provider.of<LoginProvider>(context, listen: false).isLoading()) {
          DialogUtils.showProgress(context);
          _deleteSaveSearch(p_id, context, position);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(translate('drawer_lng.confirm'),
          style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor)
      ),
      content: Text(translate('save_search.conf'),
          style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor)
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
