import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _fs = Firestore.instance;

class TransitionScreen extends StatefulWidget {
  static String id = "TransitionScreen";
  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  bool transitionButtonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "hey ! Welcome back, time to get a new fresh Start",
              textAlign: TextAlign.center, style: TextStyle(
                fontFamily: "Dosis",
                fontSize: data.size.width / 16,
                fontWeight: FontWeight.w600,
                color: kSecondaryText),),
            SizedBox(height: data.size.height / 4,),
            Center(
              child: CoupleButton(
                  color: kCTA,
                  backColor: kShadowButton,
                  function: ()async{
                await _fs.collection("Users").document(currentUserEmail).setData({
                  "email": currentUserEmail,
                  "userName": "Undefined",
                  "premium": false,
                  "createdAt": DateTime.now().millisecondsSinceEpoch,
                  "roomReference": "Undefined",
                });
                await _fs.collection("synchronisation").document(currentUserEmail).delete();
                Navigator.pushNamed(context, LoadingScreen.id);
              }, buttonText: "Get Couple+ 2.0", buttonIsPressed: transitionButtonIsPressed),
            )
          ],
        ),
      ),
    );
  }
}
