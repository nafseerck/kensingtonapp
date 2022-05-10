import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/LivingResponse.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/PriceRange.dart';
import 'package:kensington/model/SearchAmeeResponse.dart';
import 'package:kensington/model/SearchRangeModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/auth/Forget.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../SearchListingPage.dart';





class AdvaceSearchForLanding extends StatefulWidget {
  String countryid,region_name,location_name,looking_for,property_type,region_name_real;
  AdvaceSearchForLanding({
    Key key,this.countryid,this.region_name,this.location_name,this.looking_for,this.property_type,this.region_name_real
  }) : super(key: key);
  @override
  _AdvaceSearchState createState() => _AdvaceSearchState();
}

class _AdvaceSearchState extends State<AdvaceSearchForLanding> {
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
  bool _plotmin=true;
  bool _plotmax=true;
  bool _livingmin=true;
  bool _livingmax=true;
  bool _roommax=true;
  bool _roommin=true;
  bool _bedmin=true;
  bool _bedmax=true;
  bool _bathmin=true;
  bool _bathmax=true;
  bool _pricemen=true;
  bool _pricemax=true;
  String sizetext = '';
  String sizetext1 = '';
  String livingroomtext = '';
  String livingroomtext1 = '';
  String roomtext = '';
  String roomtext1 = '';
  String bedroomtext = '';
  String bedroomtext1 = '';
  String bathroomtext = '';
  String bathroomtext1 = '';
  String tarrecetext = '';
  String tarrecetext1 = '';
  String priceroomtext = '';
  String priceroomtext1 = '';
  String priceroomtext2 = '';
  String priceroomtext3 = '';
  bool _selected = false;
  bool _selected1 = false;
  bool _selectedliving = false;
  bool _selectedliving1 = false;
  bool _selectedroom = false;
  bool _selectedroom1 = false;
  bool _selectedbedroom = false;
  bool _selectedbedroom1 = false;
  bool _selectedbathroom = false;
  bool _selectedbathroom1 = false;
  bool _selectedterrace = false;
  bool _selectedterrace1 = false;
  bool _selectedprice = false;
  bool _selectedprice1 = false;
  String valuesize,valuesize1,valueliving,valueliving1,valueroom,valueroom1,valuesbedroom,valuebedroom1,valuesbathroom,valuesbathroom1,valuesprice,valueprice1;
  List <String> maxsizelist=[
    translate('advance_search.select_text'),
    '500 m\u00B2',
    '1000 m\u00B2',
    '1500 m\u00B2',
    '2000 m\u00B2',
    '2500 m\u00B2',
    //translate('advance_search.above_text')+' 3000 m\u00B2',

  ];
  List <String> minsizelist=[
    translate('advance_search.select_text'),
    '0 m\u00B2',
    '501 m\u00B2',
    '1001 m\u00B2',
    '1501 m\u00B2',
    '2001 m\u00B2',
    translate('advance_search.from')+' 2501 m\u00B2',
    //translate('advance_search.from')+' 3000 m\u00B2',
  ];
  // List <String> livingspacelist=[
  //   '0-50 m\u00B2',
  //   '50-100 m\u00B2',
  //   '101-150 m\u00B2',
  //   '151-200 m\u00B2',
  //   '201-250 m\u00B2',
  //   '251-300 m\u00B2',
  //   translate('advance_search.more_than')+' 300 m\u00B2'
  // ];
  List <String> livingminlist=[
    translate('advance_search.select_text'),
    '0 m\u00B2',
    '50 m\u00B2',
    '101 m\u00B2',
    '151 m\u00B2',
    '201 m\u00B2',
    translate('advance_search.from')+' 251 m\u00B2',
    //translate('advance_search.from')+' 300'
  ];
  List <String> livingmaxlist=[
    translate('advance_search.select_text'),
    '50 m\u00B2',
    '100 m\u00B2',
    '150 m\u00B2',
    '200 m\u00B2',
    '250 m\u00B2',
    // translate('advance_search.above_text')+' 300 m\u00B2',


  ];
  // List <String> roomstaticlist=[
  //   '1-2',
  //   '2-4',
  //   '4-6',
  //   translate('advance_search.more_than')+' 6'
  // ];
  List <String> roomsminlist=[
    translate('advance_search.select_text'),
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    translate('advance_search.from')+' 6'
  ];
  List <String> roomsmaxlist=[
    translate('advance_search.select_text'),
    '1',
    '2',
    '3',
    '4',
    '5',
    '6'

    // translate('advance_search.above_text')+' 6',

  ];
  // List <String> bedroomstaticlist=[
  //   '1-2',
  //   '2-4',
  //   '4-6',
  //   translate('advance_search.more_than')+' 6'
  // ];
  List <String> bedroomminlist=[
    translate('advance_search.select_text'),
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    translate('advance_search.from')+' 6'
  ];
  List <String> bedroommaxlist=[
    translate('advance_search.select_text'),
    '1',
    '2',
    '3',
    '4',
    '5',
    '6'

  ];
  // List <String> bathtaticlist=[
  //   '1-2',
  //   '2-3',
  //   translate('advance_search.more_than')+' 3'
  // ];
  List <String> bathminlist=[
    translate('advance_search.select_text'),
    '0',
    '1',
    '2',
    '3',
    '4',
    translate('advance_search.from')+' 4'
  ];
  List <String> bathmaxlist=[
    translate('advance_search.select_text'),
    '1',
    '2',
    '3',
    '4'


  ];
  List <String> tarreacestaticlist=[];
  // List <String> pricestaticlist=[
  //   translate('advance_search.until')+' 250.000',
  //   translate('advance_search.until')+' 500.000',
  //   translate('advance_search.until')+' 750.000',
  //   translate('advance_search.until')+' 1.000.000',
  //   translate('advance_search.until')+' 2.000.000',
  //   translate('advance_search.from')+' 2.000.000'
  //
  //
  //
  // ];
  List <String> pricesmaxlist=[
    translate('advance_search.select_text'),
    '250.000',
    '500.000',
    '750.000',
    '1.250.000',
    '1.750.000',
    '2.000.000'





  ];
  List <String> pricesminlist=[
    translate('advance_search.select_text'),
    '10.000',
    '250.000',
    '500.000',
    '750.000',
    '1.250.000',
    '1.750.000',
    translate('advance_search.from')+' 2.000.000'



  ];
  List <String> pricesminlistforrental=[
    translate('advance_search.select_text'),
    '100',
    '501',
    '1.001',
    '1.501',
    '2.001',
    '2.501',
    translate('advance_search.from')+' 3.001'



  ];
  List <String> pricesmaxlistforrental=[
    translate('advance_search.select_text'),
    '500',
    '1.000',
    '1.500',
    '2.000',
    '2.500',
    '3.000'






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
            //var maxplot1=int.parse(maxplot);
// var rangeofma=maxplot/5;
//
//             temlist.add("$rangeofma m\u00B2");
// //my rnd
//
//           var i = rangeofma ;
//           var j = i+rangeofma;
//           while(i<maxplot) {
//
//             if(j< maxplot) {
//
//               var format = "$i m\u00B2-$j m\u00B2";
//               temlist.add(format);
//
//               i = j;
//               j = i + rangeofma;
//
//             } else {
//               var format = "$i m\u00B2-$maxplot m\u00B2";
//               temlist.add(format);
//               break;
//             }
//           }
//
//            print("my temp list$temlist");
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
  Map<dynamic, dynamic> data;
  List result;

  Future _getpricerange() async {


    var response = await http.get(
      Uri.encodeFull(ApiClient.url+"pricerange.php"),
    );
    this.setState(() {
      data = json.decode(response.body);
      String msg = data["status"];
      if(msg=="success"){
        var prieresiult=data["result"];
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDemoActionSheet();
    _getplot();
    _getliving();

    _getrooms();
    _getbedrooms();
    _getbathrooms();
    _gettarrcae();
    _getpricerange();

  }
  void showDemoActionSheet() {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  void _dropDownItemSelected(String valueSelectedByUser) {

    valuesize=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');

    setState(() {
      this.sizetext = valueSelectedByUser;
      _selected = true;

    });
    if(validation(valuesize, sizetext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _plotmin=true;

      });
    }
    else{
      setState(() {
        _plotmin=false;
      });
    }
    if(validation(sizetext.replaceAll(new RegExp(r'[^0-9]'),''), sizetext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _plotmax=true;


      });
    }
    else{
      setState(() {
        _plotmax=false;
      });
    }

  }
  void _dropDownItemSelected1(String valueSelectedByUser) {

    valuesize1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');

    setState(() {


      this.sizetext1 = valueSelectedByUser;
      _selected1 = true;
    });
    if(validation(sizetext.replaceAll(new RegExp(r'[^0-9]'),''), valuesize1)){
      setState(() {
        _plotmax=true;


      });
    }
    else{
      setState(() {
        _plotmax=false;
      });
    }
    if(validation(sizetext.replaceAll(new RegExp(r'[^0-9]'),''), sizetext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _plotmin=true;

      });
    }
    else{
      setState(() {
        _plotmin=false;
      });
    }


  }
  void _dropDownItemliving(String valueSelectedByUser) {
    valueliving=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.livingroomtext = valueSelectedByUser;
      _selectedliving = true;
    });
    if(validation(valueliving, livingroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _livingmin=true;

      });
    }
    else{
      setState(() {
        _livingmin=false;
      });
    }
    if(validation(livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''), livingroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _livingmax=true;

      });
    }
    else{
      setState(() {
        _livingmax=false;
      });
    }

  }
  void _dropDownItemliving1(String valueSelectedByUser) {
    valueliving1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.livingroomtext1 = valueSelectedByUser;
      _selectedliving1 = true;
    });
    if(validation(livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''), valueliving1)){
      setState(() {
        _livingmax=true;

      });
    }
    else{
      setState(() {
        _livingmax=false;
      });
    }
    if(validation(livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''), livingroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _livingmin=true;

      });
    }
    else{
      setState(() {
        _livingmin=false;
      });
    }

  }
  void _dropDownItemroom(String valueSelectedByUser) {

    valueroom=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.roomtext = valueSelectedByUser;
      _selectedroom = true;
    });
    if(validation(valueroom, roomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _roommin=true;

      });
    }
    else{
      setState(() {
        _roommin=false;
      });
    }
    if(validation(roomtext.replaceAll(new RegExp(r'[^0-9]'),''), roomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _roommax=true;

      });
    }
    else{
      setState(() {
        _roommax=false;
      });
    }

  }
  void _dropDownItemroom1(String valueSelectedByUser) {
    valueroom1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.roomtext1 = valueSelectedByUser;
      _selectedroom1 = true;
    });
    if(validation(roomtext.replaceAll(new RegExp(r'[^0-9]'),''), valueroom1)){
      setState(() {
        _roommax=true;

      });
    }
    else{
      setState(() {
        _roommax=false;
      });
    }
    if(validation(roomtext.replaceAll(new RegExp(r'[^0-9]'),''), roomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _roommin=true;

      });
    }
    else{
      setState(() {
        _roommin=false;
      });
    }

  }
  void _dropDownItembedroom(String valueSelectedByUser) {
    valuesbedroom=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.bedroomtext = valueSelectedByUser;
      _selectedbedroom = true;
    });
    if(validation(valuesbedroom, bedroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bedmin=true;

      });
    }
    else{
      setState(() {
        _bedmin=false;
      });
    }
    if(validation(bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''), bedroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bedmax=true;

      });
    }
    else{
      setState(() {
        _bedmax=false;
      });
    }

  }
  void _dropDownItembedroom1(String valueSelectedByUser) {
    valuebedroom1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.bedroomtext1 = valueSelectedByUser;
      _selectedbedroom1 = true;
    });
    if(validation(bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''), valuebedroom1)){
      setState(() {
        _bedmax=true;

      });
    }
    else{
      setState(() {
        _bedmax=false;
      });
    }
    if(validation(bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''), bedroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bedmin=true;

      });
    }
    else{
      setState(() {
        _bedmin=false;
      });
    }

  }
  void _dropDownItembathroom(String valueSelectedByUser) {
    valuesbathroom=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.bathroomtext = valueSelectedByUser;
      _selectedbathroom = true;
    });
    if(validation(valuesbathroom, bathroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bathmin=true;

      });
    }
    else{
      setState(() {
        _bathmin=false;
      });
    }
    if(validation(bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''), bathroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bathmax=true;

      });
    }
    else{
      setState(() {
        _bathmax=false;
      });
    }

  }
  void _dropDownItembathroom1(String valueSelectedByUser) {
    valuesbathroom1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9]'),'');
    setState(() {

      this.bathroomtext1 = valueSelectedByUser;
      _selectedbathroom1 = true;
    });
    if(validation(bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''), valuesbathroom1)){
      setState(() {
        _bathmax=true;

      });
    }
    else{
      setState(() {
        _bathmax=false;
      });
    }
    if(validation(bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''), bathroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
      setState(() {
        _bathmin=true;

      });
    }
    else{
      setState(() {
        _bathmin=false;
      });
    }

  }
  void _dropDownItemtarrece(String valueSelectedByUser) {
    setState(() {
      this.tarrecetext = valueSelectedByUser;
      _selectedterrace = true;
    });
  }
  void _dropDownItemtarrece1(String valueSelectedByUser) {
    setState(() {
      this.tarrecetext1 = valueSelectedByUser;
      _selectedterrace1 = true;
    });
  }
  void _dropDownItemprice(String valueSelectedByUser) {
    valuesprice=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9.]'),'').replaceAll(".",'');
    setState(() {

      this.priceroomtext = valueSelectedByUser;
      _selectedprice = true;
    });
    if(validation(valuesprice, priceroomtext1.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''))){
      setState(() {
        _pricemen=true;

      });
    }
    else{
      setState(() {
        _pricemen=false;
      });
    }
    if(validation(priceroomtext.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''), priceroomtext1.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''))){
      setState(() {
        _pricemax=true;

      });
    }
    else{
      setState(() {
        _pricemax=false;
      });
    }

  }
  void _dropDownItemprice1(String valueSelectedByUser) {
    valueprice1=valueSelectedByUser.replaceAll(new RegExp(r'[^0-9.]'),'').replaceAll(".",'');
    setState(() {

      this.priceroomtext1 = valueSelectedByUser;
      _selectedprice1 = true;
    });
    if(validation(priceroomtext.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''), valueprice1)){
      setState(() {
        _pricemax=true;

      });
    }
    else{
      setState(() {
        _pricemax=false;
      });
    }
    if(validation(priceroomtext.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''), priceroomtext1.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''))){
      setState(() {
        _pricemen=true;

      });
    }
    else{
      setState(() {
        _pricemen=false;
      });
    }

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
    double _lowerValue = 0.0;
    double _upperValue = 100.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:CustomWidget.getappbar(context,counter),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomWidget.getheading1(translate('advance_search.advance_text')),
                Container(
                  margin: const EdgeInsets.only(left:10.0,top:20,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidget.getTextsearch(translate('advance_search.size_plot')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:

                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,

                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: minsizelist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child:
                                    Text(stringvalue,),
                                    // Column(children: [
                                    //   Divider(
                                    //     color: ColorConstant.kGreenColor,
                                    //     thickness: 0.7,
                                    //   ),
                                    //   Text(stringvalue,),
                                    // ],)
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemSelected(valueSelectedByUser);
                                },
                                value: _selected ? sizetext : null,

                              ),

                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_plotmin &&_plotmax? Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:

                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: maxsizelist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemSelected1(valueSelectedByUser);
                                },
                                value: _selected1 ? sizetext1 : null,

                              ),

                            ),
                          ),

                        ],),
                      Visibility(visible: !(_plotmin &&_plotmax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),

                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.living_space')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color:ColorConstant.kGreenColor, fontSize: 14),
                                items: livingminlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemliving(valueSelectedByUser);
                                },
                                value: _selectedliving ? livingroomtext : null,

                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_livingmin && _livingmax? Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color:ColorConstant.kGreenColor, fontSize: 14),
                                items: livingmaxlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemliving1(valueSelectedByUser);
                                },
                                value: _selectedliving1 ? livingroomtext1 : null,

                              ),
                            ),
                          ),

                        ],),

                      Visibility(visible: !(_livingmin &&_livingmax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.Rooms')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: roomsminlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemroom(valueSelectedByUser);
                                },
                                value: _selectedroom ? roomtext : null,

                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_roommin&&_roommax?Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: roomsmaxlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemroom1(valueSelectedByUser);
                                },
                                value: _selectedroom1 ? roomtext1 : null,

                              ),
                            ),
                          ),

                        ],),
                      Visibility(visible: !(_roommin &&_roommax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),


                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.bedroom')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:



                              DropdownButton<String>(
                                //
                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: bedroomminlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItembedroom(valueSelectedByUser);
                                },
                                value: _selectedbedroom ? bedroomtext : null,

                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_bedmin&&_bedmax? Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),

                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:



                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: bedroommaxlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItembedroom1(valueSelectedByUser);
                                },
                                value: _selectedbedroom1 ? bedroomtext1 : null,

                              ),
                            ),
                          ),

                        ],),
                      Visibility(visible: !(_bedmin &&_bedmax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.bathroom')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: bathminlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItembathroom(valueSelectedByUser);
                                },
                                value: _selectedbathroom ? bathroomtext : null,

                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_bathmin&&_bathmax? Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),

                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color:
                                ColorConstant.kGreenColor, fontSize: 14),
                                items: bathmaxlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItembathroom1(valueSelectedByUser);
                                },
                                value: _selectedbathroom1 ? bathroomtext1 : null,

                              ),
                            ),
                          ),

                        ],),
                      Visibility(visible: !(_bathmin &&_bathmax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.price')),
                      SizedBox(height: 14,),
                      Row(

                        children: [

                          CustomWidget.getTextsearch(translate('advance_search.min')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color:ColorConstant.kGreenColor, fontSize: 14),
                                items: widget.looking_for=="0"||widget.looking_for=="KAUF"?
                                pricesminlist.map((String stringvalue){
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList():
                                pricesminlistforrental.map((String stringvalue){
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemprice(valueSelectedByUser);
                                },
                                value: _selectedprice ? priceroomtext : null,

                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          CustomWidget.getTextsearch(translate('advance_search.max')+":"),
                          SizedBox(width: 4,),
                          Expanded(
                            child: Container(

                              padding:EdgeInsets.only(left: 10.0,) ,
                              height: 35,
                              decoration: new BoxDecoration(
                                border:_pricemen&&_pricemax? Border.all(width: 2,color: ColorConstant.kGreenColor):Border.all(width: 2,color: Colors.red),
                                borderRadius: BorderRadius.all( Radius.circular(5.0)),

                              ),


                              child:


                              DropdownButton<String>(

                                hint:Text(translate('advance_search.select_text'),style: GoogleFonts.ptSerif(
                                    color: ColorConstant.kGreenColor,fontSize: 16
                                ),),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                underline: SizedBox(),
                                isExpanded: true,
                                elevation: 16,
                                style: TextStyle(color: ColorConstant.kGreenColor, fontSize: 14),
                                items: widget.looking_for=="0"||widget.looking_for=="KAUF"?
                                pricesmaxlist.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList():
                                pricesmaxlistforrental.map((String stringvalue) {
                                  return DropdownMenuItem<String>(
                                    value: stringvalue,
                                    child: Text(stringvalue),
                                  );
                                }).toList(),
                                onChanged: (String valueSelectedByUser) {
                                  _dropDownItemprice1(valueSelectedByUser);
                                },
                                value: _selectedprice1 ? priceroomtext1 : null,

                              ),
                            ),
                          ),


                        ],),
                      Visibility(visible: !(_pricemen &&_pricemax),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget.geterrortext(translate('advance_search.validation_text')),
                          ],),
                      ),
                      SizedBox(height: 20,),
                      Column(

                        children: <Widget>[

                          Row(

                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(

                                    children: <Widget>[
                                      Transform.scale(
                                        scale: 1.4,
                                        child:           Theme(
                                          data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
                                          child: Checkbox(

                                              checkColor: Colors.white,
                                              activeColor: ColorConstant.kGreenColor,
                                              value: _value1,
                                              onChanged: _valueair),
                                        ),
                                      ),

                                      Text(translate('advance_search.airco'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),

                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Transform.scale(
                                        scale: 1.4,
                                        child:           Theme(
                                          data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
                                          child: Checkbox(

                                              checkColor: Colors.white,
                                              activeColor: ColorConstant.kGreenColor,
                                              value: _value2,
                                              onChanged: _valuesea),
                                        ),
                                      ),

                                      Text(translate('advance_search.seaview'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),

                                    ],
                                  )

                                ],),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: <Widget>[
                                      Transform.scale(
                                        scale: 1.4,
                                        child:           Theme(
                                          data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
                                          child: Checkbox(

                                              checkColor: Colors.white,
                                              activeColor: ColorConstant.kGreenColor,
                                              value: _value3,
                                              onChanged: _valueswimming),
                                        ),
                                      ),

                                      Text(translate('advance_search.swimming'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),

                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Transform.scale(
                                        scale: 1.4,
                                        child:Theme(
                                          data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
                                          child: Checkbox(

                                              checkColor: Colors.white,
                                              activeColor: ColorConstant.kGreenColor,
                                              value: _valuetarrace,
                                              onChanged: _valuetarracee),
                                        ),
                                      ),

                                      Text(translate('advance_search.tarrace'),style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),

                                    ],
                                  ),
                                ],)
                            ],

                          ),
                          // Row(children: [
                          //
                          //   SizedBox(width: 10,),
                          //
                          // ],),


                          _submitButton()
                        ],
                      ),
                    ],),
                ),

              ],)
        ),
      ),
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
  bool validation(min, max){


    if(!min.isEmpty&&!max.isEmpty){

      if (int.parse(min)>int.parse(max)) {
        // CustomWidget.showtoast(
        //     context, translate('advance_search.min_max_validation'));
        return false;
      }
    }
    return true;
  }
  bool validationDetails() {

    // sizetext = sizetext.replaceAll(new RegExp(r'[^0-9]'),'');
    // livingroomtext= livingroomtext.replaceAll(new RegExp(r'[^0-9]'),'');
    // roomtext= roomtext.replaceAll(new RegExp(r'[^0-9]'),'');
    // bedroomtext=bedroomtext.replaceAll(new RegExp(r'[^0-9]'),'');
    // bathroomtext=bathroomtext.replaceAll(new RegExp(r'[^0-9]'),'');
    // priceroomtext2=priceroomtext.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",'');
    // priceroomtext3=priceroomtext1.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",'');

    if(!sizetext.isEmpty&&!sizetext1.isEmpty){
      try {
        if (int.parse(sizetext.replaceAll(new RegExp(r'[^0-9]'),''))>int.parse(sizetext1.replaceAll(new RegExp(r'[^0-9]'),''))) {
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }
    if(!livingroomtext.isEmpty&&!livingroomtext1.isEmpty){
      try {
        if (int.parse(livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''))>int.parse(livingroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))) {
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }
    if(!roomtext.isEmpty&&!roomtext1.isEmpty){
      try {
        if (int.parse(roomtext.replaceAll(new RegExp(r'[^0-9]'),''))>int.parse(roomtext1.replaceAll(new RegExp(r'[^0-9]'),''))) {
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }
    if(!bedroomtext.isEmpty&&!bedroomtext1.isEmpty){
      try {
        if (int.parse(bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''))>int.parse(bedroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))) {
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }
    if(!bathroomtext.isEmpty&&!bathroomtext1.isEmpty){
      try {
        if (int.parse(bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''))>int.parse(bathroomtext1.replaceAll(new RegExp(r'[^0-9]'),''))){
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }

    //print(int.parse(priceroomtext2.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",'')));
    if(!priceroomtext.isEmpty&&!priceroomtext1.isEmpty){
      try {
        if (int.parse(priceroomtext.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''))>int.parse(priceroomtext1.replaceAll(new RegExp(r'[^0-9]'),'').replaceAll(".",''))){
          // CustomWidget.showtoast(
          //     context, translate('advance_search.min_max_validation'));
          return false;
        }
      } on FormatException {
        return true;
      }

    }




    return true;
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: (){

        if(validationDetails()){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:widget.countryid,region_name:widget.region_name,location_name:widget.location_name,looking_for:widget.looking_for,property_type:widget.property_type,fromwhere:"advancesearch",plot_size_from:sizetext.isEmpty?"All":sizetext.contains(translate('advance_search.from'))?sizetext.replaceAll(new RegExp(r'[^0-9]'),''):sizetext.contains(translate('advance_search.select_text'))?"All":sizetext.replaceAll(new RegExp(r'[^0-9]'),''),plot_size_to:sizetext1.isEmpty?maxplot.toString():sizetext1.contains(translate('advance_search.select_text'))?maxplot.toString():sizetext1.replaceAll(new RegExp(r'[^0-9]'),''),living_space_from:livingroomtext.isEmpty?"All":livingroomtext.contains(translate(translate('advance_search.from')))?livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''):livingroomtext.contains(translate('advance_search.select_text'))?"All":livingroomtext.replaceAll(new RegExp(r'[^0-9]'),''),living_space_to:livingroomtext1.isEmpty?maxliving.toString():livingroomtext1.contains(translate('advance_search.select_text'))?maxliving.toString():livingroomtext1.replaceAll(new RegExp(r'[^0-9]'),''),rooms_from:roomtext.isEmpty?"All":roomtext.contains(translate(translate('advance_search.from')))?roomtext.replaceAll(new RegExp(r'[^0-9]'),''):roomtext.contains(translate('advance_search.select_text'))?"All":roomtext.replaceAll(new RegExp(r'[^0-9]'),''),rooms_to:roomtext1.isEmpty?maxroom.toString():roomtext1.contains(translate('advance_search.select_text'))?maxroom.toString():roomtext1.replaceAll(new RegExp(r'[^0-9]'),''),bedroom_from:bedroomtext.isEmpty?"All":bedroomtext.contains(translate('advance_search.from'))?bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''):bedroomtext.contains(translate('advance_search.select_text'))?"All":bedroomtext.replaceAll(new RegExp(r'[^0-9]'),''),bedroom_to:bedroomtext1.isEmpty?bedroom.toString():bedroomtext1.contains(translate('advance_search.select_text'))?"All":bedroomtext1.replaceAll(new RegExp(r'[^0-9]'),''),bathroom_from:bathroomtext.isEmpty?"All":bathroomtext.contains(translate(translate('advance_search.from')))?bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''):bathroomtext.contains(translate('advance_search.select_text'))?"All":bathroomtext.replaceAll(new RegExp(r'[^0-9]'),''),bathroom_to:bathroomtext1.isEmpty?maxbathroom.toString():bathroomtext1.contains(translate('advance_search.select_text'))?maxbathroom.toString():bathroomtext1.replaceAll(new RegExp(r'[^0-9]'),''),tarrace_from:_valuetarrace?"1":"0",price_from:priceroomtext.isEmpty?"All":priceroomtext.contains(translate(translate('advance_search.from')))?priceroomtext.replaceAll(new RegExp(r'[^0-9.]'),''):priceroomtext.contains(translate('advance_search.select_text'))?"All":priceroomtext.replaceAll(new RegExp(r'[^0-9.]'),''),price_to:priceroomtext1.isEmpty?maxprice.toString():priceroomtext1.contains(translate('advance_search.select_text'))?maxprice.toString():priceroomtext1.replaceAll(new RegExp(r'[^0-9.]'),''),region_name_real: widget.region_name_real,aircondition: _value1?"1":"0",seaview:_value2?"1":"0",swimmingpool: _value3?"1":"0" ,)));
        }
// if(validationDetails()){
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => SearchListingPage(
//     countryid:widget.countryid,region_name:widget.region_name,location_name:widget.location_name,looking_for:widget.looking_for,property_type:widget.property_type,fromwhere:"advancesearch",plot_size_from:sizetext.isEmpty?"0":sizetext.contains(translate('advance_search.from'))?maxplot.toString():sizetext,plot_size_to:sizetext1.isEmpty?"0":sizetext1,living_space_from:livingroomtext.isEmpty?"0":livingroomtext.contains(translate(translate('advance_search.from')))?maxliving.toString():livingroomtext,living_space_to:livingroomtext1.isEmpty?"0":livingroomtext1,rooms_from:roomtext.isEmpty?"0":roomtext.contains(translate(translate('advance_search.from')))?maxroom.toString():roomtext,rooms_to:roomtext1.isEmpty?"0":roomtext1,bedroom_from:bedroomtext.isEmpty?"0":bedroomtext.contains(translate('advance_search.from'))?maxroom.toString():bedroomtext,bedroom_to:bedroomtext1.isEmpty?"0":bedroomtext1,bathroom_from:bathroomtext.isEmpty?"0":bathroomtext.contains(translate(translate('advance_search.from')))?maxbathroom.toString():bathroomtext,bathroom_to:bathroomtext1.isEmpty?"0":bathroomtext1,tarrace_from:_valuetarrace?"1":"0",price_from:priceroomtext.isEmpty?"0":priceroomtext.contains(translate(translate('advance_search.from')))?maxprice.toString():priceroomtext,price_to:priceroomtext1.isEmpty?"0":priceroomtext1,region_name_real: widget.region_name_real,aircondition: _value1?"1":"0",seaview:_value2?"1":"0",swimmingpool: _value3?"1":"0" ,)));
// }



      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.only(left: 20,right: 20,top:40,bottom: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xffff1d6150)
        ),
        child: Text(
          translate('advance_search.apply'),
          style: GoogleFonts.ptSerif(
              fontSize: 20, color: Colors.white
          ),
        ),
      ),
    );
  }
  void _valueair(bool value) => setState(() => _value1 = value);
  void _valuesea(bool value) => setState(() => _value2 = value);
  void _valueswimming(bool value) => setState(() => _value3 = value);
  void _valuetarracee(bool value) => setState(() => _valuetarrace = value);
}
