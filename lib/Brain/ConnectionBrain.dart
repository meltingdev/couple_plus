import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/linkScreen/LinkWaitScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_string/random_string.dart';



class ConnectionBrain extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fs = Firestore.instance;
  FirebaseUser loggedInUser;

  String email;
  String userName;
  String password;
  String partnerUsername;

  void getEmail(String value){
    email = value;
    notifyListeners();
  }

  void getUsername(String value){
    userName = value;
    notifyListeners();
  }

  void getPassword(String value){
    password = value;
    notifyListeners();
  }

  void getPartnerUsername(String value){
    partnerUsername = value;
    notifyListeners();
  }

  void testFunction()async{
    await _fs.collection("Users").document(currentUserEmail).updateData({
      "test": randomAlphaNumeric(5),
    });
  }

  Future<void> sendInvitation(String partnerUsername, BuildContext test)async{
    print("send invitation to $partnerUsername");
    try {
      var snapshot = await _fs.collection("Users").getDocuments();
        for (var user in snapshot.documents) {
          if (user.data["userName"] == partnerUsername) {
            String email = user.data["email"];
            await _fs.collection("Users").document(email).collection(
                "Invitations").document(myUsername).setData({
              "userName": myUsername,
              "roomReference": randomAlphaNumeric(22),
              "sendAt": DateTime
                  .now()
                  .millisecondsSinceEpoch,
              "email": currentUserEmail
            });
            await _fs.collection("Users").document(currentUserEmail).updateData(
                {
                  "inviteSent": true,
                  "InvitePartner": partnerUsername,
                  "invitePartnerEmail": email,
                });
           Navigator.pushNamed(test, LinkWaitScreen.id);
        }
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> cancelInvitation(String partnerEmail, BuildContext test)async{
    print("CancelInvitation Launched");
    print(partnerEmail);
    await _fs.collection("Users").document(partnerEmail).collection("Invitations").document(myUsername).delete();
    await _fs.collection("Users").document(currentUserEmail).updateData({
      "inviteSent": false,
      "InvitePartner": null,
      "invitePartnerEmail": null,
    });
  }

  Future<void> denyInvitation(String partnerUserName, String partnerEmail, BuildContext test)async{
    print("DenyInvitation Launched");
    await _fs.collection("Users").document(currentUserEmail).collection("Invitations").document(partnerUserName).delete();
    await _fs.collection("Users").document(partnerEmail).updateData({
      "inviteSent": false,
      "InvitePartner": null,
      "invitePartnerEmail": null,
    });
    Navigator.pop(test);
  }

  Future<void> acceptInvitation(String reference,String partnerUser, String partnerEmail, BuildContext test)async{
    await _fs.collection("Rooms").document("room $reference").setData({
      "user1": partnerUser,
      "user2": myUsername,
      "user1Email": partnerEmail,
      "user2Email": currentUserEmail,
      "user1Mood": "❓",
      "user2Mood": "❓",
      "love": 10,
      "reference": reference,
      "user1Gem": 20,
      "user2Gem": 20,
      "CreatedAt": DateTime.now(),
    });
    await _fs.collection("Users").document(partnerEmail).updateData({
      "inviteSent": false,
    });
    await _fs.collection("Users").document(currentUserEmail).updateData({
      "roomReference": reference
    });
    await _fs.collection("Users").document(partnerEmail).updateData({
      "roomReference": reference
    });
    Navigator.pushNamed(test, LoadingScreen.id);
  }

  Future<void> setUsername(String email, String userName, BuildContext test)async {
    print("Set Username Functions");
    print(email);
    print(userName);
    await _fs.collection("Users").document(email).updateData({
      "userName": userName,
    });
    Navigator.pushNamed(test, LoadingScreen.id);

}

  Future<void> createUser(String email, String password,
      BuildContext test) async {
    print("createUserFunctionLaunched !");
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        FirebaseUser user = await _auth.currentUser();
        await user.sendEmailVerification();
        await _fs.collection("Users").document(email).setData({
          "email": email,
          "userName": "Undefined",
          "premium": false,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "roomReference": "Undefined",
        });
        Navigator.pushNamed(test, LoadingScreen.id);
        print("User Created 🎉");
      } catch (e) {
        print(e);
        showDialog(
            context: test,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oh oh.."),
                content: Text("An Account with this email Already exist"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.black54),
                    ),
                  )
                ],
              );
            });
      return null;
    }
  }

  Future<void> logInUser(
      String email, String password, BuildContext test) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      if (e.toString().contains("USER")) {
        showDialog(
            context: test,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oupsie..."),
                content: Text(email.contains("gmail")
                    ? "Try Connecting with the Google Button"
                    : "There is No User associated with this email: $email"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.black54),
                    ),
                  ),
                ],
              );
            });
      }
      if (e.toString().contains("PASSWORD")) {
        showDialog(
            context: test,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oupsie..."),
                content: Text(email.contains("gmail")
                    ? "Try Connecting with the Google Button"
                    : "Wrong Password, the password seems to be incorrect with this email : $email"),
                actions: <Widget>[
                   GestureDetector(
                    onTap: () async {
                      await _auth.sendPasswordResetEmail(email: email);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.blueAccent),
                    ),
                  ),
                  email.contains("gmail")
                      ? Container()
                      : FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.black54),
                    ),
                  )
                ],
              );
            });
      }
    }
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Navigator.pushNamed(test, LoadingScreen.id);
    }
  }

  Future<void> googleRegister(BuildContext test) async {
    print("GOOGLE SIGN IN");
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    print("GOOGLE SIGN IN email = ${googleUser.email}");
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final FirebaseUser fireUser =
        (await _auth.signInWithCredential(credential)).user;
    fireUser.sendEmailVerification();
    print("User Created 🎉");
    await _fs.collection("Users").document(fireUser.email).setData({
      "email": googleUser.email,
      "userName": "Undefined",
      "premium": false,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "roomReference": "Undefined",
    });
    Navigator.pushNamed(test, LoadingScreen.id);
  }

}