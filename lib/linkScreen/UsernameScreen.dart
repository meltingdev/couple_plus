import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _fs = Firestore.instance;

class UsernameScreen extends StatefulWidget {
  static String id = "UsernameScreen";
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  bool available = false;
  bool chooseUsernameButtonIsPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<ConnectionBrain>(context);
    final data = MediaQuery.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Text("Time to choose an Username !", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kSecondaryText, fontSize: data.size.width / 8),),
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter something";
                  }
                  return null;
                },
                onChanged: (String value) async {
                  _pr.getUsername(value);
                  if(value.length <= 3) {
                    setState(() {
                      available = false;
                    });
                  } else {
                    print("Check availability");
                    await for(var snapshot in _fs.collection("Users").snapshots()){
                      for(var user in snapshot.documents){
                        print(user.data["userName"]);
                        print(value.toLowerCase());
                        if(user.data["userName"].toString().toLowerCase() == value.toLowerCase()){
                          print("Same");
                          setState(() {
                            available = false;
                          });
                          return;
                        } else {
                          setState(() {
                            available = true;
                          });
                        }
                      }
                    }
                  }
                },
                decoration: InputDecoration(
                  suffix: available ? Text("Available", style: TextStyle(
                      fontFamily: "Disos",
                      fontWeight: FontWeight.w500,
                      color: Colors.lightGreen
                  ),) : Text("Not Available", style: TextStyle(
                      fontFamily: "Disos",
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent
                  ),),
                  labelText: "Username",
                  labelStyle: TextStyle(color: kSecondaryText, fontFamily: "Dosis", fontWeight: FontWeight.w600, fontSize: data.size.width / 18),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kSecondaryBackgroundColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kCTA, width: 3.0),
                  ),
                ),
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.only(top: chooseUsernameButtonIsPressed ? 24 : 16, left: chooseUsernameButtonIsPressed ? 24 : 16, right: chooseUsernameButtonIsPressed ? 8 : 16, bottom: chooseUsernameButtonIsPressed ? 8 : 16),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: data.size.width,
                  height: data.size.height / 15,
                  decoration: BoxDecoration(
                      color: kCTA,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(offset: Offset(chooseUsernameButtonIsPressed ? 0 : 8,chooseUsernameButtonIsPressed ? 0 : 8), blurRadius: 0.0, color: kShadowButton),
                      ]
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        setState((){
                          print(chooseUsernameButtonIsPressed);
                          chooseUsernameButtonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          chooseUsernameButtonIsPressed = false;
                          print(chooseUsernameButtonIsPressed);
                        });
                        if(_formKey.currentState.validate()){
                          if(available == true){
                            ConnectionBrain().setUsername(currentUserEmail, _pr.userName, context);
                          }
                        }
                      },
                      child: Center(child: Text("Choose this Username", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
