import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Component/achievements.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/complementaryScreen/ShopScreen.dart';
import 'package:flutter/material.dart';

final Firestore _fs = Firestore.instance;

class AchievementsScreen extends StatefulWidget {
  static String id ="AchievementsScreen";
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  void getRoomData()async{
    roomData = await _fs.collection("Rooms").document("room $roomReference").get();
  }

  @override
  void initState() {
    getRoomData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Achievements"),),
      body: roomData["achievement"] != null ? StreamBuilder<QuerySnapshot>(
          stream: _fs.collection("Rooms").orderBy("totalLove", descending: true).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Text("No Internet Connection !"));
            } else {
              print(roomData.data["moods"]);
              print(roomData.data["desires"]);
              print(roomData.data["days"]);
              print(roomData.data["services"]);
              print(roomData.data["souvenirs"]);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text("There is a few challenge that you can achieve with your partner 🏆", textAlign: TextAlign.center,style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kSecondaryText, fontSize: data.size.width / 14),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Long press on icon to know what this is about...",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kSecondaryText, fontSize: data.size.width / 14),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Achievement(ourMoodDay: roomData.data["moods"] != null ? roomData.data["moods"]: 0, ourRoomDesire: roomData.data["desires"] != null ? roomData.data["desires"] : 0, ourRoomLoveDay: roomData.data["days"] != null ? roomData.data["days"] : 0, ourRoomChallenge: roomData.data["services"] != null ? roomData.data["services"]: 0, support: roomData.data["support"] != null ?roomData.data["support"] : 0 ,souvenirs: roomData.data["souvenirs"] != null ? roomData.data["souvenirs"] : 0,),
                  )
                ],
              );
            }
          }
      ) :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("You must buy this features to see something", textAlign: TextAlign.center,style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kSecondaryText, fontSize: data.size.width / 14),),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(elevation: 15.0, color: kSecondaryBackgroundColor,onPressed: (){
              Navigator.pushNamed(context, ShopScreen.id);
            }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: data.size.width / 3,
                  child: Row(
                    children: [
                      Container(
                          width: data.size.width / 8,child: Image.asset("lib/images/shop_icon.png")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Shop",
                          style: TextStyle(
                            fontFamily: "Dosis",
                            fontSize: data.size.width / 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
          ),
        ],
      ),
    );
  }
}