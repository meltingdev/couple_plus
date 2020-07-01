import 'package:coupleplus/Component/BottomSheet.dart';
import 'package:coupleplus/Component/Button.dart';
import 'package:coupleplus/Component/Element.dart';
import 'package:coupleplus/Component/kcolor.dart';
import 'package:coupleplus/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:coupleplus/Brain/MainBrain.dart';

final Firestore _fs = Firestore.instance;

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool serviceButtonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs
            .collection("Rooms")
            .document("room $roomReference")
            .collection("Services")
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
          return ListView.builder(
              itemCount: servicesList.length + 2,
              itemBuilder: (BuildContext context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CoupleButton(
                      buttonIsPressed: serviceButtonIsPressed,
                      buttonText: "Add a new Service",
                      color: Color(0xFF7000FF),
                      backColor: Color(0xFF350079),
                      function: ()async {
                        Provider.of<MainBrain>(context, listen: false).getAvailablePrice();
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
                      }
                    ),
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 3.0,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16.0),
                  child: ServiceElement(sender: servicesList[index - 2].sender, date: servicesList[index - 2].date, serviceText: servicesList[index - 2].serviceText, serviceReference: servicesList[index - 2].serviceReference, price: servicesList[index - 2].price),
                );
              });
        },
      ),
    );
  }
}

class Service {
  Service(
      {@required this.serviceText,
      @required this.date,
      @required this.sender,
      @required this.price,
      @required this.serviceReference});
  String sender;
  String date;
  String serviceText;
  String serviceReference;
  double price;
}
