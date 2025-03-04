import 'dart:math';

import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/extra/helper.dart';
import 'package:awesome_card/style/card_back_layout.dart';
import 'package:awesome_card/style/card_front_layout.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  final String? cardNumber;
  final String? cardExpiry;
  final String? cardHolderName;
  final String bankName;
  final String? cvv;
  final Color frontTextColor;
  final Color backTextColor;
  final bool showBackSide;
  final Widget frontBackground;
  final Widget backBackground;
  final Widget? frontLayout;
  final Widget? backLayout;
  final bool showShadow;
  final CardType? cardType;
  final double? width;
  final double? height;
  final bool? isContactless;
  final Widget? cardBalance;
  final String? textExpDate;
  final String? textName;
  final String? textExpiry;
  final String? mask;
  final double horizontalMargin;

  CreditCard({
    Key? key,
    this.cardNumber,
    this.cardExpiry,
    this.cardHolderName,
    this.bankName = '',
    this.cvv,
    this.showBackSide = false,
    required this.frontBackground,
    required this.backBackground,
    this.cardType,
    this.frontLayout,
    this.backLayout,
    this.frontTextColor = Colors.white,
    this.backTextColor = Colors.black,
    this.showShadow = false,
    this.width,
    this.height,
    this.textExpDate = 'Exp. Date',
    this.textExpiry = 'MM/YY',
    this.textName = 'Card Holder',
    this.mask,
    this.horizontalMargin = 20,
    this.isContactless = true,
    this.cardBalance = const SizedBox()
  }) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  double? cardWidth;
  double? cardHeight;
  late AnimationController _controller;
  Animation<double>? _moveToBack;
  Animation<double>? _moveToFront;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    _moveToBack = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeInBack)),
          weight: 50.0),
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2), weight: 50.0)
    ]).animate(_controller);

    _moveToFront = TweenSequence<double>(
      [
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOutBack)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.width == null
        ? cardWidth =
            MediaQuery.of(context).size.width - (2 * widget.horizontalMargin)
        : cardWidth = widget.width;
    widget.height == null
        ? cardHeight = (cardWidth! / 2) + 24
        : cardHeight = widget.height;

    if (widget.showBackSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Center(
      child: Stack(
        children: <Widget>[
          AwesomeCard(
            animation: _moveToBack,
            child: _buildFrontCard(),
          ),
          AwesomeCard(
            animation: _moveToFront,
            child: _buildBackCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        boxShadow: widget.showShadow
            ? [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 12.0,
                  spreadRadius: 0.2,
                  offset: Offset(
                    3.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            // Background for card
            widget.frontBackground,

            // Front Side Layout
            widget.frontLayout ??
                CardFrontLayout(
                  textExpDate: widget.textExpDate,
                  textExpiry: widget.textExpiry,
                  textName: widget.textName,
                  bankName: widget.bankName,
                  cardNumber: widget.cardNumber,
                  cardExpiry: widget.cardExpiry,
                  cardHolderName: widget.cardHolderName,
                  cardBalance: widget.cardBalance,
                  cardTypeIcon: getCardTypeIcon(
                      cardType: widget.cardType, cardNumber: widget.cardNumber),
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  textColor: widget.frontTextColor,
                  mask: widget.mask ??
                      getCardTypeMask(
                        cardType: widget.cardType,
                        cardNumber: widget.cardNumber,
                      ),
                  isContactless: widget.isContactless,
                ).layout1(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        boxShadow: widget.showShadow
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.4),
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                  offset: Offset(
                    2.0, // horizontal, move right 10
                    2.0, // vertical, move down 10
                  ),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            // Background for card
            widget.backBackground,

            // Back Side Layout
            widget.backLayout ??
                CardBackLayout(
                        cvv: widget.cvv,
                        width: cardWidth,
                        height: cardHeight,
                        color: widget.backTextColor)
                    .layout1()
          ],
        ),
      ),
    );
  }
}

class AwesomeCard extends StatelessWidget {
  final Animation<double>? animation;
  final Widget child;

  AwesomeCard({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          // https://blog.codemagic.io/flutter-matrix4-perspective-transformations/
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation!.value),
          alignment: Alignment.center,
          child: this.child,
        );
      },
    );
  }
}
