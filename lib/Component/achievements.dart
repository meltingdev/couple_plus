import 'package:coupleplus/Component/kcolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Achievement extends StatefulWidget {
  Achievement(
      {
      @required this.ourMoodDay,
      @required this.ourRoomDesire,
      @required this.ourRoomLoveDay,
      @required this.ourRoomChallenge,
        @required this.souvenirs,
      @required this.support});
  final int ourMoodDay;
  final int ourRoomLoveDay;
  final int ourRoomDesire;
  final int ourRoomChallenge;
  final int souvenirs;
  final int support;
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        runSpacing: 15.0,
        spacing: 17.0,
        children: [
          Success(
            message: "Linked with your partner",
            icon: FontAwesomeIcons.arrowsAltH,
            isCompleted: true,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "add a desire",
            icon: FontAwesomeIcons.coffee,
            isCompleted: widget.ourRoomDesire >= 1 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "add 5 desires",
            icon: FontAwesomeIcons.bacon,
            isCompleted: widget.ourRoomDesire >= 5 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "add 10 desires",
            icon: FontAwesomeIcons.beer,
            isCompleted: widget.ourRoomDesire >= 10 ? true : false,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "add 25 desires",
            icon: FontAwesomeIcons.glassMartini,
            isCompleted: widget.ourRoomDesire >= 25 ? true : false,
            color: Color(0xFF52FF00),
          ),
          Success(
            message: "add 50 desires",
            icon: FontAwesomeIcons.glassWhiskey,
            isCompleted: widget.ourRoomDesire >= 50 ? true : false,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "add 100 desires",
            icon: FontAwesomeIcons.glassMartiniAlt,
            isCompleted: widget.ourRoomDesire >= 100 ? true : false,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "add 250 desires",
            icon: FontAwesomeIcons.wineGlass,
            isCompleted: widget.ourRoomDesire >= 250 ? true : false,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "add 500 desires",
            icon: FontAwesomeIcons.glassCheers,
            isCompleted: widget.ourRoomDesire >= 500 ? true : false,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "challenge your partner",
            icon: FontAwesomeIcons.handHoldingUsd,
            isCompleted: widget.ourRoomChallenge >= 1 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "set 5 challenges", // a completer
            icon: FontAwesomeIcons.spider,
            isCompleted: widget.ourRoomChallenge >= 5 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "set 10 challenges", // a completer
            icon: FontAwesomeIcons.frog,
            isCompleted: widget.ourRoomChallenge >= 10 ? true : false,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "set 25 challenges", // a completer
            icon: FontAwesomeIcons.otter,
            isCompleted: widget.ourRoomChallenge >= 25 ? true : false,
            color: Color(0xFF52FF00),
          ),
          Success(
            message: "set 50 challenges", // a completer
            icon: FontAwesomeIcons.cat,
            isCompleted: widget.ourRoomChallenge >= 50 ? true : false,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "set 75 challenges", // a completer
            icon: FontAwesomeIcons.dog,
            isCompleted: widget.ourRoomChallenge >= 75 ? true : false,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "set 100 challenges", // a completer
            icon: FontAwesomeIcons.horse,
            isCompleted: widget.ourRoomChallenge >= 100 ? true : false,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "set 250 challenges", // a completer
            icon: FontAwesomeIcons.hippo,
            isCompleted: widget.ourRoomChallenge >= 250 ? true : false,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "set 500 challenges", // a completer
            icon: FontAwesomeIcons.dragon,
            isCompleted: widget.ourRoomChallenge >= 500 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "set the mood 2 times",
            icon: FontAwesomeIcons.solidDizzy,
            isCompleted: widget.ourMoodDay >= 2 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "set the mood of 10 times",
            icon: FontAwesomeIcons.flushed,
            isCompleted: widget.ourMoodDay >= 10 ? true : false,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "set the mood of 25 times",
            icon: FontAwesomeIcons.frown,
            isCompleted: widget.ourMoodDay >= 25 ? true : false,
            color: Color(0xFF52FF00),
          ),
          Success(
            message: "set the mood of 50 times",
            icon: FontAwesomeIcons.frownOpen,
            isCompleted: widget.ourMoodDay >= 50 ? true : false,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "set the mood of 100 times",
            icon: FontAwesomeIcons.mehBlank,
            isCompleted: widget.ourMoodDay >= 100 ? true : false,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "set the mood of 150 times",
            icon: FontAwesomeIcons.meh,
            isCompleted: widget.ourMoodDay >= 150 ? true : false,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "set the mood of 200 times",
            icon: FontAwesomeIcons.grimace,
            isCompleted: widget.ourMoodDay >= 200 ? true : false,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "set the mood of 300 times",
            icon: FontAwesomeIcons.kiss,
            isCompleted: widget.ourMoodDay >= 300 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "set the mood of 400 times",
            icon: FontAwesomeIcons.kissBeam,
            isCompleted: widget.ourMoodDay >= 400 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "set the mood of 600 times",
            icon: FontAwesomeIcons.grinWink,
            isCompleted: widget.ourMoodDay >= 600 ? true : false,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "set the mood of 800 times",
            icon: FontAwesomeIcons.grinStars,
            isCompleted: widget.ourMoodDay >= 800 ? true : false,
            color: Color(0xFF52FF00),
          ),
          Success(
            message: "set the mood of 1000 times",
            icon: FontAwesomeIcons.grinHearts,
            isCompleted: widget.ourMoodDay >= 1000 ? true : false,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "using the app for 3 day",
            icon: FontAwesomeIcons.clock,
            isCompleted: widget.ourRoomLoveDay >= 3 ? true : false,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "using the app for 1 week",
            icon: FontAwesomeIcons.solidCalendarCheck,
            isCompleted: widget.ourRoomLoveDay >= 7 ? true : false,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "using the app for 2 week",
            icon: FontAwesomeIcons.calendarAlt,
            isCompleted: widget.ourRoomLoveDay >= 14 ? true : false,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "using the app for 1 month",
            icon: FontAwesomeIcons.hourglassStart,
            isCompleted: widget.ourRoomLoveDay >= 30 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "using the app for 3 month",
            icon: FontAwesomeIcons.hourglassHalf,
            isCompleted: widget.ourRoomLoveDay >= 90 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "using the app for 6 month",
            icon: FontAwesomeIcons.hourglassEnd,
            isCompleted: widget.ourRoomLoveDay >= 180 ? true : false,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "using the app for 1 year",
            icon: FontAwesomeIcons.hourglass,
            isCompleted: widget.ourRoomLoveDay >= 360 ? true : false,
            color: Color(0xFF52FF00),
          ),
          Success(
            message: "Upload 1 souvenir",
            icon: FontAwesomeIcons.solidImage,
            isCompleted: widget.souvenirs >= 1 ? true : false,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "Upload 5 souvenir",
            icon: FontAwesomeIcons.solidImages,
            isCompleted: widget.souvenirs >= 5 ? true : false,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "Upload 10 souvenir",
            icon: FontAwesomeIcons.camera,
            isCompleted: widget.souvenirs >= 10 ? true : false,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "Upload 25 souvenir",
            icon: FontAwesomeIcons.city,
            isCompleted: widget.souvenirs >= 25 ? true : false,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "Upload 50 souvenir",
            icon: FontAwesomeIcons.mountain,
            isCompleted: widget.souvenirs >= 50 ? true : false,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "Upload 100 souvenir",
            icon: FontAwesomeIcons.cameraRetro,
            isCompleted: widget.souvenirs >= 100 ? true : false,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "Support the App ! 1 times",
            icon: FontAwesomeIcons.ad, // a completer
            isCompleted: widget.support >= 1,
            color: Color(0xFFFAFF00),
          ),
          Success(
            message: "Support the App ! 2 times",
            icon: FontAwesomeIcons.adversal, // a completer
            isCompleted: widget.support >= 2,
            color: Color(0xFFFF8A00),
          ),
          Success(
            message: "Support the App ! 5 times",
            icon: FontAwesomeIcons.carrot, // a completer
            isCompleted: widget.support >= 5,
            color: Color(0xFFFF0F00),
          ),
          Success(
            message: "Support the App ! 10 times",
            icon: FontAwesomeIcons.coffee, // a completer
            isCompleted: widget.support >= 10,
            color: Color(0xFFFF006C),
          ),
          Success(
            message: "Support the App ! 25 times",
            icon: FontAwesomeIcons.hamburger, // a completer
            isCompleted: widget.support >= 25,
            color: Color(0xFF7000FF),
          ),
          Success(
            message: "Support the App ! 50 times",
            icon: FontAwesomeIcons.hatWizard, // a completer
            isCompleted: widget.support >= 50,
            color: Color(0xFF00B2FF),
          ),
          Success(
            message: "Support the App ! 50 times",
            icon: FontAwesomeIcons.hatCowboy, // a completer
            isCompleted: widget.support >= 50,
            color: Color(0xFF00FFE0),
          ),
          Success(
            message: "Support the App ! 100 times",
            icon: FontAwesomeIcons.crown, // a completer
            isCompleted: widget.support >= 100,
            color: Color(0xFFFAFF00),
          ),
        ],
      ),
    );
  }
}


class Success extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool isCompleted;
  final Color color;

  Success(
      {@required this.icon,
        @required this.color,
        @required this.message,
        @required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Icon(
        icon,
        size: 50.0,
        color: isCompleted == true ? color : kSecondaryText,
      ),
    );
  }
}
