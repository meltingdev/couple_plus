
import 'package:coupleplus/complementaryScreen/AchievementsScreen.dart';
import 'package:coupleplus/complementaryScreen/AdminScreen.dart';
import 'package:coupleplus/complementaryScreen/LeaderboardScreen.dart';
import 'package:coupleplus/complementaryScreen/ShopScreen.dart';
import 'package:coupleplus/complementaryScreen/StatsScreen.dart';
import 'package:coupleplus/linkScreen/ChooseAuthMethodScreen.dart';
import 'package:coupleplus/linkScreen/RegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    Key key,
    @required this.data,
  }) : super(key: key);

  final MediaQueryData data;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(height: data.size.height / 8,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ShopScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: data.size.width / 7,
                          height: data.size.width / 7,
                          child: Image.asset("lib/images/shop_icon.png")),
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
                      ),
                    ],
                  )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, StatsScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: data.size.width / 7,
                          height: data.size.width / 7,
                          child: Image.asset("lib/images/stats_icon.png")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Statistics",
                          style: TextStyle(
                            fontFamily: "Dosis",
                            fontSize: data.size.width / 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LeaderBoardScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: data.size.width / 7,
                          height: data.size.width / 7,
                          child: Image.asset(
                              "lib/images/leaderboard_icon.png")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "LeaderBoard",
                          style: TextStyle(
                            fontFamily: "Dosis",
                            fontSize: data.size.width / 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AchievementsScreen.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: data.size.width / 7,
                          height: data.size.width / 7,
                          child: Image.asset(
                              "lib/images/achievement_icon.png")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Achievements",
                          style: TextStyle(
                            fontFamily: "Dosis",
                            fontSize: data.size.width / 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Divider(),
            FlatButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  content: TextField(onChanged: (value){
                    if(value == "Soleil"){
                      Navigator.pushNamed(context, AdminScreen.id);
                    }
                  },),
                );
              });
            }, child: Container(),),
            Spacer(
              flex: 1,
            ),
            RaisedButton(
              color: Color(0xFF00B2FF),
              onPressed: () async {
                try {
                  await _auth.signOut();
                  await GoogleSignIn().signOut();
                } catch (e) {
                  print(e);
                }

                Navigator.popAndPushNamed(context, ChooseAuthMethodScreen.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Disconnect",
                  style: TextStyle(
                      fontFamily: "Dosis",
                      fontSize: data.size.width / 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: data.size.height / 7,
            )
          ],
        ),
      ),
    );
  }
}