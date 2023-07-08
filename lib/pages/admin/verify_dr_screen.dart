// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/pages/admin/unverified_doctor.dart';
import 'package:pmedic_app/pages/admin/verified_doctor.dart';
import '../../widgets/admin_nav_bar.dart';

class VerifyDrScreen extends StatefulWidget {
  const VerifyDrScreen({Key? key}) : super(key: key);

  @override
  State<VerifyDrScreen> createState() => _VerifyDrScreenState();
}

class _VerifyDrScreenState extends State<VerifyDrScreen> {
  int selectedTab = 0;

  Widget unverifiedDoctor(BuildContext context) {
    return UnVerifiedDoctor();
  }

  Widget verifiedDoctor(BuildContext context) {
    return VerifiedDoctor();
  }

  late List<Widget> content;

  @override
  void initState() {
    content = [
      unverifiedDoctor(context),
      verifiedDoctor(context),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onChangeNavigation(int index) {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/adminhomescreen');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/adminmore');
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
            "See Dr's Profile",
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
              Navigator.pushReplacementNamed(context, '/adminhomescreen');
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
                          0: Text("Unverified Dr's"),
                          1: Text("Verified Dr's"),
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
        bottomNavigationBar: AdminNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 1,
        ),
      ),
    );
  }
}
