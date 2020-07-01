import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/complementaryScreen/ShopScreen.dart';
import 'package:flutter/material.dart';

final Firestore _fs = Firestore.instance;

class LeaderBoardScreen extends StatefulWidget {
  static String id ="LeaderBoardScreen";
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
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
      appBar: AppBar(title: Text("LeaderBoard"),),
      body: roomData["leaderBoard"] != null ? StreamBuilder<QuerySnapshot>(
        stream: _fs.collection("Rooms").orderBy("totalLove", descending: true).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: Text("No Internet Connection !"));
          } else {
            List <LeaderBoardRoomWidget> roomsList = [
            ];
            for(var room in snapshot.data.documents) {
              String user1 = room.data["user1"];
              String user2 = room.data["user2"];
              int totalLove = room.data["totalLove"];
              roomsList.add(LeaderBoardRoomWidget(user1: user1,
                  user2: user2,
                  totalLove: totalLove,
                  position: roomsList.length+1,));
            }
            return ListView(
              children: roomsList,
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

class LeaderBoardRoomWidget extends StatelessWidget {
  LeaderBoardRoomWidget({@required this.user1, @required this.user2, @required this.totalLove, @required this.position});
  final int totalLove;
  final int position;
  final String user1;
  final String user2;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: data.size.width,
        height: data.size.height / 8,
        decoration: BoxDecoration(
          color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.circular(15.0)
        ),
        child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
            Text("$position", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700),),
            Text("$user1 & $user2's Couple", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w500, fontFamily: "Dosis"),),
            Text("$totalLove", style: TextStyle(fontFamily: "Dosis", color: kCTA, fontWeight: FontWeight.w700),)
          ],),
        ),
      ),
    );
  }
}
