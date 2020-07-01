import 'dart:io';

import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/MainScreen/MainScreen.dart';
import 'package:coupleplus/complementaryScreen/TransitionScreen.dart';
import 'package:coupleplus/linkScreen/ChooseAuthMethodScreen.dart';
import 'package:coupleplus/linkScreen/LinkSelectionMethodScreen.dart';
import 'package:coupleplus/linkScreen/LinkWaitScreen.dart';
import 'package:coupleplus/linkScreen/RegisterScreen.dart';
import 'package:coupleplus/linkScreen/UsernameScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


Firestore _fs = Firestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging();
FirebaseAuth _auth = FirebaseAuth.instance;
String currentUserEmail;
String myUsername;
String roomReference;
DocumentSnapshot roomData;

class LoadingScreen extends StatefulWidget {
  static String id = "LoadingScreen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getCurrentUsers() async {
    print("getCurrentuser launched  !");
    try {
      final user = await _auth.currentUser();
      final googleAccount = GoogleSignIn().currentUser;
      if (user != null) {
        currentUserEmail = user.email;
        print("auth : ${user.email}");
        user.reload();
        DocumentSnapshot oldUserData =
        await _fs.collection("synchronisation").document(currentUserEmail).get();
        if(oldUserData.data != null){
          print("Is an old user !");
          Navigator.pushNamed(context, TransitionScreen.id);
        } else {
          DocumentSnapshot userData =
          await _fs.collection("Users").document(currentUserEmail).get();
          print("Check userName...");
          if (userData.data["userName"] != "Undefined") {
            myUsername = userData.data["userName"];
            print("User have Username ! ${userData.data["userName"]}");
            print("Check roomReference...");
            if (userData.data["roomReference"] != "Undefined") {
              print("User have a roomReference");
              roomReference = userData.data["roomReference"];
              roomData =
              await _fs.collection("Rooms")
                  .document("room $roomReference")
                  .get();
              String token = await _fcm.getToken();
              await _fs.collection("Users").document(currentUserEmail).collection("Tokens").document("token").setData({
                "token": token,
                "createdAt": DateTime.now().millisecondsSinceEpoch,
              });
              Navigator.pushNamed(context, MainScreen.id);
            } else {
              if (userData.data["inviteSent"] == true) {
                print("InviteSent == True");
                Navigator.pushNamed(context, LinkWaitScreen.id);
              } else {
                Navigator.pushNamed(context, LinkSelectionMethodScreen.id);
              }
            }
          } else {
            print("User don't have Username !");
            Navigator.pushNamed(context, UsernameScreen.id);
          }
        }
      } else if (googleAccount != null) {
        currentUserEmail = googleAccount.email;
        print("google : $currentUserEmail");
        if(_fs.collection("synchronisation").document(currentUserEmail) != null){
          Navigator.pushNamed(context, TransitionScreen.id);
        }
        DocumentSnapshot userData =
        await _fs.collection("Users").document(currentUserEmail).get();
        print("Check if User have userName...");
        if (userData.data["userName"] != "Undefined") {
          myUsername = userData.data["userName"];
          print("User have username !");
          print("Check roomReference...");
          if(userData.data["roomReference"] != "Undefined"){
            print("User have a roomReference");
            String token = await _fcm.getToken();
            await _fs.collection("Users").document(currentUserEmail).collection("Tokens").document("token").setData({
              "token": token,
              "createdAt": DateTime.now().millisecondsSinceEpoch,
            });
            MainBrain().checkNewPrivateMission();
            Navigator.pushNamed(context, MainScreen.id);
          }else{
            if(userData.data["inviteSent"] == true){
              Navigator.pushNamed(context, LinkWaitScreen.id);
            } else {
              Navigator.pushNamed(context, LinkSelectionMethodScreen.id);
            }
          }
        } else {
          print("User don't have any userName");
          _fcm.subscribeToTopic("CommunityMissions");
          Navigator.pushNamed(context, UsernameScreen.id);
        }
      } else {
        Navigator.pushNamed(context, ChooseAuthMethodScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUsers();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kCTA,
      body: Stack(
        children: [
          Container(
            width: data.size.width,
              height: data.size.height,
              child: Image.asset("lib/images/background.png", fit: BoxFit.fill,)),
          Center(
            child: Image(image: AssetImage("lib/images/loading_logo.png"),),
          ),
        ],
      ),
    );
  }
}
