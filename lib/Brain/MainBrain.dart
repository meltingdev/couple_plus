import 'dart:math';
import 'dart:io';
import 'package:path/path.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final Firestore _fs = Firestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

class MainBrain extends ChangeNotifier {
  String desireText;
  String serviceText;
  String messageText;
  bool newPrivateMessage = false;
  bool isLoadingImage = false;
  int servicePrice = 0;
  String souvenirText;
  List<String> availablePrice = [];

  void getMessageText(String value) {
    messageText = value;
    notifyListeners();
  }

  void getSouvenirText(String value) {
    souvenirText = value;
    notifyListeners();
  }

  void getDesireText(String value) {
    desireText = value;
    notifyListeners();
  }

  void getServiceText(String value) {
    serviceText = value;
    notifyListeners();
  }

  void getServicePrice(String value) {
    servicePrice = int.parse(value);
    notifyListeners();
  }

  void getAvailablePrice() async {
    getServicePrice("0");
    availablePrice = [];
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    print(roomData.data["user1"]);
    print(roomData.data["user1Gem"]);
    print(roomData.data["user2"]);
    print(roomData.data["user2Gem"]);
    if (roomData.data["user1"] == myUsername) {
      for (int i = 0; i <= roomData.data["user1Gem"]; i++) {
        availablePrice.add(i.toString());
      }
    } else {
      for (int i = 0; i <= roomData.data["user2Gem"]; i++) {
        availablePrice.add(i.toString());
      }
    }
  }

  void sendPrivateMessage() async {
    _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Chat")
        .document()
        .setData({
      "text": messageText,
      "sender": myUsername,
      "image": "",
      "date": DateTime
          .now()
          .millisecondsSinceEpoch,
      "email": currentUserEmail,
      "read": false,
    });
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({"love": roomData.data["love"] + 1});

    notifyListeners();
  }

  Future checkNewPrivateMission() async {
    print("CHECKING FOR NEW PRIVATE MESSAGE...");
    var messages = await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Chat")
        .getDocuments();
    for (var message in messages.documents) {
      if (message.data["email"] != currentUserEmail) {
        if (message.data["read"] == false) {
          print("NEW PRIVATE MESSAGE FOUND...");
          newPrivateMessage = true;
          notifyListeners();
          return;
        }
      }
    }
    print("NO NEW PRIVATE MESSAGE FOUND...");
    newPrivateMessage = false;
    notifyListeners();
    return;
  }

  void readAllPrivateMessage() async {
    var messages = await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Chat")
        .getDocuments();
    for (var message in messages.documents) {
      message.reference.updateData({
        "read": true,
      });
      newPrivateMessage = false;
      notifyListeners();
    }
  }

  Future getImageInChat() async {
    isLoadingImage = true;
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    uploadImageInChat(image);
  }

  Future buyLeaderBoardFeature()async{
    await _fs.collection("Rooms").document("room $roomReference").updateData({
      "leaderBoard": true,
    });
  }

  Future buyAchievementsFeature()async{
    await _fs.collection("Rooms").document("room $roomReference").updateData({
      "achievement": true,
    });
  }

  Future uploadImageInChat(File image,) async {
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var url = await taskSnapshot.ref.getDownloadURL();
    print(url);
    print("image set in $currentUserEmail document");
    _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Chat")
        .document()
        .setData({
      "email": currentUserEmail,
      "sender": myUsername,
      "text": "",
      "image": url,
      "date": DateTime
          .now()
          .millisecondsSinceEpoch,
      "read": false,
    });
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({
      "love": roomData.data["love"] + 5,
      "souvenirs": roomData.data["souvenirs"] != null ? roomData.data["souvenirs"] + 1 : 1,
        });
    isLoadingImage = false;
    notifyListeners();
  }

  Future getImage() async {
    String souvenirReference = randomAlphaNumeric(20);
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("$image");
    String fileName = basename(image.path);
    StorageReference reference = _storage.ref().child("images/$fileName");
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var url = await taskSnapshot.ref.getDownloadURL();
    print(url);
    print("image set in  document");
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Souvenirs")
        .document(souvenirReference)
        .setData({
      "imageUrl": url,
      "souvenirReference": souvenirReference,
      "date": DateTime.now(),
      "createdAt": DateTime
          .now()
          .millisecondsSinceEpoch
    });
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({"love": roomData.data["love"] + 10});
    print("Upload over !");
  }

  Future<void> addDesireToDatabase(String desireText) async {
    String desireReference = randomAlphaNumeric(20);
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Desires")
        .document(desireReference)
        .setData({
      "sender": myUsername,
      "date": DateTime.now(),
      "createAt": DateTime
          .now()
          .millisecondsSinceEpoch,
      "desireText": desireText,
      "partnerOpinion": 5,
      "desireReference": desireReference,
    });
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({
      "love": roomData.data["love"] + 10,
      "desires": roomData["desires"] != null ? roomData["desires"] + 1: 1,
    });
  }

  Future<void> addServiceToDatabase(String desireText, int price,
      String username, DocumentSnapshot roomData) async {
    String serviceReference = randomAlphaNumeric(20);
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Services")
        .document(serviceReference)
        .setData({
      "sender": myUsername,
      "date": DateTime.now(),
      "createAt": DateTime
          .now()
          .millisecondsSinceEpoch,
      "serviceText": desireText,
      "price": price,
      "serviceReference": serviceReference,
    });
    if (roomData.data["user1"] == username) {
      await _fs.collection("Rooms").document("room $roomReference").updateData({
        "user1Gem": roomData.data["user1Gem"] - price,
      });
    } else {
      await _fs.collection("Rooms").document("room $roomReference").updateData({
        "user2Gem": roomData.data["user2Gem"] - price,
      });
    }
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({"love": roomData.data["love"] + 10,
      "services": roomData["services"] != null ? roomData["services"] + 1 : 1,});
  }

  Future<void> addAdminServiceToDatabase(String desireText) async {
    var rng = Random();
    await _fs
        .collection("Admin")
        .document("adminDocument")
        .collection("Services")
        .document()
        .setData({
      "serviceText": desireText,
      "price": rng.nextInt(20) + 5,
    });
  }

  Future<void> addRandomService(BuildContext context) async {
    String serviceReference = randomAlphaNumeric(20);
    QuerySnapshot servicesList = await _fs
        .collection("Admin")
        .document("adminDocument")
        .collection("Services")
        .getDocuments();
    var rng = Random();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Services")
        .document(serviceReference)
        .setData({
      "sender": myUsername,
      "date": DateTime.now(),
      "createAt": DateTime
          .now()
          .millisecondsSinceEpoch,
      "serviceText": servicesList
          .documents[rng.nextInt(servicesList.documents.length)]
          .data["serviceText"],
      "price": rng.nextInt(15)+5,
      "serviceReference": serviceReference,
    });
    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({"love": roomData.data["love"] + 10,
      "services": roomData["services"] + 1,});
  }

  Future<void> addRandomDesire(BuildContext context) async {
    String desireReference = randomAlphaNumeric(20);
    var rng = Random();
    QuerySnapshot desiresList = await _fs
        .collection("Admin")
        .document("adminDocument")
        .collection("Desire")
        .getDocuments();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Desires")
        .document(desireReference)
        .setData({
      "sender": myUsername,
      "date": DateTime.now(),
      "createAt": DateTime
          .now()
          .millisecondsSinceEpoch,
      "desireText": desiresList
          .documents[rng.nextInt(desiresList.documents.length)]
          .data["desireText"],
      "partnerOpinion": 5,
      "desireReference": desireReference,
    });

    roomData =
    await _fs.collection("Rooms").document("room $roomReference").get();
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .updateData({"love": roomData.data["love"] + 10,
      "desires": roomData["desires"] + 1});
  }

  Future<void> addAdminDesireToDatabase(String desireText) async {
    await _fs
        .collection("Admin")
        .document("adminDocument")
        .collection("Desire")
        .document()
        .setData({
      "desireText": desireText,
    });
  }

  Future<void> addNoteToDatabase(String souvenirReference,
      String souvenirText) async {
    await _fs
        .collection("Rooms")
        .document("room $roomReference")
        .collection("Souvenirs")
        .document(souvenirReference)
        .updateData({
      "souvenirText": souvenirText,
    });
  }
}