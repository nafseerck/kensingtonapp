// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kensington/model/LoginResponse.dart';
// import 'package:kensington/model/SaveSearchModel.dart';
// import 'package:kensington/model/SearchModel.dart';
// import 'package:kensington/networkapi/ApiClient.dart';
// import 'package:kensington/pages/search/SearchListingPage.dart';
// import 'package:kensington/provider/LoginProvider.dart';
// import 'package:kensington/utils/ColorLoader3.dart';
// import 'package:kensington/utils/DialogUtil.dart';
// import 'package:kensington/utils/color_constants.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:kensington/utils/cus_widget/image_widget.dart';
// import 'package:kensington/utils/custom_widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// class AddSaveSearch extends StatefulWidget {
//   String saveserchfrom;
//   AddSaveSearch({
//     Key key
//   }) : super(key: key);
//
//   @override
//   SearchListingPageState createState() => SearchListingPageState();
// }
// class SearchListingPageState extends State<AddSaveSearch> {
//
//   Map<dynamic, dynamic> data;
//   List result;
//   List<Result> searchlist ;
//   SearchModel _searchModel;
//   SaveSearchModel _saveSearchModel;
//   List<Result1> savesearchlist ;
//   Future gersearchresult () async{
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .saved_result()
//         .then((value) {
//       if (value) {
//         if (mounted) {
//           setState(() {
//             _saveSearchModel = Provider.of<LoginProvider>(context, listen: false).getsaveresult();
//             if (_saveSearchModel.status == "success") {
//               savesearchlist=_saveSearchModel.result;
//
//
//             }
//           });
//         }
//
//
//
//       }
//     });
//   }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     showDemoActionSheet();
//     gersearchresult();
//   }
//   void showDemoActionSheet() {
//
//     Provider.of<LoginProvider>(context, listen: false)
//         .mainlanguage()
//         .then((value) {
//
//       setState(() {
//         changeLocale(context, value);
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: ColorConstant.kWhiteColor,
//       ),
//     );
//     return Scaffold(
//       backgroundColor: ColorConstant.kWhiteColor,
//       appBar:widget.saveserchfrom=="sidedrawer"?CustomWidget.getappbar(context):null,
//       body: Container(
//         child:
//         savesearchlist == null
//             ? Align(
//
//             alignment: Alignment.center,
//             child: ColorLoader3(radius: 20.0, dotRadius: 6.0)) :savesearchlist.length==0?Align(child:
//
//         Text(
//           translate('save_search.no_save'),
//           style:    GoogleFonts.ptSerif(
//               fontSize: 20, color: ColorConstant.kGreenColor
//           ),)
//           ,alignment: Alignment.center,)
//             :
//         Padding(
//             padding: const EdgeInsets.only(
//               left: 15,
//               right: 15,
//               top: 8,
//             ),
//             child:
//             ListView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: savesearchlist.length , // Add one more item for progress indicator
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: (){
//                     Navigator.push(
//                         context, MaterialPageRoute(builder: (context) => SearchListingPage(countryid:savesearchlist[index].countryId,region_name:savesearchlist[index].regionId,location_name:savesearchlist[index].locationName,looking_for:savesearchlist[index].lookingFor,property_type:savesearchlist[index].propertyType,fromwhere: "mainsearch",region_name_real: savesearchlist[index].regionName,)));
//                   },
//                   child: new Container(
//                     margin: EdgeInsets.only(bottom:5),
//                     padding: EdgeInsets.all(5),
//                     decoration: new BoxDecoration(
//                       border: Border.all(width: 2,color: ColorConstant.kGreenColor),
//                       borderRadius: BorderRadius.all( Radius.circular(5.0)),
//
//                     ),
//                     child:  Column(children: [
//                       Row(
//                         children: [
//                           CustomWidget.getTextmedium(translate('save_search.country_save')+": "),
//                           CustomWidget.getTextmedium(savesearchlist[index].countryName+", "),
//                           CustomWidget.getTextmedium(translate('save_search.region_save')+"  : "),
//                           CustomWidget.getTextmedium(savesearchlist[index].regionName+", ")
//                         ],
//
//                       ),
//                       Row(
//                         children: [
//                           CustomWidget.getTextmedium(translate('save_search.location_save')+": "),
//                           CustomWidget.getTextmedium(savesearchlist[index].locationName=="0"?translate('landing_screen.all')+", ":savesearchlist[index].locationName+", "),
//                           CustomWidget.getTextmedium(translate('save_search.lokking_forsave')+": "),
//                           CustomWidget.getTextmedium(savesearchlist[index].lookingFor=="0"?translate('landing_screen.all')+", ":savesearchlist[index].lookingFor+", "),
//
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           CustomWidget.getTextmedium(translate('save_search.pro_save')+": "),
//                           Expanded(child: CustomWidget.getTextmedium(savesearchlist[index].propertyType=="0"?translate('landing_screen.all')+"":savesearchlist[index].propertyType+","))
//
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           CustomWidget.getTextsmall(translate('save_search.search_save')+": "),
//                           CustomWidget.getTextsmall(savesearchlist[index].createdAt),
//
//                         ],
//                       ),
//                     ]
//                     ),),
//                 );
//
//
//               },
//
//             )
//         ),
//       ),
//     );
//   }
//
//
//
// }
//
