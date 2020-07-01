import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/MainScreen/ChatScreen.dart';
import 'package:coupleplus/MainScreen/HomeScreen.dart';
import 'package:coupleplus/MainScreen/MainScreen.dart';
import 'package:coupleplus/complementaryScreen/AchievementsScreen.dart';
import 'package:coupleplus/complementaryScreen/AdminScreen.dart';
import 'package:coupleplus/complementaryScreen/LeaderboardScreen.dart';
import 'package:coupleplus/complementaryScreen/MoodsScreen.dart';
import 'package:coupleplus/complementaryScreen/ShopScreen.dart';
import 'package:coupleplus/complementaryScreen/StatsScreen.dart';
import 'package:coupleplus/complementaryScreen/TransitionScreen.dart';
import 'package:coupleplus/linkScreen/ChooseAuthMethodScreen.dart';
import 'package:coupleplus/linkScreen/LinkReceiveScreen.dart';
import 'package:coupleplus/linkScreen/LinkSelectionMethodScreen.dart';
import 'package:coupleplus/linkScreen/LinkSendScreen.dart';
import 'package:coupleplus/linkScreen/LinkWaitScreen.dart';
import 'package:coupleplus/linkScreen/LoginScreen.dart';
import 'package:coupleplus/linkScreen/RegisterScreen.dart';
import 'package:coupleplus/linkScreen/UsernameScreen.dart';
import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Couple', 'love', "relationship",],
  childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

RewardedVideoAd myRewardedVideoAD = RewardedVideoAd.instance;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(
      //TODO IOS AD APP ID
//      appId:"ca-app-pub-1019750920692164~4267012873"
      //TODO ANDROID AD APP ID
      appId: "ca-app-pub-1019750920692164~1470654684",
    );
    myRewardedVideoAD.load(adUnitId:
        // TODO IOS AD ID
//    "ca-app-pub-1019750920692164/2301865521"
        // TODO ANDROID AD ID
       "ca-app-pub-1019750920692164/5852537226"
    , targetingInfo: targetingInfo);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ConnectionBrain()),
        ChangeNotifierProvider.value(value: MainBrain()),
      ],
      child: MaterialApp(
        title: 'Couple+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kSecondaryBackgroundColor,
        ),
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id:(context) => LoadingScreen(),
          RegisterScreen.id:(context) => RegisterScreen(),
          LoginScreen.id:(context) => LoginScreen(),
          UsernameScreen.id:(context) => UsernameScreen(),
          LinkSelectionMethodScreen.id:(context)=> LinkSelectionMethodScreen(),
          LinkSendScreen.id:(context) => LinkSendScreen(),
          LinkReceiveScreen.id:(context) => LinkReceiveScreen(),
          LinkWaitScreen.id:(context) => LinkWaitScreen(),
          MainScreen.id :(context) => MainScreen(page: 0,),
          HomeScreen.id :(context) => HomeScreen(),
          MoodsScreen.id :(context) => MoodsScreen(),
          TransitionScreen.id:(context) => TransitionScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          ShopScreen.id: (context) => ShopScreen(),
          LeaderBoardScreen.id: (context) => LeaderBoardScreen(),
          AdminScreen.id: (context) => AdminScreen(),
          AchievementsScreen.id:(context) => AchievementsScreen(),
          StatsScreen.id:(context) => StatsScreen(),
          ChooseAuthMethodScreen.id: (context) => ChooseAuthMethodScreen(),
        },
      ),
    );
  }
}

