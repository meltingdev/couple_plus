import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/Component/moods.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';

final Firestore _fs = Firestore.instance;

class MoodsScreen extends StatefulWidget {
  static String id = "MoodsScreen";
  @override
  _MoodsScreenState createState() => _MoodsScreenState();
}

class _MoodsScreenState extends State<MoodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 7.0,
            crossAxisSpacing: 7.0
          ),
          itemBuilder: (BuildContext context, int index){
            return RaisedButton(
              onPressed: ()async{
                var roomsData = await _fs.collection("Rooms").document("room $roomReference").get();
                if(roomsData.data["user1"] == myUsername){
                  await _fs.collection("Rooms").document("room $roomReference").updateData({
                    "user1Mood": Moods().moods[index],
                    "moods": roomsData.data["moods"] != null ? roomsData.data["moods"] + 1 : 1,
                  });
                  Navigator.pop(context);
                } else {
                  await _fs.collection("Rooms").document("room $roomReference").updateData({
                    "user2Mood": Moods().moods[index],
                    "moods": roomsData.data["moods"] != null ? roomsData.data["moods"] + 1 : 1,
                  });
                  Navigator.pop(context);
                }
              },
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              child: Text(Moods().moods[index], style: TextStyle(fontSize: 30),),
            );
          },
          itemCount: Moods().moods.length,
        ),
      ),
    );
  }
}
