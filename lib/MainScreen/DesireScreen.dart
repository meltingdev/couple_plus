import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Component/BottomSheet.dart';
import 'package:coupleplus/Component/Element.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Firestore _fs = Firestore.instance;

class DesireScreen extends StatefulWidget {
  static String id = "DesireScreen";
  @override
  _DesireScreenState createState() => _DesireScreenState();
}

class _DesireScreenState extends State<DesireScreen> {
  bool desireButtonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs
            .collection("Rooms")
            .document("room $roomReference")
            .collection("Desires")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("There is No DATA");
          }
          List<Desire> desiresList = [];
          for (var desire in snapshot.data.documents) {
            Timestamp date = desire.data["date"];
            String formattedDate =
                DateFormat('yyyy MM dd').format(date.toDate());
            desiresList.add(Desire(
                desireText: desire.data["desireText"],
                date: formattedDate,
                sender: desire.data["sender"],
                partnerOpinion: desire.data["partnerOpinion"].toDouble(),
              desireReference: desire.data["desireReference"],
                ));
          }
          return ListView.builder(
              itemCount: desiresList.length + 2,
              itemBuilder: (BuildContext context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.only(
                          top: desireButtonIsPressed ? 24 : 16,
                          left: desireButtonIsPressed ? 24 : 16,
                          right: desireButtonIsPressed ? 8 : 16,
                          bottom: desireButtonIsPressed ? 8 : 16),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        width: data.size.width,
                        height: data.size.height / 15,
                        decoration: BoxDecoration(
                            color: kCTA,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(desireButtonIsPressed ? 0 : 8,
                                      desireButtonIsPressed ? 0 : 8),
                                  blurRadius: 0.0,
                                  color: kShadowButton),
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                print(desireButtonIsPressed);
                                desireButtonIsPressed = true;
                              });
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() {
                                desireButtonIsPressed = false;
                                print(desireButtonIsPressed);
                              });
                              showModalBottomSheet(
                                isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DesireBottomSheet();
                                  });
                            },
                            child: Center(
                                child: Text(
                              "Add a new Desire",
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
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    child: Divider(
                      thickness: 3.0,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16.0),
                  child: DesireElement(date: desiresList[index - 2].date, desireText: desiresList[index - 2].desireText, desireRef: desiresList[index - 2].desireReference, partnerOpinion: desiresList[index - 2].partnerOpinion, sender: desiresList[index - 2].sender),
                );
              });
        },
      ),
    );
  }
}

class Desire {
  Desire(
      {@required this.desireText,
      @required this.date,
      @required this.sender,
      @required this.partnerOpinion,
      @required this.desireReference});
  String sender;
  String date;
  String desireText;
  String desireReference;
  double partnerOpinion;
}

class DesireValue {
  List <String> desireValue = [
    "☠️",
    "😩",
    "😖",
    "😨",
    "🙁",
    "😐",
    "🙂",
    "😯",
    "😀",
    "😁",
    "🤩",

  ];
}