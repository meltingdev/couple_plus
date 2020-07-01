import 'package:coupleplus/Component/BottomSheet.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static String id = "AdminScreen";
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool serviceButtonIsPressed = false;
  bool desireButtonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add Service"),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CoupleButton(
              color: Color(0xFF7000FF),
              backColor: Color(0xFF350079),
          buttonIsPressed: serviceButtonIsPressed,
          buttonText: "Add a new Service",
          function: ()async {
            setState(() {
              serviceButtonIsPressed = true;
            });
            await Future.delayed(Duration(milliseconds: 200));
            setState(() {
              serviceButtonIsPressed = false;
            });
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AdminServiceBottomSheet();
                });
          }
    ),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add Desire"),
          ),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: AnimatedPadding(
    duration: Duration(milliseconds: 100),
    padding: EdgeInsets.only(
    top: desireButtonIsPressed ? 24 : 16,
    left: desireButtonIsPressed ? 24 : 16,
    right: desireButtonIsPressed ? 8 : 16,
    bottom: desireButtonIsPressed ? 8 : 16),
    child: AnimatedContainer(
    duration: Duration(milliseconds: 100),
    width: data.size.width,
    height: data.size.height / 15,
    decoration: BoxDecoration(
    color: kCTA,
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: [
    BoxShadow(
    offset: Offset(desireButtonIsPressed ? 0 : 8,
    desireButtonIsPressed ? 0 : 8),
    blurRadius: 0.0,
    color: kShadowButton),
    ]),
    child: Material(
    color: Colors.transparent,
    child: InkWell(
    onTap: () async {
    setState(() {
    print(desireButtonIsPressed);
    desireButtonIsPressed = true;
    });
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
    desireButtonIsPressed = false;
    print(desireButtonIsPressed);
    });
    showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
    return AdminDesireBottomSheet();
    });
    },
    child: Center(
    child: Text(
    "Add a new Desire",
    style: TextStyle(
    fontFamily: "Dosis",
    fontWeight: FontWeight.w700,
    color: kTextButton,
    fontSize: data.size.width / 16),
    )),
    ),
    ),
    ),
    ),
    )
        ],
      ),
    );
  }
}
