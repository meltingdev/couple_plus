import 'package:coupleplus/Brain/ConnectionBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:provider/provider.dart';
import 'package:coupleplus/linkScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool registerButtonIsPressed = false;
  bool showSpinner = false;
  bool available;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<ConnectionBrain>(context);
    final data = MediaQuery.of(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    child: Text("Register", style: TextStyle(
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
                  onChanged: (String value){
                    _pr.getPassword(value);
                  },
                  decoration: InputDecoration(
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
                AnimatedPadding(
                  duration: Duration(milliseconds: 100),
                  padding: EdgeInsets.only(top: registerButtonIsPressed ? 24 : 16, left: registerButtonIsPressed ? 24 : 16, right: registerButtonIsPressed ? 8 : 16, bottom: registerButtonIsPressed ? 8 : 16),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width: data.size.width,
                    height: data.size.height / 15,
                    decoration: BoxDecoration(
                      color: kCTA,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(offset: Offset(registerButtonIsPressed ? 0 : 8,registerButtonIsPressed ? 0 : 8), blurRadius: 0.0, color: kShadowButton),
                      ]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: ()async{
                          setState((){
                            print(registerButtonIsPressed);
                            registerButtonIsPressed = true;
                          });
                          await Future.delayed(Duration(milliseconds: 200));
                          setState(() {
                            registerButtonIsPressed = false;
                            print(registerButtonIsPressed);
                          });
                          if(_formKey.currentState.validate()){
                            setState(() {
                              showSpinner = true;
                            });
                            await ConnectionBrain().createUser(_pr.email, _pr.password,context);
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                        child: Center(child: Text("Register", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: kTextButton, fontSize: data.size.width / 16),)),
                      ),
                    ),
                  ),
                ),
                Center(child: Text("Or")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: (){
Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: RichText(
                      text: TextSpan(text: "Already have an account ?", style: TextStyle(color: kMainTextColor),
                      children: <TextSpan>[
                        TextSpan(text: " Tap Here", style: TextStyle(color: kCTA))
                      ],),
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
