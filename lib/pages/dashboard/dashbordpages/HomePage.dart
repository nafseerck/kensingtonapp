import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/All_Country_Model.dart';
import 'package:kensington/model/AreaModel.dart';
import 'package:kensington/pages/search/SearchListingPage.dart';
import 'package:kensington/pages/search/advancesearch/AdavanceSearch2.dart';

import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translation_widget.dart';
import 'package:kensington/transalation/translations.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/cus_widget/MultiSelectDialogItem.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:kensington/utils/model/CityModel.dart';
import 'package:kensington/utils/model/CountryModelModel.dart';
import 'package:kensington/utils/model/LocationModel.dart';
import 'package:kensington/utils/model/PropertyModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:flutter_translate/flutter_translate.dart';
class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GlobalKey _drawerKey = GlobalKey();
 // String country = 'WorldWide';
  List<Result> countrylist ;
  PreferencesApp bloc;
bool _areadropdown=false;
  Set<int> selectedval;
  Set<int> selectedvalarea;
  Set<int> selectedvalueproperty;

  List common=[] ;
  Map<int, String> basicMap ,araemap,propertymap;
  List <MultiSelectDialogItem<int>> multiItem = List();
  List <MultiSelectDialogItem<int>> areamultiItem = List();

  TextEditingController searchquick = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<StateModel> state_model_list = new List<StateModel>();
  static List<CityModel> citymodel_list = new List<CityModel>();
  static List<PropertyModel> property_list = new List<PropertyModel>();
  static List<AreaModel> areamodel_list = new List<AreaModel>();
  static List<LookingForModel> looking_list1 = new List<LookingForModel>();
  List<String> country_list = [];
  List<String> region_list = [];
  List<String> looking_list = [];
  List<String> areaids = [];
  var  location_name_multiple=[];
  var  location_multiple_for_notsel=[];
  var  area_name_multiple=[];
  var  property_name_multiple=[];
  var  property_ids_multiple=[];
  var  area_ids_multiple=[];
  List<String> propertytype_list = [];
  List<String> loactionnamemultiple = [];

  List<String> loactionnamemultipleforarea = [];
  List<String> areanamesmultiple = [];
  List<String> propertymultiple = [];
  List <MultiSelectDialogItem<int>> propertymultiitems = List();
  List<DropdownMenuItem<String>> counrtynames = [];
  List<DropdownMenuItem<String>> lookingforname = [];
  List<DropdownMenuItem<String>> propertynames = [];
  List<DropdownMenuItem<String>> rigionnames = [];
  List<DropdownMenuItem<String>> locationnames = [];
  List<DropdownMenuItem<String>> areanames = [];
  final translator = GoogleTranslator();
  String selectedStateID="1",selectdregionId="-1",selectedlokkingfor="-1",selectedpropertid="-1",selectedareaid="-1";
  String selectcountry = null,selectregion=null,selectlookingfor=null,selectproperty=null,selectlocation=null,selectarea=null,selectlocation1=null;
  String selectcountry1 = null;
  AllCountryModel allCountryModel;

  Future getcountry () async{

    state_model_list.clear();


    Provider.of<LoginProvider>(context, listen: false)
        .fetchCountry()
        .then((value) {
      if (value) {
        if (mounted) {

          setState(() {
            if(country_list!=null){

               country_list.clear();



            }
            if( countrylist!=null){

                countrylist.clear();

            }
            allCountryModel =
                Provider.of<LoginProvider>(context, listen: false).getcountry();
            if (allCountryModel.status == "success") {
              countrylist = allCountryModel.result;


              for (int i = 0; i < countrylist.length; i++) {

                country_list.add(countrylist[i].name);

                String ID = countrylist[i].id;
                String NAME = countrylist[i].name;
                state_model_list.add(new StateModel(ID, NAME));

              }
            }
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
  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  Future get_lookingfor () async{
    looking_list1.clear();
    if(looking_list!=null){
      if(looking_list.length>0){
        looking_list.clear();
      }


    }
    Provider.of<LoginProvider>(context, listen: false)
        .fetch_lookingfor()
        .then((value) {
      if (value) {
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {
            countrylist=allCountryModel.result;

            lookingforname=[];
            for (int i = 0; i < countrylist.length; i++) {
              looking_list.add(countrylist[i].name);
              String ID = countrylist[i].id;
              String NAME = countrylist[i].name;
              looking_list1.add(new LookingForModel(ID, NAME));

              // lookingforname.add(new DropdownMenuItem(
              //   child: new Text(countrylist[i].name),
              //   value: countrylist[i].id,
              // ));
            }
          }
        });


      }
    });
  }
  Future getarea () async{
    if(areanames!=null){
      if(areanames.length>0){

        areanames.clear();
       // areanamesmultiple.clear();
      }


    }
    if(areamodel_list!=null){
      if(areamodel_list.length>0){
        areamodel_list.clear();
      }




    }
    Provider.of<LoginProvider>(context, listen: false)
        .all_area()
        .then((value) {
      if (value) {
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {
            countrylist=allCountryModel.result;

            areanames=[];
            for (int i = 0; i < countrylist.length; i++) {
              areanamesmultiple.add(countrylist[i].name);
              String ID = countrylist[i].id;
              String NAME = countrylist[i].name;
              areamodel_list.add(new AreaModel(ID, NAME));
              // locationnames.add(new DropdownMenuItem(
              //   child: new Text(countrylist[i].name),
              //   value: countrylist[i].name,
              // )
              // );
            }
          }
        });


      }
    });
  }
  Future get_property () async{
    if(propertytype_list!=null){
      if(propertytype_list.length>0){
        propertytype_list.clear();
      }

      if(propertymultiple.length!=0){
        propertymultiple.clear();
      }


    }
    if(property_list!=null){
      if(property_list.length>0){
        property_list.clear();
      }




    }

    Provider.of<LoginProvider>(context, listen: false)
        .fetch_property(selectedStateID)
        .then((value) {
      if (value) {
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {
            countrylist=allCountryModel.result;

            for (int i = 0; i < countrylist.length; i++) {
              propertymultiple.add(countrylist[i].name);

              // propertytype_list.add(countrylist[i].name);
              String ID = countrylist[i].id;
              String NAME = countrylist[i].name;
               property_list.add(new PropertyModel(ID, NAME));

              // rigionnames.add(new DropdownMenuItem(
              //   child: new Text(countrylist[i].name),
              //   value: countrylist[i].id,
              // ));
            }
            // for (int i = 0; i < countrylist.length; i++) {
            //
            //
            //   propertynames.add(new DropdownMenuItem(
            //     child: new Text(countrylist[i].name),
            //     value: countrylist[i].name,
            //   ));
            // }
          }
        });
      }
    });
  }
  Future getregion (c_id) async{
    Provider.of<LoginProvider>(context, listen: false)
        .region(c_id)
        .then((value) {
      if (value) {
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {

             countrylist=allCountryModel.result;

             rigionnames=[];
             for (int i = 0; i < countrylist.length; i++) {

               region_list.add(countrylist[i].name);
               String ID = countrylist[i].id;
               String NAME = countrylist[i].name;
               citymodel_list.add(new CityModel(ID, NAME));
               // rigionnames.add(new DropdownMenuItem(
               //   child: new Text(countrylist[i].name),
               //   value: countrylist[i].id,
               // ));
             }
             get_property();
          }
        });


      }
    });
  }
  Future getlocationforarea (regionid) async{

    //print(selectedvalarea.intersection(allareas));

    if(locationnames!=null){
      if(locationnames.length>0){
        locationnames.clear();
       // loactionnamemultiple.clear();
      }


    }
    if(loactionnamemultiple.length!=0){
      loactionnamemultiple.clear();
    }
    if(location_name_multiple.length!=0){
      location_name_multiple.clear();
    }
    if(location_multiple_for_notsel.length!=0){
      location_multiple_for_notsel.clear();
    }
    Provider.of<LoginProvider>(context, listen: false)
        .all_locationforarea(selectedStateID,regionid,selectedareaid)
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {
            countrylist=allCountryModel.result;

            locationnames=[];
            for (int i = 0; i < countrylist.length; i++) {
              loactionnamemultiple.add(countrylist[i].name);
            }
            for (int i = 0; i < loactionnamemultiple.length; i++){
              location_multiple_for_notsel.add("'${loactionnamemultiple[i]}'");

            }

            selectlocation1= location_multiple_for_notsel.join(",").toString();


          }
        });


      }
    });
  }
  Future getlocation (regionid) async{

    if(locationnames!=null){
      if(locationnames.length>0){
        locationnames.clear();
       // loactionnamemultiple.clear();
      }


    }

    if(loactionnamemultiple.length!=0){
      loactionnamemultiple.clear();
    }


    Provider.of<LoginProvider>(context, listen: false)
        .all_location(selectedStateID,regionid)
        .then((value) {
      if (value) {
        setState(() {
          allCountryModel = Provider.of<LoginProvider>(context, listen: false).getcountry();
          if (allCountryModel.status == "success") {
            countrylist=allCountryModel.result;

            locationnames=[];
            for (int i = 0; i < countrylist.length; i++) {
              loactionnamemultiple.add(countrylist[i].name);

              // locationnames.add(new DropdownMenuItem(
              //   child: new Text(countrylist[i].name),
              //   value: countrylist[i].name,
              // )
              // );
            }
          }
        });


      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

     selectedStateID="1";selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";selectedareaid="-1";
     selectcountry = null;selectregion=null;selectlookingfor=null;selectproperty=null;selectlocation=null;selectarea=null;
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

   // mainlangselection();
  }
  Future<void> mainlangselection ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isselected = prefs.getBool('isselected');

    if(isselected){

      if(country_list!=null){

        country_list.clear();
        selectedStateID="1";selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";selectedareaid="-1";
        selectcountry = null;
        selectregion=null;
        selectlocation=null;
        selectlocation1=null;
        selectlookingfor=null;
        selectproperty=null;
        selectarea=null;
       setState(() {
         _areadropdown = false;
       });
        await getcountry();
        get_property();
        get_lookingfor();
      }
      if(region_list!=null){
        if(region_list.length>0){
          region_list.clear();
          citymodel_list.clear();
        }
      }

      bloc = Provider.of<LoginProvider>(context,listen: false).bloc;
      bloc.langSelected(false);
    }
  }
  //
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   print("jkhkjgkg");
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //main();

    if(country_list!=null){
      country_list.clear();
      //selectedStateID="-1";selectdregionId="-1";selectedlokkingfor="-1";
      selectcountry = null;
      selectregion=null;
      selectlocation=null;
      selectlocation1=null;
      selectlookingfor=null;
      selectproperty=null;
      selectarea=null;
       getcountry();
    }
    showDemoActionSheet();
    //selectcountry = country_list[0];
    // if(country_list!=null){
    //   country_list.clear();
    //   selectedStateID="-1";selectdregionId="-1";selectedlokkingfor="-1";
    //   selectcountry = null;
    //   selectregion=null;
    //   selectlocation=null;
    //   selectlookingfor=null;
    //   selectproperty=null;
    //   getcountry();
    // }
    get_lookingfor();
  get_property();



  }

  void _showMultiSelect(BuildContext context) async {


    multiItem = [];

    basicMap=loactionnamemultiple.asMap();

    populateMultiselect();

    final items = multiItem;


    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selectedval,
        );
      },
    );


    getvaluefromkey(selectedValues);
  }
  void _showMultiSelectarea(BuildContext context) async {
    areamultiItem = [];


    araemap=areanamesmultiple.asMap();

    populateMultiselectarea();

    final items = areamultiItem;


    final selectedValues =
    await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selectedvalarea,
        );
      },
    );


    getvaluefromkeyarea(selectedValues);
  }
  void _showMultiSelectProperty(BuildContext context) async {
    propertymultiitems = [];


    propertymap=propertymultiple.asMap();

    populateMultiselectproperty();

    final items = propertymultiitems;


    final selectedValues =
    await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selectedvalueproperty,
        );
      },
    );


    getvaluefromkeyproperty(selectedValues);
  }
  void populateMultiselect(){
    for(int v in basicMap.keys){
      multiItem.add(MultiSelectDialogItem(v, basicMap[v]));
    }
  }
  void populateMultiselectarea(){
    for(int v in araemap.keys){
      areamultiItem.add(MultiSelectDialogItem(v, araemap[v]));
    }
  }
  void populateMultiselectproperty(){
    for(int v in propertymap.keys){
      propertymultiitems.add(MultiSelectDialogItem(v, propertymap[v]));
    }
  }
  void getvaluefromkey(Set selection){
    selectedval=selection;
    if(selection != null){
      for(int x in selection.toList()){

        location_name_multiple.add("'${basicMap[x]}'");
      }

      setState(() {
        selectlocation=location_name_multiple.join(",").toString();
       // print("clickede9"+s);
      });

    }
  }
  void getvaluefromkeyarea(Set selection){
    selectedvalarea=selection;
    if(selection != null){
      for(int x in selection.toList()){

        area_name_multiple.add("'${araemap[x]}'");
        area_ids_multiple.add("'${ areamodel_list[x].ID}'");
      }
      setState(() {
        selectarea=area_name_multiple.join(",").toString();
        selectedareaid =area_ids_multiple.join(",").toString();
        if (selectdregionId == '-1') {

        } else {

          if(loactionnamemultiple.length!=0){
            loactionnamemultiple.clear();
            Provider.of<LoginProvider>(context, listen: false)
                .setLoading(true);
            if( Provider.of<LoginProvider>(context, listen: false)
                .isLoading()){
              DialogUtils.showProgress(context);
              getlocationforarea(selectdregionId);

            }

          }
          else{
            Provider.of<LoginProvider>(context, listen: false)
                .setLoading(true);
            if( Provider.of<LoginProvider>(context, listen: false)
                .isLoading()){
              DialogUtils.showProgress(context);

              getlocationforarea(selectdregionId);

            }
          }

        }
      });
    }
  }
  void getvaluefromkeyproperty(Set selection){
    selectedvalueproperty=selection;
    if(selection != null){
      for(int x in selection.toList()){

        property_name_multiple.add("'${propertymap[x]}'");
        property_ids_multiple.add("'${ property_list[x].ID}'");
        //dropDownPropertySelected(x);
      }
      setState(() {
        selectproperty=property_name_multiple.join(",").toString();
        selectedpropertid =property_ids_multiple.join(",").toString();

      });
    }
  }
  void dropDownStateSelected(String newValueSelected, int index) {
    setState(() {
     selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";
      selectregion=null;selectlocation=null;selectproperty=null;selectarea=null;selectlocation1=null;
      this.selectedStateID = state_model_list[index].ID;

      if (selectedStateID == '-1') {
      } else {
       setState(() {
         _areadropdown = false;
         region_list.clear();
         citymodel_list.clear();
         getregion(selectedStateID);

       });
      }

    });
  }
  void dropDownregionSelected(String newValueSelected, int index) {
    setState(() {

      this.selectdregionId = citymodel_list[index].ID;

      if (selectdregionId == '-1') {
      } else {


        getlocation(selectdregionId);
      }
      // this.currentStateSelected = newValueSelected;
    });
  }
  void dropDownregionSelectedforarea(String newValueSelected, int index) {
    setState(() {

      this.selectdregionId = citymodel_list[index].ID;



    });
  }
  void dropDownLookingSelected(String newValueSelected, int index) {
    setState(() {


      this.selectedlokkingfor = looking_list1[index].ID;


    });
  }
  void dropDownPropertySelected( int index) {

    property_ids_multiple.add("'${ property_list[index].ID}'");
    setState(() {

      selectedpropertid=property_ids_multiple.join(",").toString();
      this.selectedpropertid = property_list[index].ID;



    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
key:_scaffoldKey,
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Align(
            child: Image.asset(
              'assets/appicon/city.png',
            ),
            alignment: Alignment.bottomRight,
          ),
          ListView(children: [
            Align(
              child: Image.asset(

                'assets/appicon/logo.png',
                height: 50,

              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30,top: 15),
              padding: EdgeInsets.only( bottom: 6),
              child:   CustomWidget.textquick(translate('landing_screen.quick')),
            ),
            Container(
                height: 50,

              margin: EdgeInsets.only(left: 30, right: 50),
              padding: EdgeInsets.only(left: 15),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorConstant.saveback

                )
                ,
                child:
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                 children: [
                 Container(
                   width: MediaQuery.of(context).size.width * 0.5,
                   child: TextField(

                       controller: searchquick,
                       decoration: InputDecoration(
                         border: InputBorder.none,

                         hintText:translate('landing_screen.enterquick'),

                         hintStyle: TextStyle(
                             fontSize:14,
                             color: ColorConstant.edittextcolor,
                             fontFamily: "PTSerif"


                         ),
                       )
                   ),
                 ),
    InkWell(
      onTap: (){
        if(searchquick.text.isEmpty){
          CustomWidget.showtoast(
              context, translate('landing_screen.enterquick'));
        }
        else{
          _navigateAndquick(context);
        }
      },
      child: Container(
alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5),
        decoration: new BoxDecoration(
          color: ColorConstant.kGreenColor,
          border: new Border.all(
              color:  ColorConstant.kGreenColor,

              style: BorderStyle.solid),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(0.0),
          ),
        ),
   child:
 Row(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
   Text(translate('landing_screen.go'),style: GoogleFonts.ptSerif(fontSize: 16,color: Colors.white),),

    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
     
 ],),
      height: 50,


      ),
    ),
               ],)
              ),
            Container(
              margin: EdgeInsets.only(left: 60, right: 30,top: 3),

              child: Text("("+translate('landing_screen.that_is')+")",style: GoogleFonts.ptSerif(
                  color: ColorConstant.kGreyColor,fontSize: 13
              ) ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30,top: 3),

              child: new Divider(
                color: ColorConstant.kGreenColor,
                thickness: 0.7,
              ),
            ),
            // Text(translate('landing_screen.main_t'),textAlign: TextAlign.center,style: GoogleFonts.ptSerif(
            //     color: ColorConstant.kGreyColor,fontSize: 13
            // ) ),
            Container(
              child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
              children: [
    Container(
    margin: EdgeInsets.only(left: 30, right: 30,top: 1),
      padding: EdgeInsets.only( bottom: 6),
      child:   CustomWidget.getTextsmall(translate('landing_screen.country')),
    ),

              Container(
                height: 50,
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xfffff0eff5)
                  ),
                child:
                DropdownButtonHideUnderline(

                  child: DropdownButton(
                      isExpanded: true,
                      value: selectcountry,
                      hint:Text(translate('landing_screen.world'),style: GoogleFonts.ptSerif(
                          color: ColorConstant.kGreenColor,fontSize: 18
                      ),),
                        items: country_list.map((String value) {
    return DropdownMenuItem<String>(
    value: value,

    child:


    Text(
      value,
      style: GoogleFonts.ptSerif(
          color: ColorConstant.kGreenColor,fontSize: 18),
    ),
    );
    }).toList(),
                      underline: SizedBox(),

                      icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                      iconSize: 38,

                      style:

                      GoogleFonts.ptSerif(
    color: ColorConstant.kGreenColor,fontSize: 18

    ),
                      onChanged: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                       // main();
                        selectcountry=value;
                 setState(() {
                   dropDownStateSelected(value,
                       country_list.indexOf(value));
                 });


                      }
                  ),),
              ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                  padding: EdgeInsets.only( bottom: 6),
                  child:   CustomWidget.getTextsmall(translate('landing_screen.region')),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 30, right: 30),
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xfffff0eff5)
                  ),
                  child:
                  DropdownButtonHideUnderline(

                    child: DropdownButton(
                        isExpanded: true,
                        value: selectregion,
                        hint:Text(translate('landing_screen.all'),style: GoogleFonts.ptSerif(
                            color: ColorConstant.kGreenColor,fontSize: 18
                        ),),
                        items: region_list.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,

                            child: Text(
                              value,
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,fontSize: 18),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),

                        icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                        iconSize: 38,

                        style:

                        GoogleFonts.ptSerif(
                            color: ColorConstant.kGreenColor,fontSize: 18
                        ),
                        onChanged: (value) {

                          FocusScope.of(context).requestFocus(FocusNode());
                          selectregion=value;
                         setState(() {
                           if(selectregion=="Mallorca"){
                             _areadropdown=true;

                             if(areanamesmultiple.length!=0){
                               areanamesmultiple.clear();
                               getarea();
                               dropDownregionSelectedforarea(value,
                                   region_list.indexOf(value));

                             }
                             else{
                               getarea();
                               dropDownregionSelectedforarea(value,
                                   region_list.indexOf(value));
                             }

                           }
                           else{

                             _areadropdown=false;

                             if(loactionnamemultiple.length!=0){
                               loactionnamemultiple.clear();
                               dropDownregionSelected(value,
                                   region_list.indexOf(value));
                             }
                             else{
                               dropDownregionSelected(value,
                                   region_list.indexOf(value));
                             }
                           }
                         });



                        }
                    ),),
                ),

                Visibility(
                  visible: _areadropdown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                    padding: EdgeInsets.only( bottom: 6),
                    child:   CustomWidget.getTextsmall(translate('landing_screen.area')),
                  ),
                  InkWell(
                    onTap: (){
                      if(areanamesmultiple.length!=0){
                        if(area_name_multiple!=null){
                          area_name_multiple.clear();
                        }
                        if(area_ids_multiple!=null){
                          area_ids_multiple.clear();
                        }
                        _showMultiSelectarea(context);
                      }

                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xfffff0eff5)
                      ),
                      child: DropdownButtonHideUnderline(

                        child: DropdownButton(
                          isExpanded: true,
                          value: selectarea,
                          hint:Text(selectarea==null?translate('landing_screen.all'):area_name_multiple.length>2?"${area_name_multiple.length.toString()+" "+translate('landing_screen.selected_landing')}":selectarea.isEmpty?translate('landing_screen.all'):selectarea,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          items: [],
                          underline: SizedBox(),

                          icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                          iconSize: 38,

                          // style:
                          //
                          // GoogleFonts.ptSerif(
                          //     color: ColorConstant.kGreenColor,fontSize: 18
                          // ),
                          // onChanged: (value) {
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          //   selectlocation = value;
                          //
                          //
                          // }
                        ),),
                    ),
                  ),
                ],)),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                  padding: EdgeInsets.only( bottom: 6),
                  child:   CustomWidget.getTextsmall(translate('landing_screen.location')),
                ),
                InkWell(
                  onTap: (){

                    if(loactionnamemultiple.length!=0){
                      if(location_name_multiple!=null){
                        location_name_multiple.clear();
                      }

                      _showMultiSelect(context);
                    }

                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xfffff0eff5)
                    ),
                    child: DropdownButtonHideUnderline(

                      child: DropdownButton(
                          isExpanded: true,
                         value: selectlocation,
                          hint:Text(

                            selectlocation==null?translate('landing_screen.all'):location_name_multiple.length>2?"${location_name_multiple.length.toString()} selected":selectlocation.isEmpty?translate('landing_screen.all'):selectlocation,
    //selectlocation!=null?location_name_multiple.length>2?"${location_name_multiple.length.toString()+" "+translate('landing_screen.selected_landing')}":selectlocation:selectlocation1!=null?translate('landing_screen.all'):selectlocation,




                            style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          items: [],
                          underline: SizedBox(),

                          icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                          iconSize: 38,

                          // style:
                          //
                          // GoogleFonts.ptSerif(
                          //     color: ColorConstant.kGreenColor,fontSize: 18
                          // ),
                          // onChanged: (value) {
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          //   selectlocation = value;
                          //
                          //
                          // }
                      ),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                  padding: EdgeInsets.only( bottom: 6),
                  child:   CustomWidget.getTextsmall(translate('landing_screen.looking_for')),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 30, right: 30),
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xfffff0eff5)
                  ),
                  child:
                  DropdownButtonHideUnderline(

                    child: DropdownButton(
                        isExpanded: true,
                        value: selectlookingfor,
                        hint:Text(translate('landing_screen.all'),style: GoogleFonts.ptSerif(
                            color: ColorConstant.kGreenColor,fontSize: 18
                        ),),
                        items: looking_list.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,

                            child: Text(
                              value,
                              style: GoogleFonts.ptSerif(
                                  color: ColorConstant.kGreenColor,fontSize: 18),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),

                        icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                        iconSize: 38,

                        style:

                        GoogleFonts.ptSerif(
                            color: ColorConstant.kGreenColor,fontSize: 18
                        ),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          selectlookingfor = value;
                          dropDownLookingSelected(value,
                              looking_list.indexOf(value));


                        }
                    ),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                  padding: EdgeInsets.only( bottom: 6),
                  child:   CustomWidget.getTextsmall(translate('landing_screen.p_type')),
                ),
                InkWell(
                  onTap: (){

                    if(propertymultiple.length!=0){
                      if(property_name_multiple!=null){
                        property_name_multiple.clear();
                      }
                      if(property_ids_multiple!=null){
                        property_ids_multiple.clear();
                      }
                      _showMultiSelectProperty(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xfffff0eff5)
                    ),
                    child:
                    DropdownButtonHideUnderline(

                      child: DropdownButton(
                          isExpanded: true,
                          //value: selectproperty==null?translate('landing_screen.all'):property_name_multiple.length>2?"${property_name_multiple.length.toString()+" "+translate('landing_screen.selected_landing')}":selectproperty.isEmpty?translate('landing_screen.all'):selectproperty,
                          hint:Text(selectproperty==null?translate('landing_screen.all'):property_name_multiple.length>2?"${property_name_multiple.length.toString()+" "+translate('landing_screen.selected_landing')}":selectproperty.isEmpty?translate('landing_screen.all'):selectproperty,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          items:[],
                          underline: SizedBox(),

                          icon: Icon(Icons.keyboard_arrow_down,color:ColorConstant.kGreenColor ,),
                          iconSize: 38,

                          // style:
                          //
                          // GoogleFonts.ptSerif(
                          //     color: ColorConstant.kGreenColor,fontSize: 18
                          // ),
                          // onChanged: (value) {
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          //   selectproperty = value;
                          //   dropDownPropertySelected(value,
                          //       propertytype_list.indexOf(value));
                          //
                          //
                          // }
                      ),),


                  ),
                ),
              GestureDetector(
                onTap: (){
// print("locationnnnn${selectlocation}");
// print("locationnnnn111${selectlocation1}");
if(selectarea!=null){
  if(selectlocation==null||selectlocation.isEmpty){

    _navigateAndDisplaySelection(context);



  }
  else{
    selectlocation1=null;
    _navigateAndDisplaySelection(context);
  }

}
else{
  _navigateAndDisplaySelection(context);
}


                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => SearchListingPage(
                  //     countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation==null?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectproperty==null?"0":selectproperty=="All"?"0":selectproperty,fromwhere: "mainsearch",region_name_real:selectregion==null?"All":selectregion)));


                },
                child:   _submitButton(),),
                GestureDetector(
                  onTap: (){
                    if(selectarea!=null){
                      if(selectlocation==null||selectlocation.isEmpty){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => AdvaceSearch2(  countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation1!=null?selectlocation1:selectlocation==null?"0":selectlocation.isEmpty?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,region_name_real:selectregion==null?"All":selectregion)));
                      }
                      else{
                        selectlocation1=null;
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => AdvaceSearch2(  countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation1!=null?selectlocation1:selectlocation==null?"0":selectlocation.isEmpty?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,region_name_real:selectregion==null?"All":selectregion)));
                      }

                    }
                    else{
                      selectlocation1=null;
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AdvaceSearch2(  countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation1!=null?selectlocation1:selectlocation==null?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,region_name_real:selectregion==null?"All":selectregion)));
                    }





                  },
                    child: advancedsearch()),
                SizedBox(height: 35,)
            ],),)
          ],),

        ],
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: title,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }





  Widget _submitButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30,top: 20),
      padding: EdgeInsets.only(left: 15),
     // margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffff345f4f)),
      child: Text(
        translate('landing_screen.search'),
        style:   GoogleFonts.ptSerif(
            fontSize: 20, color: Colors.white
        ),
      ),
    );
  }

  Widget advancedsearch() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: 100, right: 100,top: 15),

      // margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: ColorConstant.kGreenColor),
      child: Text(
        translate('landing_screen.adv_y'),
        style:     GoogleFonts.ptSerif(
          fontSize: 15, color: Colors.white
      ),
      ),
    );
  }
  String lang( var input){
    var lng=
    _launchURL(input);

    return lng.toString();
  }
  _launchURL( url1) async {
   await translator
        .translate(url1, to: 'pl')
        .then((result) => url1=result);

   return url1;

  }
  _navigateAndDisplaySelection(BuildContext context) async {


    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => SearchListingPage(
          countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation1!=null?selectlocation1:selectlocation==null?"0":selectlocation.isEmpty?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,fromwhere: "mainsearch",region_name_real:selectregion==null?"All":selectregion)),
    );

    if(result=="Yep!"){

    //  selectedStateID="-1";selectdregionId="-1";selectedlokkingfor="-1";
    }
  }
  _navigateAndquick(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => SearchListingPage(
          fromwhere: "quicksearch",quickdata: searchquick.text.toString(),)),
    );


  }
}
