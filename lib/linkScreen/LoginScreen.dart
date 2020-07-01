import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loginButtonIsPressed = false;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    var _pr = Provider.of<ConnectionBrain>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    iconSize: data.size.height / 15,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(
                  height: data.size.height / 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Log in", style: TextStyle(
                        fontSize: data.size.height / 15,
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w800
                    ),
                    ),
                  ),
                ),
                SizedBox(
                  height: data.size.height / 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter something";
                    } else if (EmailValidator.validate(value) == false) {
                      return "E-mail is badly formated";
                    }
                    return null;
                  },
                  onChanged: (String value){
                    _pr.getEmail(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: kSecondaryText,),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: kSecondaryText, fontFamily: "Dosis", fontWeight: FontWeight.w600, fontSize: data.size.width / 18),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryBackgroundColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kCTA, width: 3.0),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (String value){
                    _pr.getPassword(value);
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter something";
                    } else if (value.length < 8) {
                      return "Password is not long enough(8 letter minimum)";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: kSecondaryText,),
                    labelText: "Password",
                    labelStyle: TextStyle(color: kSecondaryText, fontFamily: "Dosis", fontWeight: FontWeight.w600, fontSize: data.size.width / 18),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryBackgroundColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kCTA, width: 3.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.only(top: loginButtonIsPressed ? 24 : 16, left: loginButtonIsPressed ? 24 : 16, right: loginButtonIsPressed ? 8 : 16, bottom: loginButtonIsPressed ? 8 : 16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: data.size.width,
                      height: data.size.height / 15,
                      decoration: BoxDecoration(
                          color: Color(0xFF7000FF),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(offset: Offset(loginButtonIsPressed ? 0 : 8, loginButtonIsPressed ? 0 : 8), blurRadius: 0.0, color: Color(0xFF350079)),
                          ]
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: ()async{
                            setState((){
                              print(loginButtonIsPressed);
                              loginButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              loginButtonIsPressed = false;
                              print(loginButtonIsPressed);
                            });
                            if(_formKey.currentState.validate()){
                              setState(() {
                                showSpinner = true;
                              });
                              await ConnectionBrain().logInUser(_pr.email, _pr.password, context);
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                          child: Center(child: Text("Log in", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
