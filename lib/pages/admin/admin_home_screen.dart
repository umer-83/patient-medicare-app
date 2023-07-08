// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/label.dart';
import '../../widgets/admin_nav_bar.dart';
import '../../widgets/carousal_widget.dart';
import '../../widgets/option_card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  void onChangeNavigation(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/drverify');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/adminmore');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Admin Home',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CarouselSliderWidget(),
                  SizedBox(height: 30),
                  LableWidget(
                    title: "Appointment",
                  ),
                  SizedBox(height: 10),
                  OptionCard(
                    optionTitle: "Verify Requests",
                    optionImage: 'assets/images/appointmentt.png',
                    optionSubTitle: "See appointments!",
                    onTab: () {
                      Navigator.pushReplacementNamed(context, '/drverify');
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 0,
        ),
      ),
    );
  }
}
