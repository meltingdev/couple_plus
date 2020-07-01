import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
final Firestore _fs = Firestore.instance;

class ShopScreen extends StatefulWidget {
  static String id = "ShopScreen";
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int gems;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text("Shop"),
              Spacer(flex: 1,),
              Row(
                children: [
                  Container(height: data.size.height / 25,child: Image.asset("lib/images/cristal.png")),
                  Padding(
                    padding: const EdgeInsets.only(left : 8.0),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: _fs.collection("Rooms").document("room $roomReference").snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Text("NO DATA");
                        }else{
                          if (roomData.data["user1"] == myUsername) {
                              gems = roomData.data["user1Gem"];
                          } else {
                              gems = roomData.data["user2Gem"];
                          }
                          return Text(gems.toString(), style: TextStyle(color: kCTA, fontFamily: "Dosis", fontWeight: FontWeight.w700, fontSize: data.size.width / 14),);
                        }
                      }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text("Services", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 15, fontWeight: FontWeight.w700),),
            ),
            ShopItems(data: data, title: "Random Desire", text: "Are you lacking of inspirations ? Be suprised with our random idea !", imagePath: "lib/images/lightbulb 1.png", price: "20", function: (){
              MainBrain().addRandomDesire(context);
            },),
            ShopItems(data: data, title: "Random Service", text: "Get a Random Challenge with a winning price between 5 - 20", imagePath: "lib/images/coffee.png", price: "40", function: (){
              MainBrain().addRandomService(context);
            },),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text("Features", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 15, fontWeight: FontWeight.w700),),
            ),
            ShopItems(data: data, title: "Leaderboards", text: "Show The power of your couple to the world", imagePath: "lib/images/leaderboard_icon.png", price: "60",
            function: (){
              MainBrain().buyLeaderBoardFeature();
            },),
            ShopItems(data: data, title: "achievements", text: "Unlock a Library of achievements and see how loving is your couple.", imagePath: "lib/images/achievement_icon.png", price: "150", function: (){
              MainBrain().buyAchievementsFeature();
            },),
            ShopItems(data: data, title: "Satistics", text: "Track the way your couple is using the app and see some fun stats.", imagePath: "lib/images/stats_icon.png", price: "500"),
          ],
        ),
      ),
    );
  }
}

class ShopItems extends StatelessWidget {
  const ShopItems({
    @required this.data,
    @required this.title,
    @required this.text,
    @required this.imagePath,
    @required this.price,
    this.function
  });
  final String title;
  final String text;
  final String imagePath;
  final String price;
  final MediaQueryData data;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: InkWell(
        onTap: () async{
          roomData =
          await _fs.collection("Rooms")
              .document("room $roomReference")
              .get();
          print("1: roomData get");
          if(roomData.data["user1"] == myUsername) {
            if(roomData.data["user1Gem"] < int.parse(price)){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("You don't have enough Gems for:"),
                  content: Text(title),
                  actions: [
                    FlatButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Ok"))
                  ],
                 );
              });
              return;
            }
          } else if(roomData.data["user2"] == myUsername){
            if(roomData.data["user2Gem"] < int.parse(price)){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("You don't have enough Gems"),
                  content: Text(title),
                  actions: [
                    FlatButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Ok"))
                  ],
                );
              });
            }
          }
          print("2: check price done");
          showDialog(context: context, builder: (BuildContext showDialogContext){
            return AlertDialog(
              title: Text("Are you sure you want to buy :"),
              content: Text(title),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.pop(showDialogContext);
                }, child: Text("No", style: TextStyle(color: kSecondaryText, fontSize: data.size.width / 18,),)),
                FlatButton(onPressed: ()async {
                  print("Buy");
                  await function();
            if(roomData.data["user1"] == myUsername) {
            await _fs.collection("Rooms").document("room $roomReference").updateData({
            "user1Gem": roomData.data["user1Gem"]-int.parse(price),
            });
            } else {
            await _fs.collection("Rooms").document("room $roomReference").updateData({
            "user2Gem": roomData.data["user2Gem"]-int.parse(price),
            });
            }
                  print("DONE");
                  Navigator.pop(showDialogContext);
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("You have bought $title, thanks 🧡", style: TextStyle(fontFamily: "Dosis", color: kMainText, fontWeight: FontWeight.w700),), backgroundColor: kSecondaryBackgroundColor,));
                  }, child: Text("Buy", style: TextStyle(color: kCTA, fontSize: data.size.width / 18,),))
              ],
            );
          });
          
        },
        child: Container(
          width: data.size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: kSecondaryBackgroundColor, width: data.size.width / 70)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: data.size.width / 4,child: Image.asset(imagePath)),
              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title, style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 15, fontWeight: FontWeight.w700),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text, style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 20, fontWeight: FontWeight.w500, color: kSecondaryText),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:16.0),
                          child: Container(width: data.size.width / 10,
                          child: Image.asset("lib/images/cristal.png"),),
                        ),
                        Text(price, style: TextStyle(color: kCTA, fontFamily: "Dosis",fontWeight: FontWeight.w700, fontSize: data.size.width / 12),)
                      ],
                    ),
                  )
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}
