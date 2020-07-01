import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/BottomSheet.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/Drawer.dart';
import 'package:coupleplus/Component/Element.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/MainScreen/DesireScreen.dart';
import 'package:coupleplus/MainScreen/GalleryScreen.dart';
import 'package:coupleplus/MainScreen/ServiceScreen.dart';
import 'package:coupleplus/complementaryScreen/MoodsScreen.dart';
import 'package:coupleplus/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final Firestore _fs = Firestore.instance;


class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
  bool rewardedButtonIsPressed = false;
  bool serviceButtonIsPressed = false;
  bool desireButtonIsPressed = false;
  bool souvenirButtonIsPressed = false;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        drawer: HomeScreenDrawer(data: data),
        backgroundColor: kBackgroundColor,
        body: StreamBuilder<DocumentSnapshot>(
            initialData: roomData,
            stream: _fs
                .collection("Rooms")
                .document("room $roomReference")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(
                  child: Text(
                    "There is No Connection",
                    style: TextStyle(
                        fontFamily: "Dosis",
                        fontSize: data.size.width / 10,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }
              return ListView(
                children: <Widget>[
                  Row(
                    children: [
                      RawCoupleButton(function: ()async {
                        setState(() {
                          rewardedButtonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 300));
                        setState(() {
                          rewardedButtonIsPressed = false;
                        });
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(title: Text("Get 10 gems for you and your partner", textAlign: TextAlign.center,),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          content: Container(
                            height: data.size.height / 4,
                            child: Column(
                              children: [
                                Text("Support Us by watching an Ad",style: TextStyle(color: kSecondaryText, fontSize: data.size.width / 20,),),
                                GestureDetector(
                                  onTap: ()async {
                                    await myRewardedVideoAD.show().whenComplete(() =>
                                        myRewardedVideoAD.load(adUnitId:
                                        // TODO IOS AD ID
                                        "ca-app-pub-1019750920692164/2301865521"
                                            // TODO ANDROID AD ID
                                            // "ca-app-pub-1019750920692164/5852537226"
                                            , targetingInfo: targetingInfo));
                                    Navigator.pop(context);
                                  },
                                  child: Container(width: data.size.width / 4,
                                      height: data.size.width / 4,child: Image.asset("lib/images/ad.png")),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            FlatButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("No thanks", style: TextStyle(color: kSecondaryText, fontSize: data.size.width / 18,),)),
                            FlatButton(onPressed: ()async {
                              await myRewardedVideoAD.show().whenComplete(() =>
                                  myRewardedVideoAD.load(adUnitId:
                                  // TODO IOS AD ID
                                  "ca-app-pub-1019750920692164/2301865521"
                                      // TODO ANDROID AD ID
                                      // "ca-app-pub-1019750920692164/5852537226"
                                      , targetingInfo: targetingInfo));
                              Navigator.pop(context);
                            }, child: Text("Get Gems", style: TextStyle(color: kCTA, fontSize: data.size.width / 18,),))
                          ],);
                        });
                      }, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Transform.scale(scale: 2,child: Text("+", style: TextStyle(fontFamily: "Dosis", color: kCTA, fontSize: 20),)),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: data.size.width / 8,child: Image.asset("lib/images/cristal.png")),
                              Text("10", style: TextStyle(fontFamily: "Dosis", fontWeight: FontWeight.w700, color: Colors.white, fontSize: data.size.width / 20),),
                            ],
                          ),
                        ],),
                      ), buttonIsPressed: rewardedButtonIsPressed,width: data.size.width / 3, color: kSecondaryBackgroundColor, backColor: Colors.grey.shade400,),
                      Spacer(flex: 1,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.dehaze,
                              size: data.size.width / 10,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Love",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      width: data.size.width,
                      height: data.size.height / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kSecondaryBackgroundColor),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: IconButton(icon: Icon(Icons.info_outline, color: kSecondaryText,), onPressed: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), title: Text("How this is working ?"),
                                  content: Container(
                                    height: data.size.height / 1.7,
                                    child: Column(
                                      children: [
                                        Text("1"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Every actions in the app will increase your love for the day.", style: TextStyle(
                                            fontFamily: "Dosis", fontWeight: FontWeight.w600, color: kSecondaryText, fontSize: data.size.width / 20
                                          ),),
                                        ),
                                        Text("2"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("It show you, how many little actions you have made or your partner have done through the day.", style: TextStyle(
                                              fontFamily: "Dosis", fontWeight: FontWeight.w600, color: kSecondaryText, fontSize: data.size.width / 20
                                          ),),
                                        ),
                                        Text("3"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("At the End of the day, depends where you live, Love will be reset.", style: TextStyle(
                                              fontFamily: "Dosis", fontWeight: FontWeight.w600, color: kSecondaryText, fontSize: data.size.width / 20
                                          ),),
                                        ),
                                        Text("4"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("All the love of the day will be save and will be used on further version of the app", style: TextStyle(
                                              fontFamily: "Dosis", fontWeight: FontWeight.w600, color: kSecondaryText, fontSize: data.size.width / 20
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [FlatButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )],);
                              });
                            }),
                          ),
                          Center(
                            child: Transform.scale(
                              scale: 1.5,
                              child: Stack(
                                children: [
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: LiquidCustomProgressIndicator(
                                      value: snapshot.data["love"] / 100 + 0.07,
                                      direction: Axis.vertical,
                                      backgroundColor: Colors.white,
                                      valueColor:
                                          AlwaysStoppedAnimation(kLoveShadow),
                                      shapePath: _buildHeartPath(),
                                    ),
                                  ),
                                  LiquidCustomProgressIndicator(
                                    value: snapshot.data["love"] / 100 + 0.05,
                                    direction: Axis.vertical,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation(kCTA),
                                    shapePath: _buildHeartPath(),
                                    center: Text(
                                      "${snapshot.data["love"]} %",
                                      style: TextStyle(
                                        color: Colors.pinkAccent.shade100,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Money",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      width: data.size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kSecondaryBackgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: data.size.width / 2.5,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data["user1"],
                                        style: TextStyle(
                                            fontFamily: "Dosis",
                                            fontWeight: FontWeight.w700,
                                            fontSize: data.size.width / 16),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: data.size.height / 18,
                                    width: data.size.height / 18,
                                    child: Image(
                                      image:
                                          AssetImage("lib/images/cristal.png"),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data["user1Gem"].toString(),
                                    style: TextStyle(
                                        fontFamily: "Dosis",
                                        fontSize: data.size.width / 14,
                                        fontWeight: FontWeight.w700,
                                        color: kCTA),
                                  )
                                ],
                              ),
                            ),
                            VerticalDivider(
                              width: 5,
                              thickness: 3.0,
                            ),
                            Container(
                              width: data.size.width / 2.5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data["user2"].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Dosis",
                                          fontWeight: FontWeight.w700,
                                          fontSize: data.size.width / 16),
                                    ),
                                  ),
                                  Container(
                                    height: data.size.height / 18,
                                    width: data.size.height / 18,
                                    child: Image(
                                      image:
                                          AssetImage("lib/images/cristal.png"),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data["user2Gem"].toString(),
                                    style: TextStyle(
                                        fontFamily: "Dosis",
                                        fontSize: data.size.width / 14,
                                        fontWeight: FontWeight.w700,
                                        color: kCTA),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Today's feeling",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      width: data.size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kSecondaryBackgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: data.size.width / 2.5,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data["user1"],
                                        style: TextStyle(
                                            fontFamily: "Dosis",
                                            fontWeight: FontWeight.w700,
                                            fontSize: data.size.width / 16),
                                      ),
                                    ),
                                  ),
                                  snapshot.data["user1"] == myUsername
                                      ? RaisedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, MoodsScreen.id);
                                          },
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: Text(
                                            snapshot.data["user1Mood"],
                                            style: TextStyle(
                                                fontSize: data.size.width / 8),
                                          ),
                                        )
                                      : Container(
                                          height: data.size.height / 12,
                                          width: data.size.height / 12,
                                          child: Text(
                                            snapshot.data["user1Mood"],
                                            style: TextStyle(
                                                fontSize: data.size.width / 8),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              width: 5,
                              thickness: 3.0,
                            ),
                            Container(
                              width: data.size.width / 2.5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data["user2"].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Dosis",
                                          fontWeight: FontWeight.w700,
                                          fontSize: data.size.width / 16),
                                    ),
                                  ),
                                  snapshot.data["user2"] == myUsername
                                      ? RaisedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, MoodsScreen.id);
                                          },
                                          elevation: 5.0,
                                          shape: CircleBorder(),
                                          color: kCTA,
                                          child: Text(
                                            snapshot.data["user2Mood"],
                                            style: TextStyle(
                                                fontSize: data.size.width / 8),
                                          ),
                                        )
                                      : Container(
                                          height: data.size.height / 12,
                                          width: data.size.height / 12,
                                          child: Text(
                                            snapshot.data["user2Mood"],
                                            style: TextStyle(
                                                fontSize: data.size.width / 8),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Last Service",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _fs
                        .collection("Rooms")
                        .document("room $roomReference")
                        .collection("Services")
                        .orderBy("createAt", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("There is No DATA");
                      }
                      List<Service> servicesList = [];
                      for (var service in snapshot.data.documents) {
                        Timestamp date = service.data["date"];
                        String formattedDate =
                            DateFormat('yyyy MM dd').format(date.toDate());
                        servicesList.add(Service(
                          serviceText: service.data["serviceText"],
                          date: formattedDate,
                          sender: service.data["sender"],
                          price: service.data["price"].toDouble(),
                          serviceReference: service.data["serviceReference"],
                        ));
                      }
                      if (servicesList.length == 0) {
                        return CoupleButton(
                            color: Color(0xFF7000FF),
                            backColor: Color(0xFF350079),
                            function: () async {
                              setState(() {
                                serviceButtonIsPressed = true;
                              });
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() {
                                serviceButtonIsPressed = false;
                              });
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ServiceBottomSheet();
                                  });
                            },
                            buttonText: "Add a Service",
                            buttonIsPressed: serviceButtonIsPressed);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ServiceElement(
                              sender: servicesList[0].sender,
                              date: servicesList[0].date,
                              serviceText: servicesList[0].serviceText,
                              serviceReference:
                                  servicesList[0].serviceReference,
                              price: servicesList[0].price),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Last Desire",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _fs
                        .collection("Rooms")
                        .document("room $roomReference")
                        .collection("Desires")
                        .orderBy("createAt", descending: true)
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
                            partnerOpinion:
                                desire.data["partnerOpinion"].toDouble(),
                            desireReference: desire.data["desireReference"]));
                      }
                      if (desiresList.length == 0) {
                        return CoupleButton(
                          color: kCTA,
                            backColor: kShadowButton,
                            function: () async {
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
                            buttonText: "Add a Desire",
                            buttonIsPressed: desireButtonIsPressed);
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DesireElement(
                                date: desiresList[0].date,
                                desireText: desiresList[0].desireText,
                                desireRef: desiresList[0].desireReference,
                                partnerOpinion: desiresList[0].partnerOpinion,
                                sender: desiresList[0].sender));
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text(
                      "Last Souvenirs",
                      style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w700,
                          color: kSecondaryText,
                          fontSize: data.size.width / 14),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _fs
                          .collection("Rooms")
                          .document("room $roomReference")
                          .collection("Souvenirs")
                          .orderBy("createdAt", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("There is No DATA");
                        }
                        List<Souvenir> souvenirsList = [];
                        for (var souvenir in snapshot.data.documents) {
                          Timestamp date = souvenir.data["date"];
                          String formattedDate =
                              DateFormat('yyyy MM dd').format(date.toDate());
                          souvenirsList.add(Souvenir(
                              imageUrl: souvenir.data["imageUrl"],
                              date: formattedDate,
                              souvenirReference:
                                  souvenir.data["souvenirReference"],
                              souvenirText: souvenir.data["souvenirText"]));
                        }
                        if (souvenirsList.length == 0) {
                          return CoupleButton(
                              color: Color(0xFF00FFE0),
                              backColor: Color(0xFF007163),
                              function: () async {
                                setState(() {
                                  souvenirButtonIsPressed = true;
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                setState(() {
                                  souvenirButtonIsPressed = false;
                                });
                                setState(() {
                                  showSpinner = true;
                                });

                                await MainBrain().getImage();
                                setState(() {
                                  showSpinner = false;
                                });
                              },
                              buttonText: "Add a Picture",
                              buttonIsPressed: souvenirButtonIsPressed);
                        } else {
                          return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SouvenirElement(
                                  imageUrl: souvenirsList[0].imageUrl,
                                  date: souvenirsList[0].date,
                                  souvenirReference:
                                      souvenirsList[0].souvenirReference,
                                  souvenirText: souvenirsList[0].souvenirText));
                        }
                      }),
                  SizedBox(
                    height: data.size.height / 7,
                  )
                ],
              );
            }),
      ),
    );
  }
}


