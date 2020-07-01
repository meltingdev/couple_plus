import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsScreen extends StatefulWidget {
  static String id = "StatsScreen";
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Statistics"),),
      body: ListView(
        children: [
          SizedBox(height: data.size.height / 8,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text("We are currently working on a screen where you can see all the data saved by the app, this will be available on the Next Update 👨‍🔧", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, fontSize: data.size.width / 14, color: kSecondaryText),)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Icon(FontAwesomeIcons.exclamationTriangle, color: Color(0xFFFF8A00),size: data.size.width / 3,)),
          )
        ],
      ),
    );
  }
}
