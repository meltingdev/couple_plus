import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Component/navigation.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/MainScreen/DesireScreen.dart';
import 'package:coupleplus/MainScreen/GalleryScreen.dart';
import 'package:coupleplus/MainScreen/HomeScreen.dart';
import 'package:coupleplus/MainScreen/ServiceScreen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:rate_my_app/rate_my_app.dart';


final FirebaseMessaging _fcm = FirebaseMessaging();
final Firestore _fs = Firestore.instance;

class MainScreen extends StatefulWidget {
  MainScreen({@required this.page});
  static String id = "MainScreen";
  int page;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(
    initialPage: 0
  );
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 3,
    remindDays: 3,
    remindLaunches: 10,
    googlePlayIdentifier: 'melting.coupley',
    appStoreIdentifier: '1489615090',
  );

  @override
  void initState() {
    rateMyApp.init().then((_){
      if(rateMyApp.shouldOpenDialog){
        rateMyApp.showStarRateDialog(context, title: "Enjoying Couple+ ?", message: "Please leave a rating !",starRatingOptions: StarRatingOptions());
      }
    });
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      Flushbar(
        backgroundColor: Colors.white,
        flushbarPosition: FlushbarPosition.TOP,
        forwardAnimationCurve: Curves.easeIn,
        reverseAnimationCurve: Curves.easeOut,
        titleText: Text(
          message["notification"]["title"],
          style: TextStyle(color: Colors.black),
        ),
        messageText: Text(
          message["notification"]["body"],
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount})async {
      if (event == RewardedVideoAdEvent.rewarded) {
        roomData = await _fs.collection("Rooms").document("room $roomReference").get();
        _fs.collection("Rooms").document("room $roomReference").updateData({
          "user1Gem": roomData["user1Gem"] + 10,
          "user2Gem": roomData["user2Gem"] + 10,
          "support": roomData["support"] != null  ? roomData["support"] + 1 : 1
        });
      }
    };
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              controller: pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int page){
                setState(() {
                  widget.page = page;
                });
              },
              children: <Widget>[
                HomeScreen(),
                DesireScreen(),
                ServiceScreen(),
                GalleryScreen(),
              ],
            ),
      NavBar(pageController: pageController, activePage: widget.page,),
          ],
        ),
      ),
    );
  }
}

