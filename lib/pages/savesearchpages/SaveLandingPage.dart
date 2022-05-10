import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/All_Country_Model.dart';
import 'package:kensington/model/AreaModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/pages/savesearchpages/SaveAdvanceSearch.dart';
import 'package:kensington/pages/savesearchpages/savesesearch/AdvanceSearchForSaveNewScreen.dart';
import 'package:kensington/pages/search/SearchListingPage.dart';
import 'package:kensington/pages/search/advancesearch/AdavanceSearch2.dart';
import 'package:kensington/pages/search/advancesearch/AdvanceSearch.dart';
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
class SaveLandingPage extends StatefulWidget {
  SaveLandingPage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SaveLandingPage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GlobalKey _drawerKey = GlobalKey();
  // String country = 'WorldWide';
  List<Result> countrylist ;
  PreferencesApp bloc;
  List<String> loactionnamemultiple = [];
  bool _areadropdown=false;
  Set<int> selectedval;
  Set<int> selectedvalarea;
  var  area_ids_multiple=[];
  List<String> propertymultiple = [];
  List <MultiSelectDialogItem<int>> propertymultiitems = List();
  var  property_name_multiple=[];
  static List<AreaModel> areamodel_list = new List<AreaModel>();
  var  property_ids_multiple=[];
  Set<int> selectedvalueproperty;
  List<String> loactionnamemultipleforarea = [];
  List <MultiSelectDialogItem<int>> areamultiItem = List();
  List <MultiSelectDialogItem<int>> multiItem = List();
  List<String> areanamesmultiple = [];
  var  area_name_multiple=[];
  var  location_name_multiple=[];
  Map<int, String> basicMap ,araemap,propertymap;
  List<DropdownMenuItem<String>> areanames = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<StateModel> state_model_list = new List<StateModel>();
  static List<CityModel> citymodel_list = new List<CityModel>();
  static List<PropertyModel> property_list = new List<PropertyModel>();
  static List<LookingForModel> looking_list1 = new List<LookingForModel>();
  List<String> country_list = [];

  List<String> region_list = [];
  List<String> looking_list = [];
  List<String> propertytype_list = [];
  List<DropdownMenuItem<String>> counrtynames = [];
  List<DropdownMenuItem<String>> lookingforname = [];
  List<DropdownMenuItem<String>> propertynames = [];
  List<DropdownMenuItem<String>> rigionnames = [];
  List<DropdownMenuItem<String>> locationnames = [];
  final translator = GoogleTranslator();
  String selectedStateID="1",selectdregionId="-1",selectedlokkingfor="-1",selectedpropertid="-1",selectedareaid="-1";
  String selectcountry = null,selectregion=null,selectlookingfor=null,selectproperty=null,selectlocation=null,selectarea=null;
  String selectcountry1 = null;
  AllCountryModel allCountryModel;

  Future getcountry () async{
    state_model_list.clear();
    if(country_list!=null){
      if(country_list.length>0){
        country_list.clear();
      }


    }

    Provider.of<LoginProvider>(context, listen: false)
        .fetchCountry()
        .then((value) {
      if (value) {
        if (mounted) {
          setState(() {
            allCountryModel =
                Provider.of<LoginProvider>(context, listen: false).getcountry();
            if (allCountryModel.status == "success") {
              countrylist = allCountryModel.result;

              counrtynames = [];
              for (int i = 0; i < countrylist.length; i++) {
                country_list.add(countrylist[i].name);
                String ID = countrylist[i].id;
                String NAME = countrylist[i].name;
                state_model_list.add(new StateModel(ID, NAME));
                // counrtynames.add(new DropdownMenuItem(
                //   child: new Text(countrylist[i].name),
                //   value: countrylist[i].name,
                // ));
              }
            }
          });
        }


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
        DialogUtils.hideProgress(context);
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

  Future get_property () async{
    if(propertytype_list!=null){
      if(propertytype_list.length>0){
        propertytype_list.clear();
      }
      if(propertymultiple.length!=0){
        propertymultiple.clear();
      }

    }
    if(countrylist!=null){

      if(countrylist.length>0){

        countrylist.clear();
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

          }
        });


      }
    });
  }

  Future getlocationforarea (regionid) async{

print(selectedareaid);
    if(locationnames!=null){
      if(locationnames.length>0){
        locationnames.clear();
        // loactionnamemultiple.clear();
      }


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
  Future getlocation (regionid) async{
    if(locationnames!=null){
      if(locationnames.length>0){
        locationnames.clear();
        // loactionnamemultiple.clear();
      }


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
  void getvaluefromkey(Set selection){
    selectedval=selection;
    if(selection != null){
      for(int x in selection.toList()){

        location_name_multiple.add('"${basicMap[x]}"');
      }

      setState(() {
        selectlocation=location_name_multiple.join(",").toString();


      });

    }
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
  void getvaluefromkeyproperty(Set selection){
    selectedvalueproperty=selection;

    if(selection != null){
      for(int x in selection.toList()){

        property_name_multiple.add("${propertymap[x]}");
        property_ids_multiple.add('${property_list[x].ID}');
      }
      setState(() {
        selectproperty=property_name_multiple.join(",").toString();
        selectedpropertid =property_ids_multiple.join(",").toString();

      });
    }
  }

  void populateMultiselectproperty(){
    for(int v in propertymap.keys){
      propertymultiitems.add(MultiSelectDialogItem(v, propertymap[v]));
    }
  }
  void getvaluefromkeyarea(Set selection){
    selectedvalarea=selection;
    if(selection != null){
      for(int x in selection.toList()){

        area_name_multiple.add("${araemap[x]}");
        area_ids_multiple.add("${ areamodel_list[x].ID}");
      }
      setState(() {

        selectarea=area_name_multiple.join(",").toString();
        selectedareaid =area_ids_multiple.join(",").toString();
        //selectarea  print(selectarea.isEmpty);

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
  FavModel user;
  void _savesearch(BuildContext context) {

print(selectedareaid);
    Provider.of<LoginProvider>(context, listen: false)
        .save_search(
    selectedStateID=="1"?"1":selectedStateID,
    selectdregionId=="-1"?"0":selectdregionId,
    selectlocation==null?"0":selectlocation==translate('landing_screen.all')?"0":selectlocation,
    selectedlokkingfor=="-1"?"0":selectedlokkingfor,
    selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,
       "All",
       "0",
       "All",
        "0",
        "All",
       "0",
       "All",
       "0",
        "All",
       "0",

        "0",

       "All",
        "0",

        "0",
        selectregion==null?"All":selectregion,
        "0",
       "0",
       "0",
        selectlookingfor==null?"All":selectlookingfor,
        selectproperty==null?"All":selectproperty,
      selectarea==null?"0":selectarea==translate('landing_screen.all')?"0":selectarea,
        selectedareaid=="-1"?"0":selectedareaid
    )
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="success"){
          CustomWidget.showtoast(
              context, translate('save_search.search_savetoast'));
          _onBackPressed();

        }
        if(user.status=="failed"){
          CustomWidget.showtoast(
              context, translate('save_search.three_pref'));


        }

      }

    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    selectedStateID="-1";selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";
    selectcountry = null;selectregion=null;selectlookingfor=null;selectproperty=null;selectlocation=null;
  }

  // @override
  // void didUpdateWidget(covariant SaveLandingPage oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //
  //   mainlangselection();
  // }
  Future<void> mainlangselection ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isselected = prefs.getBool('isselected');

    if(isselected){
      if(country_list!=null){
        country_list.clear();
        selectedStateID="-1";selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";
        selectcountry = null;
        selectregion=null;
        selectlocation=null;
        selectlookingfor=null;
        selectproperty=null;
        getcountry();
        get_property();
        get_lookingfor();
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
      selectlookingfor=null;
      selectproperty=null;
      getcountry();
     // getcount();
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
  void dropDownStateSelected(String newValueSelected, int index) {
    setState(() {
      selectdregionId="-1";selectedlokkingfor="-1";selectedpropertid="-1";selectedareaid="-1";
      selectregion=null;selectlocation=null;selectproperty=null;selectarea=null;
      this.selectedStateID = state_model_list[index].ID;

      if (selectedStateID == '-1') {
      } else {
        setState(() {
          _areadropdown = false;
          region_list.clear();
          citymodel_list.clear();
          getregion(selectedStateID);
          get_property();
        });
      }

    });
  }
  void dropDownregionSelected(String newValueSelected, int index) {
    setState(() {

      // city_list.add('Select City');
      // currentCitySelected = city_list[0];
      this.selectdregionId = citymodel_list[index].ID;

      if (selectdregionId == '-1') {
      } else {
        locationnames.clear();

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
  void dropDownPropertySelected(String newValueSelected, int index) {
    setState(() {


      this.selectedpropertid = property_list[index].ID;


    });
  }
  void _onBackPressed() {
    Navigator.pop(context, 'savesearch!');
    // Called when the user either presses the back arrow in the AppBar or
    // the dedicated back button.
  }
  @override
  Widget build(BuildContext context) {
    return
    WillPopScope(
        onWillPop: () {
          _onBackPressed();
          return Future.value(false);
        },
        child: Scaffold(
          key:_scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title:  Image.asset(
              'assets/appicon/icon.png',

              height: 34,
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () =>   Navigator.pop(context, 'savesearch!'),
            ),
            backgroundColor: ColorConstant.kGreenColor,
            actions: [
              new Stack(
                children: <Widget>[
                  new IconButton(icon: Icon(Icons.notifications), onPressed: () {
                    // setState(() {
                    //   counter = 0;
                    // });
                  }),
                  0 == 0 ? new Positioned(
                    right: 11,
                    top: 11,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '',
                        style: TextStyle(
                          color: ColorConstant.kGreenColor,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) : new Container()
                ],
              ),
              SizedBox(width: 20,),


            ],
          ),
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
                Text(translate('landing_screen.main_t'),textAlign: TextAlign.center,style: GoogleFonts.ptSerif(
                    color: ColorConstant.kGreyColor,fontSize: 13
                ) ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30,top: 15),
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
      Provider.of<LoginProvider>(context, listen: false)
          .setLoading(true);
      if( Provider.of<LoginProvider>(context, listen: false)
          .isLoading()){
        DialogUtils.showProgress(context);
        getarea();
        dropDownregionSelectedforarea(value,
            region_list.indexOf(value));

      }
    }
    else{
      Provider.of<LoginProvider>(context, listen: false)
          .setLoading(true);
      if( Provider.of<LoginProvider>(context, listen: false)
          .isLoading()){
        DialogUtils.showProgress(context);
        getarea();
        dropDownregionSelectedforarea(value,
            region_list.indexOf(value));

      }
    }

  }
 // _areadropdown=false;

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
                                      hint:Text(selectarea==null?translate('landing_screen.all'):area_name_multiple.length>2?"${area_name_multiple.length.toString()} selected":selectarea.isEmpty?translate('landing_screen.all'):selectarea,style: GoogleFonts.ptSerif(
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

                          Provider.of<LoginProvider>(context, listen: false)
                              .setLoading(true);
                          if( Provider.of<LoginProvider>(context, listen: false)
                              .isLoading()){
                            DialogUtils.showProgress(context);
                            _savesearch(context);

                          }


                        },
                        child:   _submitButton(),),
                      GestureDetector(
                          onTap: () async {


                            final result =  await Navigator.push(
                                context, MaterialPageRoute(builder: (context) => AdvaceSearchForLandingNewScreen(  countryid:selectedStateID=="1"?"1":selectedStateID,region_name:selectdregionId=="-1"?"0":selectdregionId,location_name:selectlocation==null?"0":selectlocation,looking_for:selectedlokkingfor=="-1"?"0":selectedlokkingfor,property_type:selectedpropertid=="-1"?"0":selectedpropertid.isEmpty?"0":selectedpropertid,region_name_real:selectregion==null?"All":selectregion,propertytypename:selectproperty ,lookingforname: selectlookingfor,araename:selectarea==null?"0":selectarea==translate('landing_screen.all')?"0":selectarea,)));


    if(result=="savesearch!"){
      _onBackPressed();
    }

                          },
                          child: advancedsearch()),
                      SizedBox(height: 35,)
                    ],),)
              ],),

            ],
          ),
        ));

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
        translate('drawer_lng.save_search'),
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

}
