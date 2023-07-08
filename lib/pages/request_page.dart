// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pmedic_app/pages/doc_request.dart';
import 'package:pmedic_app/pages/patient_request.dart';

import '../widgets/patient_nav_bar.dart';

class PatientAppointmentStatusScreen extends StatefulWidget {
  const PatientAppointmentStatusScreen({Key? key}) : super(key: key);

  @override
  State<PatientAppointmentStatusScreen> createState() =>
      _PatientAppointmentStatusScreenState();
}

class _PatientAppointmentStatusScreenState
    extends State<PatientAppointmentStatusScreen> {
  int selectedTab = 0;

  Widget pendingRequest(BuildContext context) {
    return PatientRequest();
  }

  Widget approvedRequest(BuildContext context) {
    return DocRequest();
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
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/docscreen');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/more');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        appBar: AppBar(
          title: const Text(
            "Appointment Requests",
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
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
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
        bottomNavigationBar: BottomNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 1,
        ),
      ),
    );
  }
}
