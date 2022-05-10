
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/search/item_detail_screen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:kensington/utils/model/data_model.dart';
import 'package:provider/provider.dart';

import '../color_constants.dart';


class ImageWidgetFAv extends StatelessWidget {

  Result house;
  int imgpath_index;
  List<String> imageList;
  String fromscreen;

  ImageWidgetFAv(
    this.house,
    this.imgpath_index,


  );
  FavModel user;


  void deleteFavroite(property_id,BuildContext context) {

    Provider.of<LoginProvider>(context, listen: false)
        .delete_favorite_property(property_id)
        .then((value) {
      if (value) {

        DialogUtils.hideProgress(context);

        user = Provider.of<LoginProvider>(context, listen: false).getfav();
        if(user.status=="200"){

          CustomWidget.showtoast(
              context, "Favorite Property delete Successfully");
        }

      }

    });

  }
  @override
  Widget build(BuildContext context) {

    final oCcy = new NumberFormat("##,##,###", "en_INR");
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(house.imglist);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailScreen(
                  properyid: house.vtObjektnrExtern,

                ),
              ),
            );
          },
          child:
            Container(

              width: screenWidth,
              margin: EdgeInsets.only(left: 12, right: 12),
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),



                // DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage(
                //  ApiClient.BASE_URL+house.folder+ApiClient.Last_IMAGE_URL
                //   ),
                // ),
              ),
              child:
              Stack(

                children: [
                FadeInImage.assetNetwork(
                  placeholder: "assets/images/house_1.png",
                  image: ApiClient.BASE_URL+house.folder+ApiClient.Last_IMAGE_URL,
                  height:230 ,
                  width: screenWidth ,
                  fit: BoxFit.fill,
                ),
                  Align(
                 alignment: Alignment.topRight,
                  child:  Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 10
                      ),
                      child:
                      GestureDetector(
                        onTap: (){
                          Provider.of<LoginProvider>(context, listen: false)
                              .setLoading(true);
                          if( Provider.of<LoginProvider>(context, listen: false)
                              .isLoading()){
                            DialogUtils.showProgress(context);
                            deleteFavroite(house.vtObjektnrExtern,context);
                          }
                        },
                        child: Icon(

                          Icons.favorite,
                          size: 26.0,
                          color: Colors.white,
                        ),
                      ),

                    ),

                )

    ],)

              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         top: 10,
              //       ),
              //       child:
              //       Icon(
              //         Icons.favorite_border,
              //         size: 26.0,
              //         color: Colors.white,
              //       ),
              //
              //     ),
              //   ],
              // ),
            ),

        ),

       Container(
         margin: EdgeInsets.only(left: 12, right: 12,top:5),
         padding: EdgeInsets.only(left: 12, right: 12),
           child:
           Row(

             children: [

               Text(
                 "\u2022 " +
                     house.flWohnflaeche.toString() +
                     " m\u00B2",
                 style:   GoogleFonts.ptSerif(
                     fontSize: 15, color: ColorConstant.kGreyColor
                 ),
               ),
               SizedBox(width: 15,),
               Text(
                 "\u2022 " +
                     house.flAnzahlSchlafzimmer.toString() +
                     " bedrooms" ,
                 style:   GoogleFonts.ptSerif(
                     fontSize: 15, color: ColorConstant.kGreyColor
                 ),
               ),
               SizedBox(width: 15,),
               Expanded(
                 child: Text(

                   "\u2022 " +
                       house.prKaufpreis.toString() +
                       " Rs" ,
                   style:   GoogleFonts.ptSerif(
                       fontSize: 15, color: ColorConstant.kGreyColor
                   ),
                   softWrap: true,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
             ],),


       ),


          Container(
            margin: EdgeInsets.only(left: 12, right: 12,top:5),
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    house.geoOrt.toString(),
                    style: GoogleFonts.ptSerif(
                      fontSize: 20,
                      color: ColorConstant.kGreenColor

                    ),
                  ),
                ),


              ],
            ),
          ),




          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(

                    house.ftObjekttitel.toString(),
                    style: GoogleFonts.ptSerif(
                        fontSize: 15,
                        color: ColorConstant.kGreyColor

                    ),
                  ),
                ),


              ],
            ),
          ),


      ],
    );
  }
}
