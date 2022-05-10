import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
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
import 'package:shared_preferences/shared_preferences.dart';






class EditAdvanceSearch extends StatefulWidget {
  String countryid,region_name,location_name,looking_for,property_type,region_name_real,save_id,propertyname,lookingforid,plotsizefrom,plotsizto,livingfrom,livingto,roomfrom,roomto,bedfrom,bedto,batfrom,bathto,pricefrom,priceto,terrace,aircondition,swiming,seaview;
  EditAdvanceSearch({
    Key key,this.countryid,this.region_name,this.location_name,this.looking_for,this.property_type,this.region_name_real,this.save_id,this.propertyname,this.lookingforid,this.plotsizefrom,this.plotsizto,this.livingfrom,this.livingto,this.batfrom,this.bathto,this.bedto,this.bedfrom,this.seaview,this.aircondition,this.pricefrom,this.priceto,this.roomfrom,this.roomto,this.terrace,this.swiming
  }) : super(key: key);

  @override
  _AdvaceSearchState createState() => _AdvaceSearchState();
}

class _AdvaceSearchState extends State<EditAdvanceSearch> {
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
  TextEditingController fromplot = new TextEditingController();
  TextEditingController toplot = new TextEditingController();

  TextEditingController fromliving = new TextEditingController();
  TextEditingController toliving = new TextEditingController();

  TextEditingController fromroom = new TextEditingController();
  TextEditingController toroom = new TextEditingController();

  TextEditingController frombd = new TextEditingController();
  TextEditingController tobed = new TextEditingController();

  TextEditingController frombath = new TextEditingController();
  TextEditingController tobath = new TextEditingController();

  TextEditingController fromtarrece = new TextEditingController();
  TextEditingController toterrace = new TextEditingController();

  TextEditingController fromprice = new TextEditingController();
  TextEditingController toprice = new TextEditingController();
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
  FavModel user;
  // void _savesearch(BuildContext context) {
  //
  //   Provider.of<LoginProvider>(context, listen: false)
  //       .update_search_property(
  //       widget.countryid,
  //       widget.region_name,
  //       widget.location_name==translate('landing_screen.all')?"0":widget.location_name,
  //       widget.looking_for,
  //       widget.property_type,
  //       sizetext.isEmpty?"0":sizetext.contains("-")?sizetext.split('-')[0].replaceAll(RegExp('m\u00B2'), ''):"0",
  //       sizetext.isEmpty?"0":sizetext.contains("-")?sizetext.split('-')[1].replaceAll(RegExp('m\u00B2'), ''):sizetext.contains(translate('advance_search.from'))?maxplot.toString():sizetext.replaceAll(RegExp('m\u00B2'), ''),
  //       livingroomtext.isEmpty?"0":livingroomtext.contains("-")?livingroomtext.split('-')[0].replaceAll(RegExp('m\u00B2'), ''):"0",
  //       livingroomtext.isEmpty?"0":livingroomtext.contains("-")?livingroomtext.split('-')[1].replaceAll(RegExp('m\u00B2'), ''):livingroomtext.contains(translate('advance_search.more_than'))?maxliving.toString():livingroomtext.replaceAll(RegExp('m\u00B2'), ''),
  //       roomtext.isEmpty?"0":roomtext.contains("-")?roomtext.split('-')[0]:"0",
  //       roomtext.isEmpty?"0":roomtext.contains("-")?roomtext.split('-')[1]:maxroom.toString(),
  //       bedroomtext.isEmpty?"0":bedroomtext.contains("-")?bedroomtext.split('-')[0]:"0",
  //       bedroomtext.isEmpty?"0":bedroomtext.contains("-")?bedroomtext.split('-')[1]:bedroom.toString(),
  //       bathroomtext.isEmpty?"0":bathroomtext.contains("-")?bathroomtext.split('-')[0]:"0",
  //       bathroomtext.isEmpty?"0":bathroomtext.contains("-")?bathroomtext.split('-')[1]:maxbathroom.toString(),
  //       _valuetarrace?"1":"0",
  //       "1",
  //       priceroomtext.isEmpty?"0":priceroomtext.contains( translate('advance_search.until'))?priceroomtext.replaceAll(new RegExp(r'[^0-9]'),''):maxprice.toString(),
  //       "0",
  //       widget.region_name_real,
  //       _value1?"1":"0",
  //       _value2?"1":"0",
  //       _value3?"1":"0", widget.save_id,
  //     widget.propertyname,
  //     widget.lookingforid
  //   )
  //       .then((value) {
  //     if (value) {
  //
  //       DialogUtils.hideProgress(context);
  //
  //       user = Provider.of<LoginProvider>(context, listen: false).getfav();
  //       if(user.status=="success"){
  //         CustomWidget.showtoast(
  //             context, translate('save_search.search_savetoast'));
  //
  //
  //       }
  //
  //     }
  //
  //   });
  //
  // }
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
    //print("${widget.plotsizefrom.toString()}");
    sizetext="${widget.plotsizefrom.toString()+"-"+widget.plotsizto+"m\u00B2"}";
    livingroomtext="${widget.livingfrom.toString()+"-"+widget.livingto+"m\u00B2"}";
    roomtext="${widget.roomfrom.toString()+"-"+widget.roomto}";
    bedroomtext="${widget.bedfrom.toString()+"-"+widget.bedto}";
    bathroomtext="${widget.batfrom.toString()+"-"+widget.bathto}";
    priceroomtext=  "${translate('advance_search.until')+" "+widget.priceto}";
    if(widget.aircondition=="0"){
      _value1=false;
    }
    else{
      _value1=true;
    }
    if(widget.seaview=="0"){
      _value2=false;
    }
    else{
      _value2=true;
    }
    if(widget.swiming=="0"){
      _value3=false;
    }
    else{
      _value3=true;
    }
    if(widget.terrace=="0"){
      _valuetarrace=false;
    }
    else{
      _valuetarrace=true;
    }
    _getplot();
    _getliving();

    _getrooms();
    _getbedrooms();
    _getbathrooms();
    _gettarrcae();
    _getpricerange();

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
                  margin: const EdgeInsets.only(left:22.0,top:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidget.getTextsearch(translate('advance_search.size_plot')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:

                        DropdownButton<String>(

                          hint:Text(widget.plotsizto=="0"?translate('advance_search.select_size'):sizetext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: temlist.map((String stringvalue) {
                            return DropdownMenuItem<String>(
                              value: stringvalue,
                              child: Text(stringvalue),
                            );
                          }).toList(),
                          onChanged: (String valueSelectedByUser) {
                            _dropDownItemSelected(valueSelectedByUser);
                          },
                          value: _selected ? sizetext : null,

                        ),

                      ),

                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.living_space')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0,) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:


                        DropdownButton<String>(

                          hint:Text(widget.livingto=="0"?translate('advance_search.select_living'):livingroomtext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: livingspacelist.map((String stringvalue) {
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
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.Rooms')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0,) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:


                        DropdownButton<String>(

                          hint:Text(widget.roomto=="0"?translate('advance_search.select_room'):roomtext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: roomstaticlist.map((String stringvalue) {
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
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.bedroom')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0,) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:



                        DropdownButton<String>(

                          hint:Text(widget.bedto=="0"?translate('advance_search.select_bed'):bedroomtext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: bedroomstaticlist.map((String stringvalue) {
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
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.bathroom')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0,) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:


                        DropdownButton<String>(

                          hint:Text(widget.bathto=="0"?translate('advance_search.select_bath'):bathroomtext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: bathtaticlist.map((String stringvalue) {
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
                      SizedBox(height: 20,),
                      CustomWidget.getTextsearch(translate('advance_search.price')),
                      SizedBox(height: 8,),
                      Container(

                        padding:EdgeInsets.only(left: 10.0,) ,
                        height: 40,
                        decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: ColorConstant.kGreenColor),
                          borderRadius: BorderRadius.all( Radius.circular(5.0)),

                        ),


                        child:


                        DropdownButton<String>(

                          hint:Text(widget.priceto=="0"?translate('advance_search.select_price'):priceroomtext,style: GoogleFonts.ptSerif(
                              color: ColorConstant.kGreenColor,fontSize: 18
                          ),),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          underline: SizedBox(),
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          items: pricestaticlist.map((String stringvalue) {
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
                      SizedBox(height: 20,),
                      Column(

                        children: <Widget>[
                          Row(children: [
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
                            SizedBox(width: 10,),
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
                          ],
                          ),
                          Row(children: [
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
                            SizedBox(width: 10,),
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
                          ],),


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
  // bool valuechecker(firstvalue,secondvalue){
  //
  //
  //   if(firstvalue.toString().length==0){
  //     FocusScope.of(context).requestFocus(new FocusNode());
  //     CustomWidget.showtoast(
  //         context, "fill from value ");
  //     toplot.text="";
  //     return false;
  //   }
  //   else{
  //     int i = int.parse(firstvalue.toString());
  //
  //
  //     int j =int.parse(secondvalue.toString());
  //     if(((j >= i))){
  //       setState(() {
  //         FocusScope.of(context).requestFocus(new FocusNode());
  //         CustomWidget.showtoast(
  //             context, "To value can not be greater than from value ");
  //         toplot.text="";
  //       });
  //       return false;
  //     }
  //
  //   }
  //
  //
  //   return true;
  // }
  bool validationDetails() {


    if (sizetext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.plot_size'));
      return false;
    }
    else if (livingroomtext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.toast_living'));
      return false;
    }

    else if (roomtext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.toast_room'));
      return false;
    }
    else if (bedroomtext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.tost_bedroom'));
      return false;
    }
    else if (bathroomtext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.toast_bath'));
      return false;
    }
    // else if (tarrecetext=='') {
    //   CustomWidget.showtoast(
    //       context, "please fill tarrace");
    //   return false;
    // }
    else if (priceroomtext=='') {
      CustomWidget.showtoast(
          context, translate('advance_search.toast_price'));
      return false;
    }
    return true;
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        Provider.of<LoginProvider>(context, listen: false)
            .setLoading(true);
        if( Provider.of<LoginProvider>(context, listen: false)
            .isLoading()){
          DialogUtils.showProgress(context);
          //_savesearch(context);

        }





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
          translate('drawer_lng.save_search'),
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
