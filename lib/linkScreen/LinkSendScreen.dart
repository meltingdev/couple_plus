import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkSendScreen extends StatefulWidget {
  static String id = "LinkSendScreen";
  @override
  _LinkSendScreenState createState() => _LinkSendScreenState();
}

class _LinkSendScreenState extends State<LinkSendScreen> {
  bool sendInvitationIsPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    var _pr = Provider.of<ConnectionBrain>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Send Invitation"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: data.size.height / 6,
              ),
              Text("Invite your partner", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w600, color: kSecondaryText, fontSize: data.size.width / 10),),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter something";
                  }
                  return null;
                },
                onChanged: (String value){
                  _pr.getPartnerUsername(value);
                },
                decoration: InputDecoration(
                  labelText: "partner's username",
                  labelStyle: TextStyle(color: kSecondaryText, fontFamily: "Dosis", fontWeight: FontWeight.w600, fontSize: data.size.width / 18),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kSecondaryBackgroundColor, width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kCTA, width: 3.0),
                  ),
                ),
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.only(top: sendInvitationIsPressed ? 24 : 16, left: sendInvitationIsPressed ? 24 : 16, right: sendInvitationIsPressed ? 8 : 16, bottom: sendInvitationIsPressed ? 8 : 16),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: data.size.width,
                  height: data.size.height / 15,
                  decoration: BoxDecoration(
                      color: kCTA,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(offset: Offset(sendInvitationIsPressed ? 0 : 8,sendInvitationIsPressed ? 0 : 8), blurRadius: 0.0, color: kShadowButton),
                      ]
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        setState((){
                          print(sendInvitationIsPressed);
                          sendInvitationIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          sendInvitationIsPressed = false;
                          print(sendInvitationIsPressed);
                        });
                        if(_formKey.currentState.validate()){
                            ConnectionBrain().sendInvitation(_pr.partnerUsername, context);
                        }
                      },
                      child: Center(child: Text("Send an Invitation", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
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
