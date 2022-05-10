import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kensington/model/PropertDetailModel.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../color_constants.dart';


class HouseWidget extends StatelessWidget {
  ResultProperty house;
  String region_name;

  HouseWidget({
    this.house,
    this.region_name

  });

  void showDemoActionSheet(BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {

      changeLocale(context, value);
    });
  }
  @override
  Widget build(BuildContext context) {
    showDemoActionSheet(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

         Visibility(
           visible:house.vtObjektnrExtern==null?false:house.vtObjektnrExtern==""?false:true ,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Icon(
                   Icons.arrow_forward_ios,
                   size: 10.0,
                   color: Colors.grey,
                 ),
                 SelectableText(
                   translate('item_detail.ref')+": ",
                   style: GoogleFonts.ptSerif(
                     fontSize: 16,
                     color: ColorConstant.kGreyColor,
                   ),
                 ),

                 SelectableText(
                   house.vtObjektnrExtern,
                   style: GoogleFonts.ptSerif(
                     fontSize: 16,
                     color:ColorConstant.kGreenColor,

                   ),
                 ),


               ],
             ),
           ],),
         ),
        Visibility(
          visible:house.katObjektart2==null?false:house.katObjektart2==""?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.propertytype')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.katObjektart2,
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prKaufpreis==null?false:house.prKaufpreis==""?false:house.prKaufpreis=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.netrent')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                      house.prKaufpreis!=null?  "€ "+NumberFormat.currency(locale: 'es',symbol: "").format(double.parse(house.prKaufpreis)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       children: [
        //         Icon(
        //           Icons.arrow_forward_ios,
        //           size: 10.0,
        //           color: Colors.grey,
        //         ),
        //         Text(
        //           "Deposits"+": ",
        //           style: GoogleFonts.ptSerif(
        //             fontSize: 16,
        //             color: ColorConstant.kGreyColor,
        //           ),
        //         ),
        //
        //         Text(
        //           house.flWohnflaeche!=null? house.flWohnflaeche:"",
        //           style: GoogleFonts.ptSerif(
        //             fontSize: 16,
        //             color:ColorConstant.kGreenColor,
        //
        //           ),
        //         ),
        //
        //
        //       ],
        //     ),
        //   ],),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10.0,
                  color: Colors.grey,
                ),
                SelectableText(
                  translate('item_detail.region')+": ",
                  style: GoogleFonts.ptSerif(
                    fontSize: 16,
                    color: ColorConstant.kGreyColor,
                  ),
                ),

                SelectableText(
                 region_name!=null?region_name=="All"?house.geoOrt:region_name:'',
                  style: GoogleFonts.ptSerif(
                    fontSize: 16,
                    color:ColorConstant.kGreenColor,

                  ),
                ),


              ],
            ),
          ],),
        Visibility(
          visible:house.zaBaujahr==null?false:house.zaBaujahr==""?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.yrconstr')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.zaBaujahr,
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flBalkonTerrasseFlaeche==null?false:house.flBalkonTerrasseFlaeche==""?false:house.flBalkonTerrasseFlaeche=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.sizeb')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flBalkonTerrasseFlaeche!=null?NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(house.flBalkonTerrasseFlaeche)):"",


                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlZimmer==null?false:house.flAnzahlZimmer==""?false:house.flAnzahlZimmer=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('advance_search.Rooms')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flAnzahlZimmer,
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlSchlafzimmer==null?false:house.flAnzahlSchlafzimmer==""?false:house.flAnzahlSchlafzimmer=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('advance_search.bedroom')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flAnzahlSchlafzimmer,
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlBadezimmer==null?false:house.flAnzahlBadezimmer==""?false:house.flAnzahlBadezimmer=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('advance_search.bathroom')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  Text(
                    house.flAnzahlBadezimmer,
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlTerrassen==null?false:house.flAnzahlTerrassen==""?false:house.flAnzahlTerrassen=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('advance_search.tarrace')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  Text(
                    house.flAnzahlTerrassen!=null?house.flAnzahlTerrassen:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prStpGarageAnzahl==null?false:house.prStpGarageAnzahl==""?false:house.prStpGarageAnzahl=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.garrage')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.prStpGarageAnzahl!=null?   house.prStpGarageAnzahl:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),

        Visibility(
          visible:house.prKaltmiete==null?false:house.prKaltmiete==""?false:house.prKaltmiete=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.net_rent')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                      house.prKaltmiete!=null? "€ "+NumberFormat.currency(locale: 'es',symbol: "").format(double.parse(house.prKaltmiete)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prWarmmiete==null?false:house.prWarmmiete==""?false:house.prWarmmiete=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.heating')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.prWarmmiete!=null?   house.prWarmmiete:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prNebenkosten==null?false:house.prNebenkosten==""?false:house.prNebenkosten=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.utility')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.prNebenkosten!=null?   house.prNebenkosten:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prStpGarageKaufpreis==null?false:house.prStpGarageKaufpreis==""?false:house.prStpGarageKaufpreis=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.purchase_price')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(

                    house.prStpGarageKaufpreis!=null?  "€ "+ NumberFormat.currency(locale: 'es',symbol: "").format(double.parse(house.prStpGarageKaufpreis)):"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),

        Visibility(
          visible:house.prHausgeld==null?false:house.prHausgeld==""?false:house.prHausgeld=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.condo_fee')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.prHausgeld!=null?  "€ "+ NumberFormat.currency(locale: 'es',symbol: "").format(double.parse(house.prHausgeld)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlStellplaetze==null?false:house.flAnzahlStellplaetze==""?false:house.flAnzahlStellplaetze=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.parking_lot')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flAnzahlStellplaetze!=null?   house.flAnzahlStellplaetze:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flWohnflaeche==null?false:house.flWohnflaeche==""?false:house.flWohnflaeche=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.living_area')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                      house.flWohnflaeche!=null? NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(house.flWohnflaeche)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flNutzflaeche==null?false:house.flNutzflaeche==""?false:house.flNutzflaeche=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.const_area')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                   house.flNutzflaeche!=null? NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(house.flNutzflaeche)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.prStpTiefgarageAnzahl==null?false:house.prStpTiefgarageAnzahl==""?false:house.prStpTiefgarageAnzahl=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.underground_lot')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.prStpTiefgarageAnzahl!=null?   house.prStpTiefgarageAnzahl:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.voGewerblicheNutzung==null?false:house.voGewerblicheNutzung==""?false:house.voGewerblicheNutzung=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.commerial_use')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.voGewerblicheNutzung!=null?   house.voGewerblicheNutzung=="1"?"Yes":"No":"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flAnzahlBalkone==null?false:house.flAnzahlBalkone==""?false:house.flAnzahlBalkone=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(
                    translate('item_detail.balcony')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flAnzahlBalkone!=null?   house.flAnzahlBalkone:"",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),
        Visibility(
          visible:house.flGrundstuecksflaeche==null?false:house.flGrundstuecksflaeche==""?false:house.flGrundstuecksflaeche=="0.00"?false:true ,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.0,
                    color: Colors.grey,
                  ),
                  SelectableText(

                    translate('item_detail.plotsize')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                  SelectableText(
                    house.flGrundstuecksflaeche!=null?NumberFormat.currency(locale: 'es',symbol: "m\u00B2").format(double.parse(house.flGrundstuecksflaeche)):"",

                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color:ColorConstant.kGreenColor,

                    ),
                  ),


                ],
              ),
            ],),
        ),

        Visibility(
          visible:house.prProvisionAussen==null?false:house.prProvisionAussen==""?false:house.prProvisionAussen=="0.00"?false:true ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  //
                  //   height: 2.0,
                  //   width: 2.0,
                  //   child:    Icon(
                  //     Icons.arrow_forward_ios,
                  //
                  //     color: Colors.grey,
                  //   ),
                  // ),



                       Padding(
                         padding: const EdgeInsets.only(top:6.0),
                         child: Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Colors.grey,
                    ),
                       ),



                  Text(
                    translate('item_detail.buyer_comm')+": ",
                    style: GoogleFonts.ptSerif(
                      fontSize: 16,
                      color: ColorConstant.kGreyColor,
                    ),
                  ),

                 Flexible(
                   child: Text(
                        house.prProvisionAussen!=null?   house.prProvisionAussen:"",
                        style: GoogleFonts.ptSerif(
                          fontSize: 16,
                          color:ColorConstant.kGreenColor,

                        ),


                      ),
                 ),

       //            Expanded(
       //              child: Text.rich(
       //
       //                TextSpan(children: <TextSpan>
       //                [
       //                  TextSpan(
       //                      text:
       // translate('item_detail.buyer_comm')+": ",
       // style: GoogleFonts.ptSerif(
       //   fontSize: 16,
       //   color: ColorConstant.kGreyColor,
       // ),),
       //                  TextSpan(
       //                      text:
       //     house.prProvisionAussen!=null?   house.prProvisionAussen+"hhfhffhrf":"",
       //     style: GoogleFonts.ptSerif(
       //       fontSize: 16,
       //       color:ColorConstant.kGreenColor,
       //
       //     ),),
       //                ]
       //                ),
       //              ),
       //            ),

                ],
              ),
            ],),
        ),





      ],
    );
  }
}
