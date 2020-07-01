import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/linkScreen/LoginScreen.dart';
import 'package:coupleplus/linkScreen/RegisterScreen.dart';
import 'package:flutter/material.dart';

class ChooseAuthMethodScreen extends StatefulWidget {
  static String id = "ChooseAuthMethodScreen";
  @override
  _ChooseAuthMethodScreenState createState() => _ChooseAuthMethodScreenState();
}

class _ChooseAuthMethodScreenState extends State<ChooseAuthMethodScreen> {
  bool registerButtonIsPressed = false;
  bool loginButtonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: data.size.width,
            height: data.size.height,
            child: Image.asset("lib/images/background.png", fit: BoxFit.fill,),
          ),
          ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              SizedBox(height: data.size.height / 8,),
              Container(height: data.size.height / 3,child: Image.asset("lib/images/loading_logo.png")),
              AnimatedPadding(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.only(
                    top: registerButtonIsPressed ? 24 : 16,
                    left: registerButtonIsPressed ? 24 : 16,
                    right: registerButtonIsPressed ? 8 : 16,
                    bottom: registerButtonIsPressed ? 8 : 16),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: data.size.width,
                  decoration: BoxDecoration(

                      color: kCTA,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(registerButtonIsPressed ? 0 : 8,
                              registerButtonIsPressed ? 0 : 8),
                          blurRadius: 0.0,
                          color: kShadowButton,
                        )]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        setState(() {
                          registerButtonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          registerButtonIsPressed = false;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        Navigator.pushNamed(context, RegisterScreen.id);

                      },
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                  fontFamily: "Dosis",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: data.size.width / 16),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              AnimatedPadding(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.only(
            top: loginButtonIsPressed ? 24 : 16,
            left: loginButtonIsPressed ? 24 : 16,
            right: loginButtonIsPressed ? 8 : 16,
            bottom: loginButtonIsPressed ? 8 : 16),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          width: data.size.width,
          decoration: BoxDecoration(
            border: Border.all(width: data.size.width / 40, color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(loginButtonIsPressed ? 0 : 8,
                        loginButtonIsPressed ? 0 : 8),
                    blurRadius: 0.0,
                    color: Colors.grey.shade200,
                )]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: ()async{
                setState(() {
                  loginButtonIsPressed = true;
                });
                await Future.delayed(Duration(milliseconds: 200));
                setState(() {
                  loginButtonIsPressed = false;
                });
                await Future.delayed(Duration(milliseconds: 200));
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: data.size.width / 16),
                    ),
                  )),
            ),
          ),
        ),
      ),
            ],
          )
        ],
      ),
    );
  }
}
