
import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';





class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.sender, this.text, this.isMe, this.image, @required this.rank});
  final int rank;
  final String sender;
  final String text;
  final bool isMe;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? kCTA : Color(0xFFE1E1E1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: image == ""
                  ? Text(
                      text,
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                        image: NetworkImage(image),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}


