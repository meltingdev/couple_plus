import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';



final Firestore _fs = Firestore.instance;

class LinkReceiveScreen extends StatefulWidget {
  static String id = "LinkReceiveScreen";
  @override
  _LinkReceiveScreenState createState() => _LinkReceiveScreenState();
}

class _LinkReceiveScreenState extends State<LinkReceiveScreen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Receive Invitation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(child: Text("Share your username and wait for the invitation.", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 16, color: kSecondaryText, fontWeight: FontWeight.w700),)),
            SizedBox(height: data.size.height / 40,),
            Center(
              child: Text(myUsername, style: TextStyle(
                fontSize: data.size.width / 8,
                fontFamily: "Dosis",
                fontWeight: FontWeight.w700
              ),),
            ),
            SizedBox(height: data.size.height / 40,),
            StreamBuilder<QuerySnapshot>(
              stream: _fs.collection("Users").document(currentUserEmail).collection("Invitations").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Text("No DATA" ,textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Dosis",
                              fontWeight: FontWeight.w700,
                              fontSize: data.size.width / 16,
                              color: kSecondaryText),),
                        Icon(Icons.watch_later, size: data.size.width / 10,
                          color: kSecondaryText,)
                      ],
                    ),
                  );
                } else {
                  if(snapshot.data.documents.length < 1){
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("There is no Invitation at the moment", textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: "Dosis",
                                fontWeight: FontWeight.w700,
                                fontSize: data.size.width / 14,
                                color: kSecondaryText),),
                          Icon(Icons.watch_later, size: data.size.width / 3,
                            color: kSecondaryText,)
                        ],
                      ),
                    );
                  } else {
                    for(var invitation in snapshot.data.documents){
                      return AvatarGlow(
                        endRadius: 90.0,
                        glowColor: kCTA,
                        child: IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return SimpleDialog(
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    title: Text("️${invitation.data["userName"]} ❤️", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 12),),
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Do you want to join ${invitation.data["userName"]} ?", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 18)),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: (){
                                              ConnectionBrain().acceptInvitation(invitation.data["roomReference"], invitation.data["userName"], invitation.data["email"], context);
                                            },
                                            child: Text("Join", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 16, fontWeight: FontWeight.w700, color: kCTA),),
                                          ),
                                          FlatButton(
                                            onPressed: (){
                                              ConnectionBrain().denyInvitation(invitation.data["userName"], invitation.data["email"], context);
                                            },
                                            child: Text("Deny", style: TextStyle(fontFamily: "Dosis", fontSize: data.size.width / 16, fontWeight: FontWeight.w500, color: kSecondaryText),),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.email),
                          color: kCTA,
                          iconSize: data.size.width / 5,
                        ),
                      );
                    }
                    return Container();
                  }
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
