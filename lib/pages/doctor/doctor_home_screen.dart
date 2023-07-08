// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/label.dart';
import '../../widgets/carousal_widget.dart';
import '../../widgets/dr_nav_bar.dart';
import '../../widgets/patient_nav_bar.dart';
import '../../widgets/option_card.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  void onChangeNavigation(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/service');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/seerequest');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/drmore');
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
                    'Doctor Home',
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
                    optionTitle: "See Requests",
                    optionImage: 'assets/images/appointmentt.png',
                    optionSubTitle: "See appointments!",
                    onTab: () {
                      Navigator.pushReplacementNamed(
                          context, '/seerequest');
                    },
                  ),
                  SizedBox(height: 20),
                  LableWidget(
                    title: "Profile",
                  ),
                  SizedBox(height: 10),
                  OptionCard(
                    optionTitle: "Launch Profile",
                    optionImage: 'assets/images/drprofile.png',
                    optionSubTitle: "Create Dr profile!",
                    onTab: () {
                      Navigator.pushReplacementNamed(context, '/service');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: DoctorNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 0,
        ),
      ),
    );
  }
}
