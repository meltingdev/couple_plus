import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/Component/Element.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final Firestore _fs = Firestore.instance;

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool galleryButtonIsPressed = false;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _fs
                .collection("Rooms")
                .document("room $roomReference")
                .collection("Souvenirs").orderBy("createdAt", descending: true)
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
                souvenirsList.add(Souvenir(date: formattedDate, souvenirReference: souvenir.data["souvenirReference"], imageUrl: souvenir.data["imageUrl"], souvenirText:souvenir.data["souvenirText"] ));
              }
              return ListView.builder(
                  itemCount: souvenirsList.length + 2,
                  itemBuilder: (BuildContext context, index) {
                    if (index == 0) {
                      return CoupleButton(
                          color: Color(0xFF00FFE0),
                          backColor: Color(0xFF007163),
                          buttonIsPressed: galleryButtonIsPressed,
                          buttonText: "Add a new Picture",
                          function: ()async {
                            setState(() {
                              galleryButtonIsPressed = true;
                            });
                            await Future.delayed(Duration(milliseconds: 200));
                            setState(() {
                              galleryButtonIsPressed = false;
                            });
                            setState(() {
                              showSpinner = true;
                            });

                            await MainBrain().getImage();
                            setState(() {
                              showSpinner = false;
                            });
                          }
                      );
                    } else if (index == 1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 3.0,
                        ),
                      );
                    }
                    return SouvenirElement(date: souvenirsList[index -2 ].date,imageUrl: souvenirsList[index -2 ].imageUrl,souvenirReference: souvenirsList[index -2 ].souvenirReference,souvenirText: souvenirsList[index -2 ].souvenirText,);
                  },);
            },
          ),
        ),
      ),
    );
  }
}

class Souvenir{
  Souvenir(
      {@required this.imageUrl,
        @required this.date,
        @required this.souvenirReference, @required this.souvenirText});
  String date;
  String souvenirReference;
  String imageUrl;
  String souvenirText;
}