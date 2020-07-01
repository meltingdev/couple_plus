import 'package:avatar_glow/avatar_glow.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/linkScreen/LinkReceiveScreen.dart';
import 'package:coupleplus/linkScreen/LinkSendScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';

import 'ChooseAuthMethodScreen.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _fs = Firestore.instance;
class LinkSelectionMethodScreen extends StatefulWidget {
  static String id = "LinkSelectionMethodScreen";
  @override
  _LinkSelectionMethodScreenState createState() => _LinkSelectionMethodScreenState();
}

class _LinkSelectionMethodScreenState extends State<LinkSelectionMethodScreen> {
  bool sendInvitationButtonIsPressed = false;
  bool receiveInvitationButtonIsPressed = false;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hello $myUsername",style: TextStyle(
                      fontSize: data.size.height / 18,
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.w700,
                      color: kMainText
                    ),),
                  ),
                  Spacer(flex: 1,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.cancel), iconSize: data.size.width / 12,color: kSecondaryText,onPressed:
                          () async {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Disconnect"),
                                content: Text("You're about to quit the process, is that what you want ?"),
                                actions: [
                                  FlatButton(onPressed: ()async{
                                    try {
                                      await _auth.signOut();
                                      await GoogleSignIn().signOut();
                                    } catch (e) {
                                      print(e);
                                    }
                                    Navigator.popAndPushNamed(context, ChooseAuthMethodScreen.id);
                                  }, child: Text("Yes", style: TextStyle(color: kSecondaryText),)),
                                  FlatButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("No", style: TextStyle(color: kCTA),))
                                ],
                              );
                            });


                      },
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Just a few steps", style: TextStyle(fontFamily: "Dosis", color: kSecondaryText, fontWeight: FontWeight.w600, fontSize: data.size.width / 18),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: data.size.width,
                  height: data.size.height / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: kSecondaryBackgroundColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: data.size.width / 30,
                        ),
                        Text("1", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 10, fontWeight: FontWeight.w700),),
                      SizedBox(
                        width: data.size.width / 40,
                      ),
                        Text("Ask your partner to download the App",softWrap: true, style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 20, fontWeight: FontWeight.w700),)
                    ],),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),color: Colors.lightGreenAccent,onPressed: (){
                      Share.share("https://play.google.com/store/apps/details?id=melting.coupley");
                    }
                    ,child: Row(
                      children: <Widget>[
                        Icon(Icons.share),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Android app", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700,fontSize: data.size.width / 20),),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),color: Colors.white,onPressed: (){
                      Share.share("https://apps.apple.com/us/app/couple/id1489615090?l=fr&ls=1");
                    }
                      ,child: Row(
                        children: <Widget>[
                          Icon(Icons.share),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("iOS app", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, fontSize: data.size.width / 20),),
                          ),
                        ],
                      ),
                    ),
                  )
                ],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: data.size.width,
                  height: data.size.height / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: kSecondaryBackgroundColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: data.size.width / 30,
                        ),
                        Text("2", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 10, fontWeight: FontWeight.w700),),
                        SizedBox(
                          width: data.size.width / 40,
                        ),
                        Text("Send your partner an Invitation", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 20, fontWeight: FontWeight.w700),)
                      ],),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: data.size.width,
                  height: data.size.height / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: kSecondaryBackgroundColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: data.size.width / 30,
                        ),
                        Text("3", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 10, fontWeight: FontWeight.w700),),
                        SizedBox(
                          width: data.size.width / 40,
                        ),
                        Text("Wait for your partner to Accept it", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 20, fontWeight: FontWeight.w700),)
                      ],),
                  ),
                ),
              ),
              SizedBox(
                height: data.size.height / 20,
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.only(top: sendInvitationButtonIsPressed ? 24 : 16, left: sendInvitationButtonIsPressed ? 24 : 16, right: sendInvitationButtonIsPressed ? 8 : 16, bottom: sendInvitationButtonIsPressed ? 8 : 16),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: data.size.width,
                  height: data.size.height / 15,
                  decoration: BoxDecoration(
                      color: kCTA,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(offset: Offset(sendInvitationButtonIsPressed ? 0 : 8, sendInvitationButtonIsPressed ? 0 : 8), blurRadius: 0.0, color: kShadowButton),
                      ]
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        setState((){
                          print(sendInvitationButtonIsPressed);
                          sendInvitationButtonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          sendInvitationButtonIsPressed = false;
                          print(sendInvitationButtonIsPressed);
                        });
                        Navigator.pushNamed(context, LinkSendScreen.id);
                      },
                      child: Center(child: Text("Send Invitation", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
                    ),
                  ),
                ),
              ),
              Center(child: Text("Or", style: TextStyle(fontFamily: "Dosis",fontWeight: FontWeight.w600, fontSize: data.size.width / 20),)),
              StreamBuilder<QuerySnapshot>(
                stream: _fs.collection("Users").document(currentUserEmail).collection("Invitations").snapshots(),
                builder: (context, snapshot) {
                  bool invited = false;
                  if(snapshot.data.documents.length > 0){
                      invited = true;
                  } else {
                      invited = false;
                  }
                  return Stack(
                    children: [
                      AnimatedPadding(
                        duration: Duration(milliseconds: 100),
                        padding: EdgeInsets.only(top: receiveInvitationButtonIsPressed ? 24 : 16, left: receiveInvitationButtonIsPressed ? 24 : 16, right: receiveInvitationButtonIsPressed ? 8 : 16, bottom: receiveInvitationButtonIsPressed ? 8 : 16),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          width: data.size.width,
                          height: data.size.height / 15,
                          decoration: BoxDecoration(
                              color: kCTA,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(offset: Offset(receiveInvitationButtonIsPressed ? 0 : 8, receiveInvitationButtonIsPressed ? 0 : 8), blurRadius: 0.0, color: kShadowButton),
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: ()async{
                                setState((){
                                  print(receiveInvitationButtonIsPressed);
                                  receiveInvitationButtonIsPressed = true;
                                });
                                await Future.delayed(Duration(milliseconds: 200));
                                setState(() {
                                  receiveInvitationButtonIsPressed = false;
                                  print(receiveInvitationButtonIsPressed);
                                });
                                Navigator.pushNamed(context, LinkReceiveScreen.id);
                              },
                              child: Center(child: Text("Receive Invitation", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
                            ),
                          ),
                        ),
                      ),
                      invited ?Positioned(
                        top:  -10,
                        right: 10,
                        child: AvatarGlow(
                          endRadius: 30.0,
                          glowColor: kCTA,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                border: Border.all(color: kCTA, width: 2.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.email, color: kCTA,),
                            ),
                          ),
                        ),
                      ): Container(),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
