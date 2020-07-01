
import 'package:coupleplus/Component/BottomSheet.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:coupleplus/MainScreen/DesireScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'kcolor.dart';

final Firestore _fs = Firestore.instance;

class ServiceElement extends StatefulWidget {
  ServiceElement({
    @required this.sender, @required this.date, @required this.serviceText, @required this.serviceReference, @required this.price,
});
  final String sender;
  final String date;
  final String serviceText;
  final String serviceReference;
  final double price;


  @override
  _ServiceElementState createState() => _ServiceElementState();
}

class _ServiceElementState extends State<ServiceElement> {
  bool buttonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: data.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: kSecondaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10.0,
                  offset: Offset(3, 3)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontFamily: "Dosis",
                          color: kSecondaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: data.size.width / 20),
                    ),
                    Text(
                      widget.sender,
                      style: TextStyle(
                          fontFamily: "Dosis",
                          color: kSecondaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: data.size.width / 20),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        20.0),
                                  ),
                                  title: Text(
                                      "Do you want to Delete this desire ?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 18.0,
                                            color: kCTA),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        roomData = await _fs.collection("Rooms").document("room $roomReference").get();
                                        print(widget.price);
                                        await _fs
                                            .collection("Rooms")
                                            .document(
                                            "room $roomReference")
                                            .collection("Services")
                                            .document(
                                            widget.serviceReference)
                                            .delete();
                                        if(widget.sender == myUsername) {
                                          if(roomData.data["user1"] == myUsername) {
                                            print("Add Gems to $myUsername");
                                            await _fs.collection(
                                                "Rooms")
                                                .document(
                                                "room $roomReference")
                                                .updateData({
                                              "user1Gem": roomData
                                                  .data["user1Gem"] +
                                                  widget.price.round()
                                            });
                                          }else{
                                            await _fs.collection(
                                                "Rooms")
                                                .document(
                                                "room $roomReference")
                                                .updateData({
                                              "user1Gem" : roomData.data["user2Gem"] + widget.price.round()
                                            });
                                          }
                                        } else {
                                          if(roomData.data["user1"] == myUsername) {
                                            await _fs.collection(
                                                "Rooms")
                                                .document(
                                                "room $roomReference")
                                                .updateData({
                                              "user2Gem": roomData
                                                  .data["user2Gem"] +
                                                  widget.price.round()
                                            });
                                          }else{
                                            await _fs.collection(
                                                "Rooms")
                                                .document(
                                                "room $roomReference")
                                                .updateData({
                                              "user1Gem" : roomData.data["user1Gem"] + widget.price.round()
                                            });
                                          }
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 18.0,
                                            color:
                                            Colors.black54),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: data.size.width / 1.8,
                        child: Text(widget.serviceText,
                            softWrap: true,
                            style: TextStyle(
                                fontFamily: "Dosis",
                                color: kMainText,
                                fontWeight: FontWeight.w700,
                                fontSize: data.size.width / 16))),
                    Center(
                      child: Container(
                          width: data.size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                height: data.size.height / 18,
                                width: data.size.height / 18,
                                child: Image(
                                  image: AssetImage(
                                      "lib/images/cristal.png"),
                                ),
                              ),
                              Text(widget.price.round().toString(),
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Dosis",
                                      color: kCTA,
                                      fontWeight: FontWeight.w700,
                                      fontSize: data.size.width / 16)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
                widget.sender == myUsername ?
                    CoupleButton(
                        color: Color(0xFF7000FF),
                        backColor: Color(0xFF350079), function:
                          ()async {
                        setState(() {
                          buttonIsPressed = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        setState(() {
                          buttonIsPressed = false;
                        });
                        if(roomData.data["user1"] == myUsername) {
                          await _fs.collection(
                              "Rooms")
                              .document(
                              "room $roomReference")
                              .updateData({
                            "user2Gem": roomData
                                .data["user2Gem"] +
                                widget.price.round()
                          });
                        }else{
                          await _fs.collection(
                              "Rooms")
                              .document(
                              "room $roomReference")
                              .updateData({
                            "user1Gem" : roomData.data["user1Gem"] + widget.price.round()
                          });
                        }
                        await _fs.collection(
                            "Rooms")
                            .document(
                            "room $roomReference").collection("Services").document(widget.serviceReference).delete();
                      }
                    , buttonText: "Reward your partner", buttonIsPressed: buttonIsPressed):Row(children: [
                      Text("Do this service and get rewarded",style: TextStyle(
                    fontFamily: "Dosis",
                    color: kSecondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: data.size.width / 16),)
                ],)
            ],
          ),
        ),
      ),
    );
  }
}

class DesireElement extends StatefulWidget {
  DesireElement({
   @required this.date, @required this.desireText, @required this.desireRef, @required this.partnerOpinion, @required this.sender
});
  final String date;
  final String desireText;
  final String desireRef;
  final double partnerOpinion;
  final String sender;
  @override
  _DesireElementState createState() => _DesireElementState();
}

class _DesireElementState extends State<DesireElement> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: data.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: kSecondaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10.0,
                  offset: Offset(3, 3)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.date, style: TextStyle(fontFamily: "Dosis", color: kSecondaryText, fontWeight: FontWeight.w600, fontSize: data.size.width / 20),),
                    Text(widget.sender, style: TextStyle(fontFamily: "Dosis", color: kSecondaryText, fontWeight: FontWeight.w600, fontSize: data.size.width / 20),),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  title: Text("Do you want to Delete this desire ?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            color: kCTA),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () async{
                                        await _fs.collection("Rooms").document("room $roomReference").collection("Desires").document(widget.desireRef).delete();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert),
                        ))
                  ],
                ),
              ),
              Container(width: data.size.width -84,child: Text(widget.desireText, softWrap: true, style: TextStyle(fontFamily: "Dosis", color: kMainText, fontWeight: FontWeight.w700, fontSize: data.size.width / 16))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Slider(
                  label: "your partner: ${DesireValue().desireValue[widget.partnerOpinion.round()]}",
                  activeColor: kCTA,
                  value: widget.partnerOpinion,
                  onChanged: (double value)async {
                    if(widget.sender == myUsername){
                    } else {
                      await _fs.collection("Rooms").document("room $roomReference").collection("Desires").document(widget.desireRef).updateData({
                        "partnerOpinion": value,
                      });
                    }

                  },
                  min: 0,
                  max: 10,
                  divisions: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SouvenirElement extends StatefulWidget {
  SouvenirElement(
      {@required this.imageUrl,
        @required this.date,
        @required this.souvenirReference, @required this.souvenirText});
  final String date;
  final String souvenirReference;
  final String imageUrl;
  final String souvenirText;
  @override
  _SouvenirElementState createState() => _SouvenirElementState();
}

class _SouvenirElementState extends State<SouvenirElement> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: data.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: kSecondaryBackgroundColor
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.date, style: TextStyle(fontFamily: "Dosis", color: kSecondaryText, fontWeight: FontWeight.w600, fontSize: data.size.width / 20),),
                ),
                Spacer(flex: 1,),
                IconButton(
                  onPressed: (){
                    showModalBottomSheet(isScrollControlled: true,context: context, builder: (BuildContext context){
                      return GalleryBottomSheet(souvenirRef: widget.souvenirReference);
                    });
                  },
                  icon: Icon(Icons.create),
                )
              ],),
            ),
            Image(image: NetworkImage(widget.imageUrl),fit: BoxFit.fitWidth,),
            widget.souvenirText != null ?Container():SizedBox(
              height: data.size.height / 14,
            ),
            widget.souvenirText != null ?
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.souvenirText, style: TextStyle(fontFamily: "Dosis", color: kMainText, fontWeight: FontWeight.w600, fontSize: data.size.width / 18),),
            ): Container()
          ],
        ),
      ),
    );
  }
}


