import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';

class CoupleButton extends StatefulWidget {
  CoupleButton({@required this.function, @required this.buttonText, @required this.buttonIsPressed, @required this.color, @required this.backColor});
  final Function function;
  final String buttonText;
  final bool buttonIsPressed;
  final Color color;
  final Color backColor;
  @override
  _CoupleButtonState createState() => _CoupleButtonState();
}

class _CoupleButtonState extends State<CoupleButton> {
  bool buttonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return AnimatedPadding(
      duration: Duration(milliseconds: 100),
      padding: EdgeInsets.only(
          top: widget.buttonIsPressed ? 24 : 16,
          left: widget.buttonIsPressed ? 24 : 16,
          right: widget.buttonIsPressed ? 8 : 16,
          bottom: widget.buttonIsPressed ? 8 : 16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: data.size.width,
        height: data.size.height / 15,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(widget.buttonIsPressed ? 0 : 8,
                      widget.buttonIsPressed ? 0 : 8),
                  blurRadius: 0.0,
                  color: widget.backColor),
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.function,
            child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.w700,
                      color: kTextButton,
                      fontSize: data.size.width / 16),
                )),
          ),
        ),
      ),
    );
  }
}

class RawCoupleButton extends StatefulWidget {
  RawCoupleButton({@required this.function, @required this.child, @required this.buttonIsPressed,this.width, @required this.color,@required this.backColor});
  final Function function;
  final Widget child;
  final double width;
  final Color color;
  final Color backColor;
  final bool buttonIsPressed;
  @override
  _RawCoupleButtonState createState() => _RawCoupleButtonState();
}

class _RawCoupleButtonState extends State<RawCoupleButton> {
  bool buttonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return AnimatedPadding(
      duration: Duration(milliseconds: 100),
      padding: EdgeInsets.only(
          top: widget.buttonIsPressed ? 24 : 16,
          left: widget.buttonIsPressed ? 24 : 16,
          right: widget.buttonIsPressed ? 8 : 16,
          bottom: widget.buttonIsPressed ? 8 : 16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(widget.buttonIsPressed ? 0 : 8,
                      widget.buttonIsPressed ? 0 : 8),
                  blurRadius: 0.0,
                  color: widget.backColor),
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.function,
            child: Center(
                child: widget.child
        ),
      ),
    ),),);
  }
}