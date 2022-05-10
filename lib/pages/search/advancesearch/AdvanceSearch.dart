// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kensington/apppreferences/PreferncesApp.dart';
// import 'package:kensington/model/LivingResponse.dart';
// import 'package:kensington/model/LoginResponse.dart';
// import 'package:kensington/model/PriceRange.dart';
// import 'package:kensington/model/SearchAmeeResponse.dart';
// import 'package:kensington/model/SearchRangeModel.dart';
// import 'package:kensington/networkapi/ApiClient.dart';
// import 'package:kensington/pages/auth/Forget.dart';
// import 'package:kensington/pages/dashboard/Dashboard_page.dart';
// import 'package:kensington/provider/LoginProvider.dart';
// import 'package:kensington/utils/DialogUtil.dart';
// import 'package:kensington/utils/color_constants.dart';
// import 'package:kensington/utils/custom_widgets.dart';
// import 'package:provider/provider.dart';
//
//
//
//
//
// class AdvaceSearch extends StatefulWidget {
//   AdvaceSearch({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _AdvaceSearchState createState() => _AdvaceSearchState();
// }
//
// class _AdvaceSearchState extends State<AdvaceSearch> {
//   SearchRangeModel searchRangeModel;
//   LivingResponse _livingResponse;
//   PriceRange _priceRange;
//   PriceResult _priceResult;
//   LivingResult _livingResult;
//   Result _result;
//   SearchAmeeResponse _searchAmeeResponse;
//   var maxplot=0.0,minplot=0.0;
//   var maxliving=0.0,minliving=0.0;
//   var maxprice=0.0,minprice=0.0;
//   var maxroom=0.0;
//   var maxbathroom=0.0;
//   var bedroom=0.0;
//   var trraceroom=0.0;
//   void _getplot() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchserch()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         searchRangeModel = Provider.of<LoginProvider>(context, listen: false).getsearch();
//         if(searchRangeModel.status=="success"){
//
//
//
//      setState(() {
//
//        _result=searchRangeModel.result;
//
//        maxplot=double.parse(_result.maximumPlotSize);
//        minplot=double.parse(_result.minimumPlotSize);
//      });
//
//         }
//
//       }
//
//     });
//
//   }
//   void _getliving() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchLiving()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         _livingResponse = Provider.of<LoginProvider>(context, listen: false).getlivingspace();
//         if(_livingResponse.status=="success"){
//
//
//
//           setState(() {
//
//             _livingResult=_livingResponse.result;
//
//             maxliving=double.parse(_livingResult.maximumLivingSpace);
//             minliving=double.parse(_livingResult.minimumLivingSpace);
//           });
//
//         }
//
//       }
//
//     });
//
//   }
//   void _getrooms() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchrooms()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
//         if(_searchAmeeResponse.status=="success"){
// setState(() {
//   maxroom=double.parse(_searchAmeeResponse.result);
// });
//         }
//
//       }
//
//     });
//
//   }
//   void _getbedrooms() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchbedrroms()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
//         if(_searchAmeeResponse.status=="success"){
//           setState(() {
//             bedroom=double.parse(_searchAmeeResponse.result);
//           });
//         }
//
//       }
//
//     });
//
//   }
//   void _getbathrooms() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchbathrooms()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
//         if(_searchAmeeResponse.status=="success"){
//           setState(() {
//             maxbathroom=double.parse(_searchAmeeResponse.result);
//           });
//         }
//
//       }
//
//     });
//
//   }
//   void _gettarrcae() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .fetchterrace()
//         .then((value) {
//       if (value) {
//         DialogUtils.hideProgress(context);
//
//         _searchAmeeResponse = Provider.of<LoginProvider>(context, listen: false).getAmmen();
//         if(_searchAmeeResponse.status=="success"){
//           setState(() {
//             trraceroom=double.parse(_searchAmeeResponse.result);
//           });
//         }
//
//       }
//
//     });
//
//   }
//   Map<dynamic, dynamic> data;
//   List result;
//
//   Future _getpricerange() async {
//
//
//     var response = await http.get(
//       Uri.encodeFull(ApiClient.BASE_URL + "pricerange.php"),
//     );
//     this.setState(() {
//       data = json.decode(response.body);
//       String msg = data["status"];
//       if(msg=="success"){
//         var prieresiult=data["result"];
//         maxprice=double.parse(prieresiult["maximum_price"]);
//         minprice=double.parse(prieresiult["minimum_price"]);
//         print(data);
//       }
//
//
//     });
//     return "Success";
//   }
//   double _lowerValue ;
//   double _upperValue;
//   int selectedIndexroom = -1;
//   bool _value1 = false;
//   bool _value2 = false;
//   bool _value3 = false;
//   RangeValues rangeValuesplot=RangeValues(0.0, 100.0);
//   RangeValues rangeValueslivingspace=RangeValues(0.0, 100.0);
//   final List<String> room = <String>['Any', '1+', '2+', '3+','4+'];
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getplot();
//     _getliving();
//     _getpricerange();
//     _getrooms();
//     _getbedrooms();
//     _getbathrooms();
//     _gettarrcae();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     double _lowerValue = 0.0;
//     double _upperValue = 100.0;
//    return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar:CustomWidget.getappbar(context),
//       body: SingleChildScrollView(
//      child: Padding(
//      padding: const EdgeInsets.only(
//      left: 15,
//      right: 15,
//      top: 10,
//    ),
//        child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       CustomWidget.getheading1("Apply advance search"),
// Container(
//   margin: const EdgeInsets.only(left:22.0,top:20),
//   child:   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     CustomWidget.getTextsearch("Size of plot"),
//   FlutterSlider(
//     values: [minplot,maxplot],
//     max: maxplot,
//     min: minplot,
//     rangeSlider: true,
//     tooltip: FlutterSliderTooltip(
//       boxStyle: FlutterSliderTooltipBox(
//           decoration: BoxDecoration(
//
//           )
//       ),
//       alwaysShowTooltip: true,
//       textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//       format: (String value) {
//         return value + ' m\u00B2';
//       },
//       positionOffset: FlutterSliderTooltipPositionOffset(
// top: 50
//
//
//       ),
//     ),
//     trackBar: FlutterSliderTrackBar(
//
//       activeTrackBarHeight: 8,
//       inactiveTrackBarHeight: 8,
//
//       inactiveTrackBar: BoxDecoration(
//
//         color: ColorConstant.edittextcolor,
//
//       ),
//       activeTrackBar: BoxDecoration(
//
//           color: ColorConstant.kGreenColor),
//
//     ),
//   handler: FlutterSliderHandler(
//
//   decoration: BoxDecoration(),
//   child:
//      Container(
//         padding: EdgeInsets.all(4),
//        decoration:BoxDecoration(
//
//          borderRadius: BorderRadius.circular(20),
//          color: Colors.white,
//          border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//        ),
//
//     ),
//
//
// ),
//       rightHandler: FlutterSliderHandler(
//
//         decoration: BoxDecoration(),
//         child:
//         Container(
//           padding: EdgeInsets.all(4),
//           decoration:BoxDecoration(
//
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//             border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//           ),
//
//         ),
//
//
//       ),
//      ),
//       SizedBox(height: 15,),
//       CustomWidget.getTextsearch("Size of living space"),
//       FlutterSlider(
//         values: [minliving,maxliving],
//         max: maxliving,
//         min: minliving,
//
//         rangeSlider: true,
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           format: (String value) {
//             return value + '\tm\u00B2';
//           },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//         rightHandler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//       ),
//       SizedBox(height: 18,),
//       CustomWidget.getTextsearch("Rooms"),
//       FlutterSlider(
//         values: [maxroom],
//         max: maxroom,
//         min: 0,
//
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           // format: (String value) {
//           //   return value + ' m\u00B2';
//           // },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//
//       ),
//       SizedBox(height: 18,),
//       CustomWidget.getTextsearch("Bedrooms"),
//       // Container(
//       //   height: 32,
//       //
//       //   margin: EdgeInsets.only( top: 5),
//       //   child: ListView.builder(
//       //     scrollDirection: Axis.horizontal,
//       //     itemCount: room.length,
//       //     itemBuilder: (BuildContext context, int position) {
//       //       return InkWell(
//       //         onTap: () => setState(() => selectedIndexroom = position),
//       //         child: Container(
//       //           width: 70,
//       //           child: Container(
//       //
//       //               decoration: (selectedIndexroom == position)
//       //                   ? new BoxDecoration(
//       //                 border: Border.all(width: 2, color: ColorConstant.kGreenColor),
//       //                 color: ColorConstant.kGreenColor,
//       //                 // borderRadius:
//       //                 // (selectedIndexroom == 0)?
//       //                 // BorderRadius.only(
//       //                 //   topRight: Radius.circular(0.0),
//       //                 //   topLeft: Radius.circular(15.0),
//       //                 //   bottomRight: Radius.circular(0.0),
//       //                 //   bottomLeft: Radius.circular(15.0),
//       //                 // ):selectedIndexroom==room.length-1? BorderRadius.only(
//       //                 //   topRight: Radius.circular(15.0),
//       //                 //   topLeft: Radius.circular(0.0),
//       //                 //   bottomRight: Radius.circular(15.0),
//       //                 //   bottomLeft: Radius.circular(0.0),
//       //                 // )
//       //                 //     : BorderRadius.only(
//       //                 //   topRight: Radius.circular(0.0),
//       //                 //   topLeft: Radius.circular(0.0),
//       //                 //   bottomRight: Radius.circular(0.0),
//       //                 //   bottomLeft: Radius.circular(0.0),
//       //                 // ),
//       //               )
//       //                   : BoxDecoration(
//       //                 color: Colors.white,
//       //                 border: Border.all(width: 2, color: ColorConstant.kGreenColor),
//       //                 borderRadius:BorderRadius.only(
//       //                   topRight: Radius.circular(0.0),
//       //                   topLeft: Radius.circular(0.0),
//       //                   bottomRight: Radius.circular(0.0),
//       //                   bottomLeft: Radius.circular(0.0),
//       //                 ),
//       //
//       //               ),
//       //               child: new Center(
//       //                   child: Text(
//       //                     room[position],
//       //                     style:    GoogleFonts.ptSerif(color:selectedIndexroom == position?Colors.white:ColorConstant.kGreenColor),
//       //                   ))),
//       //         ),
//       //       );
//       //     },
//       //   ),
//       // ),
//
//
//
//       FlutterSlider(
//         values: [bedroom],
//         max: bedroom,
//         min: 0,
//
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           // format: (String value) {
//           //   return value + ' m\u00B2';
//           // },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//
//       ),
//       SizedBox(height: 18,),
//       CustomWidget.getTextsearch("Bathrooms"),
//       FlutterSlider(
//         values: [maxbathroom],
//         max: maxbathroom,
//         min: 0,
//
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           // format: (String value) {
//           //   return value + ' m\u00B2';
//           // },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//
//       ),
//       SizedBox(height: 18,),
//       CustomWidget.getTextsearch("Tarrace"),
//       FlutterSlider(
//         values: [trraceroom],
//         max: trraceroom,
//         min: 0,
//
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           // format: (String value) {
//           //   return value + ' m\u00B2';
//           // },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//
//       ),
//       SizedBox(height: 15,),
//       Column(
//
//         children: <Widget>[
//         Row(children: [
//           Row(
//             children: <Widget>[
//               Transform.scale(
//                 scale: 1.4,
//                 child:           Theme(
//                   data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
//                   child: Checkbox(
//
//                       checkColor: Colors.white,
//                       activeColor: ColorConstant.kGreenColor,
//                       value: _value1,
//                       onChanged: _valueair),
//                 ),
//               ),
//
//               Text('Air condition',style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
//
//             ],
//           ),
//           SizedBox(width: 10,),
//           Row(
//             children: <Widget>[
//               Transform.scale(
//                 scale: 1.4,
//                 child:           Theme(
//                   data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
//                   child: Checkbox(
//
//                       checkColor: Colors.white,
//                       activeColor: ColorConstant.kGreenColor,
//                       value: _value2,
//                       onChanged: _valuesea),
//                 ),
//               ),
//
//               Text('Sea View',style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
//
//             ],
//           )
//         ],
//         ),
//           Row(
//             children: <Widget>[
//               Transform.scale(
//                 scale: 1.4,
//                 child:           Theme(
//                   data: ThemeData(unselectedWidgetColor: ColorConstant.kGreenColor),
//                   child: Checkbox(
//
//                       checkColor: Colors.white,
//                       activeColor: ColorConstant.kGreenColor,
//                       value: _value3,
//                       onChanged: _valueswimming),
//                 ),
//               ),
//
//               Text('Swimming pool',style: GoogleFonts.ptSerif(fontSize: 15,color: ColorConstant.kGreenColor,)),
//
//             ],
//           )
//         ],
//       ),
//       SizedBox(height: 15,),
//       CustomWidget.getTextsearch("Price range"),
//       FlutterSlider(
//         values: [minprice,maxprice],
//         max: maxprice,
//         min: minprice,
//         rangeSlider: true,
//         tooltip: FlutterSliderTooltip(
//           boxStyle: FlutterSliderTooltipBox(
//               decoration: BoxDecoration(
//
//               )
//           ),
//           alwaysShowTooltip: true,
//           textStyle: GoogleFonts.ptSerif(fontSize: 18, color: ColorConstant.kGreyColor),
//           format: (String value) {
//             return '\u{20B9} '+value;
//           },
//           positionOffset: FlutterSliderTooltipPositionOffset(
//               top: 50
//
//
//           ),
//         ),
//         trackBar: FlutterSliderTrackBar(
//
//           activeTrackBarHeight: 8,
//           inactiveTrackBarHeight: 8,
//
//           inactiveTrackBar: BoxDecoration(
//
//             color: ColorConstant.edittextcolor,
//
//           ),
//           activeTrackBar: BoxDecoration(
//
//               color: ColorConstant.kGreenColor),
//
//         ),
//         handler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//         rightHandler: FlutterSliderHandler(
//
//           decoration: BoxDecoration(),
//           child:
//           Container(
//             padding: EdgeInsets.all(4),
//             decoration:BoxDecoration(
//
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               border: Border.all(width: 3, color: ColorConstant.kGreenColor),
//             ),
//
//           ),
//
//
//         ),
//       ),
//       _submitButton()
//   ],),
// ),
//
//       ],)
//     ),
//     ),
//    );
//
//   }
//
//
//
//   Widget _submitButton() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 15),
//       margin: EdgeInsets.only(left: 20,right: 20,top:40,bottom: 30),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: Color(0xffff1d6150)
//       ),
//       child: Text(
//         'Apply',
//         style: GoogleFonts.ptSerif(
//             fontSize: 20, color: Colors.white
//         ),
//       ),
//     );
//   }
//   void _valueair(bool value) => setState(() => _value1 = value);
//   void _valuesea(bool value) => setState(() => _value2 = value);
//   void _valueswimming(bool value) => setState(() => _value3 = value);
// }
