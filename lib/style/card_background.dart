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
                  left:180,
                  child: SvgPicture.asset(
                    'assets/card_bg.svg',package: 'awesome_card',
                    color: Colors.white.withOpacity(0.5),
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
                  right:180,
                  child: SvgPicture.asset(
                    'assets/card_bg.svg',
                    color: Colors.white.withOpacity(0.5),
                  )),
    ]),
    );
  }
}
