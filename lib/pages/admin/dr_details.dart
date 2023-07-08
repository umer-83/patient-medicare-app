// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/view_detail_card.dart';

import '../../widgets/button_widget.dart';

class ViewDrDetails extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const ViewDrDetails({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _ViewDrDetailsState createState() => _ViewDrDetailsState();
}

class _ViewDrDetailsState extends State<ViewDrDetails> {
  @override
  Widget build(BuildContext context) {
    String docIdd = widget.documentSnapshot['userid'].toString();
    String docName = widget.documentSnapshot['fullName'];
    var docId = widget.documentSnapshot.reference.id.toString();
    TextEditingController review = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 4, right: 4),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 4.0), //(x,y)
                            blurRadius: 10.0,
                          ),
                        ]),
                    width: double.maxFinite,
                    height: 350,
                    child: Stack(
                      children: [
                        Image.network(widget.documentSnapshot['cover_image'],
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            height: 350),
                        Row(
                          children: [
                            IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                ))
                          ],
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(widget.documentSnapshot['fullName'],
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3A6351),
                              )),
                        ),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Specialization",
                        subTitle: widget.documentSnapshot['profession'],
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "About",
                        subTitle: widget.documentSnapshot['about'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Clinic Name",
                        subTitle:
                            widget.documentSnapshot['clinicName'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Time From",
                        subTitle:
                            widget.documentSnapshot['fromTime'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Time To",
                        subTitle: widget.documentSnapshot['toTime'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Day From",
                        subTitle: widget.documentSnapshot['dayto'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Day To",
                        subTitle: widget.documentSnapshot['dayfrom'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Contact No.",
                        subTitle: widget.documentSnapshot['price'].toString(),
                      ),
                      SizedBox(height: 12),
                      ViewDetailCard(
                        title: "Clinic Address",
                        subTitle: widget.documentSnapshot['clinicLocation']
                            .toString(),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Certification Pictures",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(
                          widget.documentSnapshot['certification'].length,
                          (index) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              widget.documentSnapshot['certification'][index]
                                  .toString(),
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ButtonWidget(
                        onPress: () {
                          FirebaseFirestore.instance
                              .collection('doctor')
                              .doc(docId)
                              .update({'verify': true});
                          Navigator.pop(context);
                        },
                        buttonTitle: "Verify",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
