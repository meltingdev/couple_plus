import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/linkScreen/LinkSelectionMethodScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



final Firestore _fs = Firestore.instance;

class LinkWaitScreen extends StatefulWidget {
  static String id = "LinkWaitScreen";
  @override
  _LinkWaitScreenState createState() => _LinkWaitScreenState();
}

class _LinkWaitScreenState extends State<LinkWaitScreen> {
  bool mainScreenButtonIsPressed = false;
@override
  void initState() {
    print("LinkWaitScreen Launched");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: _fs.collection("Users").document(currentUserEmail).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Container();
                  }
                    if (snapshot.data["roomReference"] == "Undefined") {
                      return ListView(
                        children: <Widget>[
                          SizedBox(height: data.size.height / 4,),
                          Text(
                            "You have sent an Invitation to ${snapshot.data["InvitePartner"]}",
                            textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: "Dosis",
                              fontSize: data.size.width / 12,
                              fontWeight: FontWeight.w600),),
                          Icon(
                            Icons.watch_later,
                            size: data.size.width / 3,
                            color: kSecondaryText,
                          ),
                          Text(
                            "You have to wait till your partner accept your invitation",
                            textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: "Dosis",
                              fontSize: data.size.width / 16,
                              fontWeight: FontWeight.w600,
                              color: kSecondaryText),),
                          SizedBox(
                            height: data.size.height / 30,
                          ),
                          FlatButton(
                            onPressed: () async {
                              await ConnectionBrain().cancelInvitation(
                                  snapshot.data["invitePartnerEmail"], context);
                              Navigator.pushNamed(context, LinkSelectionMethodScreen.id);
                            },
                            child: Text("Cancel the Invitation",
                              style: TextStyle(fontFamily: "Dosis",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                  fontSize: data.size.width / 16),),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        children: <Widget>[
                          SizedBox(height: data.size.height / 4,),
                          Text("Your Invitation Has Been Accepted",
                            textAlign: TextAlign.center, style: TextStyle(
                                fontFamily: "Dosis",
                                fontSize: data.size.width / 12,
                                fontWeight: FontWeight.w600),),
                          Icon(
                            Icons.check_circle,
                            size: data.size.width / 3,
                            color: Colors.lightGreen,
                          ),
                          Text(
                            "You can now join The app and improve your couple",
                            textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: "Dosis",
                              fontSize: data.size.width / 16,
                              fontWeight: FontWeight.w600,
                              color: kSecondaryText),),
                          AnimatedPadding(
                            duration: Duration(milliseconds: 100),
                            padding: EdgeInsets.only(
                                top: mainScreenButtonIsPressed ? 24 : 16,
                                left: mainScreenButtonIsPressed ? 24 : 16,
                                right: mainScreenButtonIsPressed ? 8 : 16,
                                bottom: mainScreenButtonIsPressed ? 8 : 16),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              width: data.size.width,
                              height: data.size.height / 15,
                              decoration: BoxDecoration(
                                  color: kCTA,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(offset: Offset(
                                        mainScreenButtonIsPressed ? 0 : 8,
                                        mainScreenButtonIsPressed ? 0 : 8),
                                        blurRadius: 0.0,
                                        color: kShadowButton),
                                  ]
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      print(mainScreenButtonIsPressed);
                                      mainScreenButtonIsPressed = true;
                                    });
                                    await Future.delayed(
                                        Duration(milliseconds: 200));
                                    setState(() {
                                      mainScreenButtonIsPressed = false;
                                      print(mainScreenButtonIsPressed);
                                    });
                                    Navigator.pushNamed(context, LoadingScreen.id);
                                  },
                                  child: Center(child: Text("Join",
                                    style: TextStyle(fontFamily: "Dosis",
                                        fontWeight: FontWeight.w700,
                                        color: kTextButton,
                                        fontSize: data.size.width / 16),)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),
            ),
          ),
        );

  }
}

