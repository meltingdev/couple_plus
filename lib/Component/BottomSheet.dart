import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Firestore _fs = Firestore.instance;


class DesireBottomSheet extends StatefulWidget {
  @override
  _DesireBottomSheetState createState() => _DesireBottomSheetState();
}

class _DesireBottomSheetState extends State<DesireBottomSheet> {
  bool addDesireButtonIsPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<MainBrain>(context);
    final data = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Container(
          height: data.size.height / 1.3,
          width: data.size.width,
          color: kBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Share an idea or desire for the futur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w600,
                        fontSize: data.size.width / 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter something";
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _pr.getDesireText(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText:
                            "ex: I want to go hiking this week-end 🏃‍♂️",
                        labelStyle: TextStyle(
                            color: kSecondaryText,
                            fontFamily: "Dosis",
                            fontWeight: FontWeight.w600,
                            fontSize: data.size.width / 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: kSecondaryBackgroundColor, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kCTA, width: 3.0),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.only(
                        top: addDesireButtonIsPressed ? 24 : 16,
                        left: addDesireButtonIsPressed ? 24 : 16,
                        right: addDesireButtonIsPressed ? 8 : 16,
                        bottom: addDesireButtonIsPressed ? 8 : 16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: data.size.width,
                      height: data.size.height / 15,
                      decoration: BoxDecoration(
                          color: kCTA,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(addDesireButtonIsPressed ? 0 : 8,
                                    addDesireButtonIsPressed ? 0 : 8),
                                blurRadius: 0.0,
                                color: kShadowButton),
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              print(addDesireButtonIsPressed);
                              addDesireButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              addDesireButtonIsPressed = false;
                              print(addDesireButtonIsPressed);
                            });
                            if (_formKey.currentState.validate()) {
                              await MainBrain()
                                  .addDesireToDatabase(_pr.desireText);
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                              child: Text(
                            "Add the desire",
                            style: TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w700,
                                color: kTextButton,
                                fontSize: data.size.width / 16),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class ServiceBottomSheet extends StatefulWidget {
  @override
  _ServiceBottomSheetState createState() => _ServiceBottomSheetState();
}

class _ServiceBottomSheetState extends State<ServiceBottomSheet> {
  bool addDesireButtonIsPressed = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<MainBrain>(context);
    final data = MediaQuery.of(context);
    print(_pr.availablePrice);
    return Form(
      key: _formKey,
      child: Container(
          height: data.size.height / 1.3,
          width: data.size.width,
          color: kBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ask for services in exchanges of Gems",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w600,
                        fontSize: data.size.width / 14),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter something";
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            _pr.getServiceText(value);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "ex: Bring me a coffee️",
                            labelStyle: TextStyle(
                                color: kSecondaryText,
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w600,
                                fontSize: data.size.width / 16),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryBackgroundColor, width: 1.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7000FF), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _pr.servicePrice.toString(),
                              items: _pr.availablePrice.map(
                                (price) {
                                  return DropdownMenuItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          price.toString(),
                                          style: TextStyle(
                                              fontFamily: "Dosis",
                                              fontSize: data.size.width / 14,
                                              fontWeight: FontWeight.w700,
                                              color: kCTA),
                                        ),
                                        Container(
                                          height: data.size.height / 22,
                                          width: data.size.height / 22,
                                          child: Image(
                                            image: AssetImage(
                                                "lib/images/cristal.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: price.toString(),
                                  );
                                },
                              ).toList(),
                              onChanged: (String value) async {
                                _pr.getServicePrice(value);
                              }),
                        ),
                      ),
                    ],
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.only(
                        top: addDesireButtonIsPressed ? 24 : 16,
                        left: addDesireButtonIsPressed ? 24 : 16,
                        right: addDesireButtonIsPressed ? 8 : 16,
                        bottom: addDesireButtonIsPressed ? 8 : 16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: data.size.width,
                      height: data.size.height / 15,
                      decoration: BoxDecoration(
                          color: Color(0xFF7000FF),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(addDesireButtonIsPressed ? 0 : 8,
                                    addDesireButtonIsPressed ? 0 : 8),
                                blurRadius: 0.0,
                                color: Color(0xFF350079)),
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              print(addDesireButtonIsPressed);
                              addDesireButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              addDesireButtonIsPressed = false;
                              print(addDesireButtonIsPressed);
                            });
                            if (_formKey.currentState.validate()) {
                              roomData = await _fs.collection("Rooms").document("room $roomReference").get();
                              await MainBrain().addServiceToDatabase(
                                  _pr.serviceText,
                                  _pr.servicePrice,
                                  myUsername,
                                  roomData);
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                              child: Text(
                            "Add the Service",
                            style: TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w700,
                                color: kTextButton,
                                fontSize: data.size.width / 16),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class GalleryBottomSheet extends StatefulWidget {
  GalleryBottomSheet({@required this.souvenirRef});
  final String souvenirRef;
  @override
  _GalleryBottomSheetState createState() => _GalleryBottomSheetState();
}

class _GalleryBottomSheetState extends State<GalleryBottomSheet> {
  bool addNoteButtonIsPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<MainBrain>(context);
    final data = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Container(
          height: data.size.height / 1.3,
          width: data.size.width,
          color: kBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add a note to this picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w600,
                        fontSize: data.size.width / 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter something";
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _pr.getSouvenirText(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "ex: Our first cupcakes 🍰",
                        labelStyle: TextStyle(
                            color: kSecondaryText,
                            fontFamily: "Dosis",
                            fontWeight: FontWeight.w600,
                            fontSize: data.size.width / 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: kSecondaryBackgroundColor, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00FFE0), width: 3.0),
                        ),
                      ),
                    ),
                  ),
                  CoupleButton(
                      color: Color(0xFF00FFE0),
                      backColor: Color(0xFF007163),
                      function: () async {
                        setState(() {
                          addNoteButtonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          addNoteButtonIsPressed = false;
                        });
                        if (_formKey.currentState.validate()) {
                          await MainBrain().addNoteToDatabase(
                              widget.souvenirRef, _pr.souvenirText);
                          Navigator.pop(context);
                        }
                      },
                      buttonText: "Add the note",
                      buttonIsPressed: addNoteButtonIsPressed)
                ],
              ),
            ),
          )),
    );
  }
}

class AdminServiceBottomSheet extends StatefulWidget {
  @override
  _AdminServiceBottomSheetState createState() =>
      _AdminServiceBottomSheetState();
}

class _AdminServiceBottomSheetState extends State<AdminServiceBottomSheet> {
  bool addDesireButtonIsPressed = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<MainBrain>(context);
    final data = MediaQuery.of(context);
    print(_pr.availablePrice);
    return Form(
      key: _formKey,
      child: Container(
          height: data.size.height / 1.3,
          width: data.size.width,
          color: kBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ask for services in exchanges of Gems",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w600,
                        fontSize: data.size.width / 14),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter something";
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            _pr.getServiceText(value);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "ex: Bring me a coffee️",
                            labelStyle: TextStyle(
                                color: kSecondaryText,
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w600,
                                fontSize: data.size.width / 16),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryBackgroundColor, width: 1.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kCTA, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.only(
                        top: addDesireButtonIsPressed ? 24 : 16,
                        left: addDesireButtonIsPressed ? 24 : 16,
                        right: addDesireButtonIsPressed ? 8 : 16,
                        bottom: addDesireButtonIsPressed ? 8 : 16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: data.size.width,
                      height: data.size.height / 15,
                      decoration: BoxDecoration(
                          color: kCTA,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(addDesireButtonIsPressed ? 0 : 8,
                                    addDesireButtonIsPressed ? 0 : 8),
                                blurRadius: 0.0,
                                color: kShadowButton),
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              print(addDesireButtonIsPressed);
                              addDesireButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              addDesireButtonIsPressed = false;
                              print(addDesireButtonIsPressed);
                            });
                            if (_formKey.currentState.validate()) {
                              await MainBrain()
                                  .addAdminServiceToDatabase(_pr.serviceText);
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                              child: Text(
                            "Add the Service",
                            style: TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w700,
                                color: kTextButton,
                                fontSize: data.size.width / 16),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class AdminDesireBottomSheet extends StatefulWidget {
  @override
  _AdminDesireBottomSheetState createState() => _AdminDesireBottomSheetState();
}

class _AdminDesireBottomSheetState extends State<AdminDesireBottomSheet> {
  bool addDesireButtonIsPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<MainBrain>(context);
    final data = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Container(
          height: data.size.height / 1.3,
          width: data.size.width,
          color: kBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Share an idea or desire for the futur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontWeight: FontWeight.w600,
                        fontSize: data.size.width / 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter something";
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _pr.getDesireText(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText:
                            "ex: I want to go hiking this week-end 🏃‍♂️",
                        labelStyle: TextStyle(
                            color: kSecondaryText,
                            fontFamily: "Dosis",
                            fontWeight: FontWeight.w600,
                            fontSize: data.size.width / 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: kSecondaryBackgroundColor, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kCTA, width: 3.0),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.only(
                        top: addDesireButtonIsPressed ? 24 : 16,
                        left: addDesireButtonIsPressed ? 24 : 16,
                        right: addDesireButtonIsPressed ? 8 : 16,
                        bottom: addDesireButtonIsPressed ? 8 : 16),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: data.size.width,
                      height: data.size.height / 15,
                      decoration: BoxDecoration(
                          color: kCTA,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(addDesireButtonIsPressed ? 0 : 8,
                                    addDesireButtonIsPressed ? 0 : 8),
                                blurRadius: 0.0,
                                color: kShadowButton),
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              print(addDesireButtonIsPressed);
                              addDesireButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              addDesireButtonIsPressed = false;
                              print(addDesireButtonIsPressed);
                            });
                            if (_formKey.currentState.validate()) {
                              await MainBrain()
                                  .addAdminDesireToDatabase(_pr.desireText);
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                              child: Text(
                            "Add the desire",
                            style: TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.w700,
                                color: kTextButton,
                                fontSize: data.size.width / 16),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
