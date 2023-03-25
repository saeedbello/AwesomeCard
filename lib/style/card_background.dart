import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardBackgrounds {
  CardBackgrounds._();

  static Widget black = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xff0B0B0F),
    child: Stack(children: [
              Positioned(
                  top:100,
                  left:200,
                  child: SvgPicture.asset(
                    'assets/card_bg.svg',package: 'awesome_card',
                    color: Colors.grey.withOpacity(0.5),
                  )),
    ]),
  );

  static Widget white = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xffF9F9FA),
  );

  static Widget custom(color) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(color),
       child: Stack(children: [
              Positioned(
                  top:100,
                  right:200,
                  child: SvgPicture.asset(
                    'images/card_bg.svg',
                    color: Colors.grey.withOpacity(0.5),
                  )),
    ]),
    );
  }
}
