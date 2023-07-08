// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/button_widget.dart';

import '../../widgets/label.dart';
import '../../widgets/view_detail_card.dart';

class AppointReqViewDetailsScreen extends StatefulWidget {
  const AppointReqViewDetailsScreen({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);
  final DocumentSnapshot documentSnapshot;

  @override
  State<AppointReqViewDetailsScreen> createState() =>
      _AppointReqViewDetailsScreenState();
}

class _AppointReqViewDetailsScreenState
    extends State<AppointReqViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var docId = widget.documentSnapshot.reference.id.toString();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff3A6351),
          title: const Text(
            'Appoint Req Details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 4,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/seerequest');
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90.0),
                      child: Image.asset(
                        'assets/images/ptprofile.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "hello dr, here you will find all the details about patient who requested for appointment!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3A6351),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.documentSnapshot['name'],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3A6351),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  ViewDetailCard(
                    title: "Dr Name",
                    subTitle: widget.documentSnapshot['docname'].toString(),
                  ),
                  SizedBox(height: 12),
                  ViewDetailCard(
                    title: "Appointment Type",
                    subTitle: widget.documentSnapshot['place'].toString(),
                  ),
                  SizedBox(height: 12),
                  ViewDetailCard(
                    title: "Appointment Time",
                    subTitle: widget.documentSnapshot['aptime'].toString(),
                  ),
                  SizedBox(height: 12),
                  ViewDetailCard(
                    title: "Appointment Date",
                    subTitle: widget.documentSnapshot['date'].toString(),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Accept Appointment Request",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff3A6351),
                    ),
                  ),
                  SizedBox(height: 8),
                  ButtonWidget(
                      onPress: () {
                        FirebaseFirestore.instance
                            .collection('request')
                            .doc(docId)
                            .update({'status': "Request Accepted"});
                        FirebaseFirestore.instance
                            .collection('request')
                            .doc(docId)
                            .update({'avail': true});
                        Navigator.pushReplacementNamed(context, '/seerequest');
                      },
                      buttonTitle: "Accept Request"),
                  SizedBox(height: 20),
                  Text(
                    "Cancel Appointment Request",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8),
                  ButtonWidget(
                      onPress: () {
                        FirebaseFirestore.instance
                            .collection('request')
                            .doc(docId)
                            .update({'status': "Request Canceled"});
                        FirebaseFirestore.instance
                            .collection('request')
                            .doc(docId)
                            .update({'avail': false});
                        Navigator.pushReplacementNamed(context, '/seerequest');
                      },
                      buttonTitle: "Cancel Request"),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
