import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/Component/messages.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Firestore _fs = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static String id ="ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          "Chat"

        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fs
          .collection("Rooms")
          .document("room $roomReference")
                    .collection("Chat")
                    .orderBy("date", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                    final messages = snapshot.data.documents.reversed;
                    List<MessageBubble> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data["text"];
                      final messageSender = message.data["sender"];
                      final messageImage = message.data["image"];
                      final messageRankUser = message.data["rank"];
                      final messageBubble = MessageBubble(
                        rank: messageRankUser,
                        image: messageImage,
                        sender: messageSender,
                        text: messageText,
                        isMe: myUsername ==
                            messageSender,
                      );
                      messageBubbles.add(messageBubble);
                    }
                    return ListView(
                      controller: _scrollController,
                      reverse: true,
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      children: messageBubbles,
                    );
                  } else {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageTextController,
              minLines: 1,
              maxLines: 6,
              autocorrect: true,
              onChanged: (String value) {
                Provider.of<MainBrain>(context, listen: false).getMessageText(value);
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                suffixIcon: Container(
                  width: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          MainBrain().getImageInChat();
                          messageTextController.clear();
                        },
                        icon: Icon(
                          Icons.panorama,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          messageTextController.clear();
                          Provider.of<MainBrain>(context,listen: false)
                              .sendPrivateMessage();
                        },
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: kCTA,
                        ),
                      ),
                    ],
                  ),
                ),
                filled: true,
                fillColor: kBackgroundColor,
                hintText: "Send a message",
                focusColor: kBackgroundColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.black87),
                    borderRadius: BorderRadius.circular(20.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.black26),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
