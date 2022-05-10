import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LivingResponse.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/PriceRange.dart';
import 'package:kensington/model/SearchAmeeResponse.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/model/SearchRangeModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/search/advancesearch/AdvanceSearchForLanding.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/transalation/translations.dart';
import 'package:kensington/utils/ColorLoader3.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/constants.dart';
import 'package:kensington/utils/cus_widget/image_widget.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SearchListingPage extends StatefulWidget {
  String countryid,region_name,location_name,looking_for,property_type,fromwhere,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to,region_name_real,aircondition,seaview,swimmingpool,quickdata;
  SearchListingPage({
    Key key,this.countryid,this.region_name,this.location_name,this.looking_for,this.property_type,this.fromwhere,this.plot_size_from,this.plot_size_to,this.living_space_from,this.living_space_to,this.rooms_from,this.rooms_to,this.bedroom_from,this.bedroom_to,this.bathroom_from,this.bathroom_to,this.tarrace_from,this.price_from,this.price_to,this.region_name_real,this.aircondition,this.seaview,this.swimmingpool,this.quickdata
  }) : super(key: key);

  @override
  SearchListingPageState createState() => SearchListingPageState();
}
class SearchListingPageState extends State<SearchListingPage> {
  final filterArray = [
    "<\$220.000",
    "For sale",
    "3-4 beds",
    "Kitchen",
  ];
  Map<dynamic, dynamic> data;
  List result;
  String filtertext= '';
  String filterdata="1";
  List users = new List();
  List<Result> searchlist ;
  List<Pagination> paginationlist ;
  bool _selectedfilter = false;
  SearchModel _searchModel;
  String language1 = Translations.languages.first;
  static int page = 1;
  ScrollController _sc = new ScrollController();

  bool isLoading = false;
  SearchRangeModel searchRangeModel;
  LivingResponse _livingResponse;
  PriceRange _priceRange;
  PriceResult _priceResult;
  LivingResult _livingResult;
  ResultRange _result;
  SearchAmeeResponse _searchAmeeResponse;
  var maxplot;
  var minplot=0.0;

  var maxliving,minliving;
  var maxprice,minprice;
  bool isadvanceselected=false;
  var maxroom;
  var maxbathroom;
  var bedroom;
  var trraceroom;

  String bindropdown = null;
  String bindropdownroom = '1-2';
  String bindropdownto = 'To';
  String bindropdown1 = 'From';
  String bindropdownto1 = 'To';
  String bindropdown2 = 'From';
  String bindropdownto2 = 'To';
  String bindropdown3 = 'From';
  String bindropdownto3 = 'To';
  String bindropdown4 = 'From';
  String bindropdownto4 = 'To';
  String bindropdown5 = 'From';
  String bindropdownto5 = 'To';
  String bindropdown6 = 'From';
  String bindropdownto6 = 'To';
  String nameCity = '';
  String sizetext = '';
  String livingroomtext = '';
  String roomtext = '';
  String bedroomtext = '';
  String bathroomtext = '';
  String tarrecetext = '';
  String priceroomtext = '';
  bool _selected = false;
  bool _selectedliving = false;
  bool _selectedroom = false;
  bool _selectedbedroom = false;
  bool _selectedbathroom = false;
  bool _selectedterrace = false;
  bool _selectedprice = false;
  List <String> temlist=[
    '100-500 m\u00B2',
    '501-1000 m\u00B2',
    '1001-1500 m\u00B2',
    '1501-2000 m\u00B2',
    '2001-2500 m\u00B2',
    '2501-3000 m\u00B2',
    translate('advance_search.from')+' 3000 m\u00B2',
  ];
  List <String> livingspacelist=[
    '0-50 m\u00B2',
    '50-100 m\u00B2',
    '101-150 m\u00B2',
    '151-200 m\u00B2',
    '201-250 m\u00B2',
    '251-300 m\u00B2',
    translate('advance_search.more_than')+' 300 m\u00B2'
  ];
  List <String> roomstaticlist=[
    '1-2',
    '2-4',
    '4-6',
    translate('advance_search.more_than')+' 6'
  ];
  List <String> bedroomstaticlist=[
    '1-2',
    '2-4',
    '4-6',
    translate('advance_search.more_than')+' 6'
  ];
  List <String> bathtaticlist=[
    '1-2',
    '2-3',
    translate('advance_search.more_than')+' 3'
  ];
  List <String> tarreacestaticlist=[];
  List <String> pricestaticlist=[
    translate('advance_search.until')+' 250.000',
    translate('advance_search.until')+' 500.000',
    translate('advance_search.until')+' 750.000',
    translate('advance_search.until')+' 1.000.000',
    translate('advance_search.until')+' 2.000.000',
    translate('advance_search.from')+' 2.000.000'



  ];
  List <String> spinnerbins = [

    '1-600',
    '600-1200',
    '1200-1800',
    '1800-2400',
    '2400-300',
    '3000 '+ translate('advance_search.andmore'),

  ];
  List <String> spinnerbinsroom = [

    '1-2',
    '2-3',
    '3-6',
    '6 '+translate('advance_search.andmore'),


  ];
  List <String> spinnerbinsto = [
    'To',
    '600',
    '1200',
    '1800',
    '2400',
    '3000',

  ];
  void _getplot() {



    Provider.of<LoginProvider>(context, listen: false)
        .fetchserch()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        searchRangeModel = Provider.of<LoginProvider>(context, listen: false).getsearch();
        if(searchRangeModel.status=="success"){



          setState(() {

            _result=searchRangeModel.result;

            maxplot=double.parse(_result.maximumPlotSize.toString());

          });

        }

      }

    });

  }

  void _getliving() {

    Provider.of<LoginProvider>(context, listen: false)
        .fetchLiving()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        _livingResponse = Provider.of<LoginProvider>(context, listen: false).getlivingspace();
        if(_livingResponse.status=="success"){



          setState(() {

            _livingResult=_livingResponse.result;

            maxliving=double.parse(_livingResult.maximumLivingSpace);




          });

        }

      }

    });

  }
  void _getrooms() {

    Provider.of<LoginProvider>(context, listen: false)
        .fetchrooms()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
        if(_searchAmeeResponse.status=="success"){
          setState(() {
            maxroom=double.parse(_searchAmeeResponse.result);




          });
        }

      }

    });

  }
  void _getbedrooms() {

    Provider.of<LoginProvider>(context, listen: false)
        .fetchbedrroms()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
        if(_searchAmeeResponse.status=="success"){
          setState(() {
            bedroom=double.parse(_searchAmeeResponse.result);

          });
        }

      }

    });

  }
  void _getbathrooms() {

    Provider.of<LoginProvider>(context, listen: false)
        .fetchbathrooms()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
        if(_searchAmeeResponse.status=="success"){
          setState(() {
            maxbathroom=double.parse(_searchAmeeResponse.result);


          });
        }

      }

    });

  }
  void _gettarrcae() {

    Provider.of<LoginProvider>(context, listen: false)
        .fetchterrace()
        .then((value) {
      if (value) {
        DialogUtils.hideProgress(context);

        _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
        if(_searchAmeeResponse.status=="success"){
          setState(() {
            trraceroom=double.parse(_searchAmeeResponse.result);

          });
        }

      }

    });

  }
  Map<dynamic, dynamic> data1;
  List result1;

  Future _getpricerange() async {


    var response = await http.get(
      Uri.encodeFull(ApiClient.url+"pricerange.php"),
    );
    this.setState(() {
      data1 = json.decode(response.body);
      String msg = data1["status"];
      if(msg=="success"){
        var prieresiult=data1["result"];
        maxprice=double.parse(prieresiult["maximum_price"]);

      }


    });
    return "Success";
  }
  double _lowerValue ;
  double _upperValue;
  int selectedIndexroom = -1;
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _valuetarrace = false;
  RangeValues rangeValuesplot=RangeValues(0.0, 100.0);
  RangeValues rangeValueslivingspace=RangeValues(0.0, 100.0);
  final List<String> room = <String>['Any', '1+', '2+', '3+','4+'];

  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  void _dropDownItemSelected(String valueSelectedByUser) {
    setState(() {
      this.sizetext = valueSelectedByUser;
      _selected = true;
    });
  }
  void _dropDownItemliving(String valueSelectedByUser) {
    setState(() {
      this.livingroomtext = valueSelectedByUser;
      _selectedliving = true;
    });
  }
  void _dropDownItemroom(String valueSelectedByUser) {
    setState(() {
      this.roomtext = valueSelectedByUser;
      _selectedroom = true;
    });
  }
  void _dropDownItembedroom(String valueSelectedByUser) {
    setState(() {
      this.bedroomtext = valueSelectedByUser;
      _selectedbedroom = true;
    });
  }
  void _dropDownItembathroom(String valueSelectedByUser) {
    setState(() {
      this.bathroomtext = valueSelectedByUser;
      _selectedbathroom = true;
    });
  }
  void _dropDownItemtarrece(String valueSelectedByUser) {
    setState(() {
      this.tarrecetext = valueSelectedByUser;
      _selectedterrace = true;
    });
  }
  void _dropDownItemprice(String valueSelectedByUser) {
    setState(() {
      this.priceroomtext = valueSelectedByUser;
      _selectedprice = true;
    });
  }

  Future gersearchresult (int index) async{

print("country${widget.countryid.toString()}region${widget.region_name.toString()}loca${widget.location_name}looking${widget.looking_for}prop${widget.property_type}prop${widget.property_type}");

if (!isLoading) {
  setState(() {
    isLoading = true;
  });
  Provider.of<LoginProvider>(context, listen: false)
      .Search_result(widget.countryid.toString(),widget.region_name.toString(),widget.location_name.toString()==translate('landing_screen.all')?"0":widget.location_name.toString(),widget.looking_for.toString(),widget.property_type.toString(),index.toString(),widget.region_name_real,filterdata)
      .then((value) {
    if (value) {
      setState(() {
        isLoading = false;
        _searchModel = Provider.of<LoginProvider>(context, listen: false).getsearchresult();
        if (_searchModel.status == "success") {
          searchlist=_searchModel.result;
          if(searchlist.length!=0){
            paginationlist = _searchModel.pagination;
            isLoading = false;
            users.addAll(searchlist);
            page++;
          }
          else{
            searchlist=[];
          }
          // if(users.length==0){
          //   CustomWidget.showtoast(
          //       context, translate('search_lang.noresult'));
          // }
        }



      });


    }
  });
}

  }
  Future getquicksearch (int index) async{

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      Provider.of<LoginProvider>(context, listen: false)
          .quick_Search_result(widget.quickdata,index.toString(),filterdata)
          .then((value) {
        if (value) {
          setState(() {
            isLoading = false;
            _searchModel = Provider.of<LoginProvider>(context, listen: false).getsearchresult();
            if (_searchModel.status == "success") {
              searchlist=_searchModel.result;
              if(searchlist.length!=0){
                paginationlist = _searchModel.pagination;
                isLoading = false;
                users.addAll(searchlist);
                for(int i=0;i<searchlist.length;i++){
                  print(searchlist[i].isfavroite);
                }
                page++;
              }
              else{
                searchlist=[];
              }
              // if(users.length==0){
              //   CustomWidget.showtoast(
              //       context, translate('search_lang.noresult'));
              // }
            }



          });


        }
      });
    }

  }
  List <String> filterlist=[
    translate('advance_search.latest_first'),
    translate('advance_search.oldes'),
    translate('advance_search.price_asendi'),
    translate('advance_search.price_des'),




  ];
//
  Future getadvancesearchresult (int index) async {

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      //print('"country${widget.countryid.toString()}index${widget.region_name+widget.location_name}plotfrom${widget.plot_size_from}plotto${widget.plot_size_to}livfrom${widget.living_space_from}livingto${widget.living_space_to}roomfrom${widget.rooms_from}roomto${widget.rooms_to}bef${widget.bedroom_from}bedto${widget.bedroom_to}bath${widget.bathroom_to}terr${widget.tarrace_from}aircondition${widget.aircondition}seaview${widget.seaview}swimming${widget.swimmingpool}pricefrom${widget.price_from}priceto${widget.price_to}');

      Provider.of<LoginProvider>(context, listen: false)
          .advance_Search_result(
          widget.countryid,
          widget.region_name,
          widget.location_name,
          widget.looking_for,
          widget.property_type,
          widget.plot_size_from,
          widget.plot_size_to,
          widget.living_space_from,
          widget.living_space_to,
          widget.rooms_from,
          widget.rooms_to,
          widget.bedroom_from,
          widget.bedroom_to,
          widget.bathroom_from,
          widget.bathroom_to,
          widget.tarrace_from,
          widget.price_from,
          widget.price_to,
          index.toString(),
          widget.region_name_real,
      widget.aircondition,
      widget.seaview,
      widget.swimmingpool,
          filterdata)
          .then((value) {
        if (value) {
          setState(() {
            isLoading = false;
            _searchModel = Provider.of<LoginProvider>(context, listen: false)
                .getsearchresult();
            if (_searchModel.status == "success") {
              searchlist = _searchModel.result;
              if(searchlist.length!=0){

                paginationlist = _searchModel.pagination;

                isLoading = false;
                users.addAll(searchlist);
                page++;
              }
              else{
                searchlist=[];
              }
              // if(users.length==0){
              //   CustomWidget.showtoast(
              //       context, translate('search_lang.noresult'));
              // }
            }
          });
        }
      });
    }
  }



  @override
  void initState() {
    showDemoActionSheet();
    _getplot();
    _getliving();
    _getrooms();
    _getbedrooms();
    _getbathrooms();
    _gettarrcae();
    _getpricerange();
    if(widget.fromwhere=="advancesearch"){
      page=1;
      getadvancesearchresult(page);
    }
    else if(widget.fromwhere=="mainsearch"){
      // getFaqDetails();
      gersearchresult(page);
    }
    else if(widget.fromwhere=="quicksearch"){
      getquicksearch(page);
    }
    // TODO: implement initState
    super.initState();
    _sc.addListener(() {

      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        if(widget.fromwhere=="advancesearch"){
          getadvancesearchresult(page);
        }
        else if(widget.fromwhere=="mainsearch"){
          // getFaqDetails();
          gersearchresult(page);
        }
        else if(widget.fromwhere=="quicksearch"){

          getquicksearch(page);
        }
      }
    });
    notif_arrived1();

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
  void _dropDownItemfilter(String valueSelectedByUser) {
    setState(() {
      this.filtertext = valueSelectedByUser;
      _selectedfilter = true;
      if(filtertext== translate('advance_search.latest_first')){

        filterdata="1";
        page = 1;
        searchlist.clear();
        users.clear();
        searchlist=null;
        if(widget.fromwhere=="advancesearch"){
          getadvancesearchresult(page);
        }
        else if(widget.fromwhere=="mainsearch"){
          print(widget.fromwhere);
          // getFaqDetails();
          gersearchresult(page);
        }
        else if(widget.fromwhere=="quicksearch"){
          getquicksearch(page);
        }
      }
      else if(filtertext==  translate('advance_search.oldes')){
        filterdata="2";
        page = 1;
        searchlist.clear();
        users.clear();
        searchlist=null;
        if(widget.fromwhere=="advancesearch"){
          getadvancesearchresult(page);
        }
        else if(widget.fromwhere=="mainsearch"){
          // getFaqDetails();
          gersearchresult(page);
        }
        else if(widget.fromwhere=="quicksearch"){
          getquicksearch(page);
        }
      }
     else if(filtertext==   translate('advance_search.price_asendi')){
        filterdata="3";
        page = 1;
        searchlist.clear();
        users.clear();
        searchlist=null;
        if(widget.fromwhere=="advancesearch"){
          getadvancesearchresult(page);
        }
        else if(widget.fromwhere=="mainsearch"){
          // getFaqDetails();
          gersearchresult(page);
        }
        else if(widget.fromwhere=="quicksearch"){
          getquicksearch(page);
        }
      }
      else if(filtertext== translate('advance_search.price_des')){
        filterdata="4";
        page = 1;
        searchlist.clear();
        users.clear();
        searchlist=null;
        if(widget.fromwhere=="advancesearch"){
          getadvancesearchresult(page);
        }
        else if(widget.fromwhere=="mainsearch"){
          // getFaqDetails();
          gersearchresult(page);
        }
        else if(widget.fromwhere=="quicksearch"){
          getquicksearch(page);
        }
      }
    });
  }

  FavModel user;
  // void _savesearch(BuildContext context) {
  //
  //   Provider.of<LoginProvider>(context, listen: false)
  //       .save_search(   widget.countryid,
  //       widget.region_name,
  //       widget.location_name,
  //       widget.looking_for,
  //       widget.property_type,
  //       widget.plot_size_from,
  //       widget.plot_size_to,
  //       widget.living_space_from,
  //       widget.living_space_to,
  //       widget.rooms_from,
  //       widget.rooms_to,
  //       widget.bedroom_from,
  //       widget.bedroom_to,
  //       widget.bathroom_from,
  //       widget.bathroom_to,
  //       "1",
  //       widget.price_from,
  //       widget.price_to,
  //       "1",
  //       widget.region_name_real,
  //     widget.aircondition,
  //     widget.seaview,
  //     widget.swimmingpool
  //   )
  //       .then((value) {
  //     if (value) {
  //
  //       DialogUtils.hideProgress(context);
  //
  //       user = Provider.of<LoginProvider>(context, listen: false).getfav();
  //       if(user.status=="success"){
  //         CustomWidget.showtoast(
  //             context, "Propery saved successfully");
  //
  //         Navigator.pop(context);
  //       }
  //
  //     }
  //
  //   });
  //
  // }

  @override
  void dispose() {
    _sc.dispose();
    page=1;
    super.dispose();
  }
  void _onBackPressed() {
    Navigator.pop(context, 'Yep!');
    // Called when the user either presses the back arrow in the AppBar or
    // the dedicated back button.
  }
  // Future<bool> _onWillPop() {
  //   return _onBackPressed();
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
    var screenWidth = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: ColorConstant.kWhiteColor,
    //   ),
    // );
    return
     WillPopScope(
       onWillPop: () {
         _onBackPressed();
         return Future.value(false);
       },
       child: Scaffold(
           backgroundColor: ColorConstant.kWhiteColor,
           appBar:CustomWidget.getappbar(context,counter),
           resizeToAvoidBottomInset: false,
           body:
           // searchlist==null&&users.length==0?_saveButton():
           searchlist==null? Align(

               alignment: Alignment.center,
               child: ColorLoader3(radius: 20.0, dotRadius: 6.0)):users.length==0?_saveButton():
           ListView(

             children: [

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(
                       left: 15,
                       right: 15,
                       top: 8,
                     ),
                     child:   CustomWidget.getheading1( translate('search_lang.search_result')),

                   ),
                   Padding(
                      padding:  EdgeInsets.only(top:8.0

                   ),
                     child: Container(
                       margin: EdgeInsets.only( right: 12),
                       padding: EdgeInsets.only( right: 12),
                       height: 40,
                       width: 140,



                       child:


                       DropdownButton<String>(


                         icon: Icon(Icons.sort,color: ColorConstant.kGreenColor,),
                         iconSize: 24,

                         isExpanded: true,
                         elevation: 16,
                         underline: SizedBox(),
                         style: TextStyle(color: Colors.grey, fontSize: 18),
                         items: filterlist.map((String stringvalue) {
                           return DropdownMenuItem<String>(
                             value: stringvalue,
                             child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15),),
                           );
                         }).toList(),
                         onChanged: (String valueSelectedByUser) {
                           _dropDownItemfilter(valueSelectedByUser);
                         },


                       ),
                     ),
                   ),
                 ],

               ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding:  EdgeInsets.only(top:5.0, left: 15,

                ),
                child: Text(
                  paginationlist!=null?
                  "("+paginationlist[0].totalItems.toString()+")":"0",
                  style: GoogleFonts.ptSerif(
                      fontSize: 15,
                      color: ColorConstant.kGreyColor

                  ),

                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(

                    right: 25,
                    top: 8,
                  ),
                  child:   InkWell(
                    onTap: (){
            // setState(() {
            //   if(isadvanceselected){
            //     isadvanceselected=false;
            //   }
            //   else{
            //     isadvanceselected=true;
            //   }
            //
            // });
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AdvaceSearchForLanding(  countryid:widget.countryid=="1"?"1":widget.countryid,region_name:widget.region_name=="-1"?"0":widget.region_name,location_name:widget.location_name==null?"0":widget.location_name,looking_for:widget.looking_for=="-1"?"0":widget.looking_for,property_type:widget.property_type=="-1"?"0":widget.property_type,region_name_real:widget.region_name_real==null?"All":widget.region_name_real)));
                    },
                      child: CustomWidget.getheadingadva( translate('advance_search.advance_text1'))
                  ),

                ),

            ],),

               // Visibility(
               //   visible: isadvanceselected,
               //   child:
               //   Container(
               //   margin: const EdgeInsets.only(left:22.0,top:20),
               //   child:
               //  Column(children: [
               //    Row(children: [
               //      Column(
               //        crossAxisAlignment: CrossAxisAlignment.start,
               //        children: [
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              CustomWidget.getTextsearch(translate('advance_search.size_plot')),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_size'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: temlist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItemSelected(valueSelectedByUser);
               //                  },
               //                  value: _selected ? sizetext : null,
               //
               //                ),
               //
               //              ),
               //            ],),
               //          SizedBox(height: 8,),
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              CustomWidget.getTextsearch(translate('advance_search.Rooms')),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0,) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_room'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: roomstaticlist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItemroom(valueSelectedByUser);
               //                  },
               //                  value: _selectedroom ? roomtext : null,
               //
               //                ),
               //              ),
               //            ],
               //          ),
               //          SizedBox(height: 8,),
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              CustomWidget.getTextsearch(translate('advance_search.bathroom')),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0,) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_bath'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: bathtaticlist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItembathroom(valueSelectedByUser);
               //                  },
               //                  value: _selectedbathroom ? bathroomtext : null,
               //
               //                ),
               //              ),
               //            ],
               //          ),
               //          SizedBox(height: 8,),
               //        ],),
               //      Column(
               //        crossAxisAlignment: CrossAxisAlignment.start,
               //        children: [
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              Padding(
               //                padding:EdgeInsets.only(left: 5.0,) ,
               //                child: CustomWidget.getTextsearch(translate('advance_search.living_space')),
               //              ),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0,) ,
               //                margin:EdgeInsets.only(left: 5.0,) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_living'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: livingspacelist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItemliving(valueSelectedByUser);
               //                  },
               //                  value: _selectedliving ? livingroomtext : null,
               //
               //                ),
               //              ),
               //            ],),
               //          SizedBox(height: 8,),
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              CustomWidget.getTextsearch(translate('advance_search.bedroom')),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0,) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_bed'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: bedroomstaticlist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItembedroom(valueSelectedByUser);
               //                  },
               //                  value: _selectedbedroom ? bedroomtext : null,
               //
               //                ),
               //              ),
               //            ],
               //          ),
               //          SizedBox(height: 8,),
               //          Column(
               //            crossAxisAlignment: CrossAxisAlignment.start,
               //            children: [
               //              CustomWidget.getTextsearch(translate('advance_search.price')),
               //              SizedBox(height: 8,),
               //              Container(
               //
               //                padding:EdgeInsets.only(left: 10.0,) ,
               //                height: 40,
               //                decoration: new BoxDecoration(
               //                  border: Border.all(width: 2,color: ColorConstant.kGreenColor),
               //                  borderRadius: BorderRadius.all( Radius.circular(5.0)),
               //
               //                ),
               //
               //
               //                child:
               //
               //
               //                DropdownButton<String>(
               //
               //                  hint:Text(translate('advance_search.select_price'),style: GoogleFonts.ptSerif(
               //                      color: ColorConstant.kGreenColor,fontSize: 18
               //                  ),),
               //                  icon: Icon(Icons.keyboard_arrow_down),
               //                  iconSize: 24,
               //                  underline: SizedBox(),
               //
               //                  elevation: 16,
               //                  style: TextStyle(color: Colors.grey, fontSize: 18),
               //                  items: pricestaticlist.map((String stringvalue) {
               //                    return DropdownMenuItem<String>(
               //                      value: stringvalue,
               //                      child: Text(stringvalue,style: GoogleFonts.ptSerif(color: ColorConstant.kGreenColor,fontSize: 15)),
               //                    );
               //                  }).toList(),
               //                  onChanged: (String valueSelectedByUser) {
               //                    _dropDownItemprice(valueSelectedByUser);
               //                  },
               //                  value: _selectedprice ? priceroomtext : null,
               //
               //                ),
               //              ),
               //            ],),
               //          SizedBox(height: 8,),
               //        ],
               //      )
               //    ],),
               //    SizedBox(height: 10,),
               //    Column(
               //
               //      children: <Widget>[
               //        Row(children: [
               //          Row(
               //            children: <Widget>[
               //              Transform.scale(
               //                scale: 1.4,
               //                child:           Theme(
               //                  data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
               //                  child: Checkbox(
               //
               //                      checkColor: Colors.white,
               //                      activeColor: ColorConstant.kGreenColor,
               //                      value: _value1,
               //                      onChanged: _valueair),
               //                ),
               //              ),
               //
               //              Text(translate('advance_search.airco'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
               //
               //            ],
               //          ),
               //          SizedBox(width: 10,),
               //          Row(
               //            children: <Widget>[
               //              Transform.scale(
               //                scale: 1.4,
               //                child:           Theme(
               //                  data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
               //                  child: Checkbox(
               //
               //                      checkColor: Colors.white,
               //                      activeColor: ColorConstant.kGreenColor,
               //                      value: _value2,
               //                      onChanged: _valuesea),
               //                ),
               //              ),
               //
               //              Text(translate('advance_search.seaview'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
               //
               //            ],
               //          )
               //        ],
               //        ),
               //        Row(children: [
               //          Row(
               //            children: <Widget>[
               //              Transform.scale(
               //                scale: 1.4,
               //                child:           Theme(
               //                  data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
               //                  child: Checkbox(
               //
               //                      checkColor: Colors.white,
               //                      activeColor: ColorConstant.kGreenColor,
               //                      value: _value3,
               //                      onChanged: _valueswimming),
               //                ),
               //              ),
               //
               //              Text(translate('advance_search.swimming'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
               //
               //            ],
               //          ),
               //          SizedBox(width: 10,),
               //          Row(
               //            children: <Widget>[
               //              Transform.scale(
               //                scale: 1.4,
               //                child:Theme(
               //                  data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
               //                  child: Checkbox(
               //
               //                      checkColor: Colors.white,
               //                      activeColor: ColorConstant.kGreenColor,
               //                      value: _valuetarrace,
               //                      onChanged: _valuetarracee),
               //                ),
               //              ),
               //
               //              Text(translate('advance_search.tarrace'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
               //
               //            ],
               //          ),
               //        ],),
               //
               //
               //
               //      ],
               //    ),
               //  ],)
               //
               // ),),
               Container(
                 height: screenWidth,
                 padding: EdgeInsets.only(bottom: 100),
                 child:  ListView.builder(
                     controller: _sc,

                     scrollDirection: Axis.vertical,
                     itemCount: users == null ? 0 : users.length+1,
                     itemBuilder: (BuildContext context, int position) {
                       if (position == users.length) {
                         return _buildProgressIndicator();
                       }
                       else {
                         return Padding(
                           padding: const EdgeInsets.only(top: 10),
                           child:

                           ImageWidget(
                             house:users[position],
                             imgpath_index: position,
                             region_name: widget.region_name_real==null?"All":widget.region_name_real,

                             onbtnTap: (){

                               page = 1;
                               searchlist.clear();
                               users.clear();
                               searchlist=null;
                               if(widget.fromwhere=="advancesearch"){
                                 getadvancesearchresult(page);
                               }
                               else if(widget.fromwhere=="mainsearch"){
                                 // getFaqDetails();
                                 gersearchresult(page);
                               }
                               else if(widget.fromwhere=="quicksearch"){

                                 getquicksearch(page);
                               }

                             },
                             onbtnTapdelete: (){
                               page = 1;
                               searchlist.clear();
                               users.clear();
                               searchlist=null;
                               if(widget.fromwhere=="advancesearch"){
                                 getadvancesearchresult(page);
                               }
                               else if(widget.fromwhere=="mainsearch"){
                                 // getFaqDetails();
                                 gersearchresult(page);
                               }
                               else if(widget.fromwhere=="quicksearch"){

                                 getquicksearch(page);
                               }
                             },


                           ),
                         );
                       }
                     }) ,
               )

             ],)



       ),
    );


  }
  Widget _buildProgressIndicator() {

    return

      new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child:ColorLoader3(radius: 20.0, dotRadius: 6.0)
        ),
      ),
    );
  }
  Widget _saveButton() {

    return
      Align(
        alignment: Alignment.center,
        child: Text(
          translate('search_lang.noresult'),
          style:    GoogleFonts.ptSerif(
              fontSize: 20, color: ColorConstant.kGreenColor
          ),),
      );

  }
  bool valuechecker1(firstvalue,secondvalue){


    int i = int.parse(firstvalue.toString());


    int j =int.parse(secondvalue.toString());

    if(secondvalue.toString().length!=0){

      if(((i<= j))){

        setState(() {
          FocusScope.of(context).requestFocus(new FocusNode());
          CustomWidget.showtoast(
              context, "from value can not be lower than to value");

        });
        return false;
      }
    }




    return true;
  }
  void _valueair(bool value) => setState(() => _value1 = value);
  void _valuesea(bool value) => setState(() => _value2 = value);
  void _valueswimming(bool value) => setState(() => _value3 = value);
  void _valuetarracee(bool value) => setState(() => _valuetarrace = value);
}



