import 'package:coupleplus/Brain/MainBrain.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/MainScreen/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NavBar extends StatefulWidget {
  NavBar({
    @required this.pageController, @required this.activePage
});
  PageController pageController;
  int activePage;
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: data.size.height / 10,
          decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(color:Colors.black.withOpacity(0.1), blurRadius: 10.0, offset: Offset(2, 2))
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: <Widget>[
                  IconButton(
                    iconSize: data.size.width / 9,
                    onPressed: (){
                      setState(() {
                        widget.activePage = 0;
                      });
                      widget.pageController.jumpToPage(0);
                    },
                    icon: Icon(Icons.home, color: widget.activePage == 0 ? Color(0xFF00B2FF) :kSecondaryText,),
                  ),
                  IconButton(
                    iconSize: data.size.width / 10,
                    onPressed: (){
                      setState(() {
                        widget.activePage = 1;
                      });
                      widget.pageController.jumpToPage(1);
                    },
                    icon: widget.activePage == 1 ? Image.asset("lib/images/lightbulb 1.png"): Image.asset("lib/images/lightbulb 2.png"),
                  ),
                  IconButton(
                    iconSize: data.size.width / 10,
                    onPressed: (){
                      setState(() {
                        widget.activePage = 2;
                      });
                      widget.pageController.jumpToPage(2);
                    },
                    icon: Icon(Icons.free_breakfast, color: widget.activePage == 2 ? Color(0xFF7000FF) :kSecondaryText,),
                  ),
                  IconButton(
                    iconSize: data.size.width / 10,
                    onPressed: (){
                      setState(() {
                        widget.activePage = 3;
                      });
                      widget.pageController.jumpToPage(3);
                    },
                    icon: Icon(Icons.photo_library, color: widget.activePage == 3 ? Color(0xFF00FFE0) :kSecondaryText,),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        iconSize: data.size.width / 10,
                        onPressed: (){
                          MainBrain().readAllPrivateMessage();
                          Navigator.pushNamed(context, ChatScreen.id);
                        },
                        icon: Icon(Icons.comment, color: widget.activePage == 4 ? kCTA :kSecondaryText,),
                      ),
                      Positioned(
                          top: 5.0, right: 5.0 ,child: Container(width:12.0,height: 12.0, decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), color:Provider.of<MainBrain>(context).newPrivateMessage ? kCTA : Colors.transparent),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
