// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/pages/doctor/doc_approved.dart';
import 'package:pmedic_app/pages/doctor/doc_cancel_req.dart';

import '../../widgets/dr_nav_bar.dart';
import '../../widgets/request_card_widget.dart';

class SeeRequests extends StatefulWidget {
  const SeeRequests({Key? key}) : super(key: key);

  @override
  State<SeeRequests> createState() => _SeeRequestsState();
}

class _SeeRequestsState extends State<SeeRequests> {
  int selectedTab = 0;

  Widget pendingRequest(BuildContext context) {
    return DocCanRequest();
  }

  Widget approvedRequest(BuildContext context) {
    return DocAppRequest();
  }

  late List<Widget> content;

  @override
  void initState() {
    content = [
      pendingRequest(context),
      approvedRequest(context),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onChangeNavigation(int index) {
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/service');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/drmore');
      } else if (index == 0) {
        Navigator.pushReplacementNamed(context, '/drhomescreen');
      }
    }

    return 
    WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        appBar: AppBar(
          title: const Text(
            "See Appointment Requests",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff3A6351),
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/drhomescreen');
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: Image.asset(
                  'assets/images/notifi.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: CupertinoSlidingSegmentedControl<int>(
                        children: {
                          0: Text("Pending Request"),
                          1: Text("Approved Request"),
                        },
                        groupValue: selectedTab,
                        onValueChanged: (value) {
                          setState(
                            () {
                              selectedTab = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: content[selectedTab],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: DoctorNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 2,
        ),
      ),
    );
  }
}
