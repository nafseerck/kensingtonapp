import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';

class FullscreenSliderDemo extends StatelessWidget {
  List<String> imageListslider;
  FullscreenSliderDemo({
    Key key,this.imageListslider
  }) : super(key: key);

  int imgpath_index=0;
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:CustomWidget.getappbar1(context),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return  Container(

            padding: EdgeInsets.only(top: 0, bottom: 10),
            child: Container(


              child: Carousel(

                images: [
                  for (int i = 0; i < imageListslider.length; i++)
                     Container(

                      decoration: new BoxDecoration(
                        color: ColorConstant.kGreenColor,

                      ),
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child:
                        FadeInImage.assetNetwork(
                            placeholder: "assets/appicon/defalt_image.jpg",
                            fit: BoxFit.contain,
                            image: imageListslider[i]),
                      ),
                    ),






                ],
                showIndicator: true,
                borderRadius: false,
                moveIndicatorFromBottom: 180.0,
                noRadiusForIndicator: true,

              ),
            ),
          );
        },
      ),
    );
  }
}