// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/more_card_widget.dart';
import '../../widgets/dr_nav_bar.dart';

class DrMoreScreen extends StatelessWidget {
  const DrMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onChangeNavigation(int index) {
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/service');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/seerequest');
      } else if (index == 0) {
        Navigator.pushReplacementNamed(context, '/drhomescreen');
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
            "More",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff3A6351),
          elevation: 1,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              MoreCardWidget(
                title: "Profile",
                iconData: Icons.person,
                onTab: () {
                  Navigator.pushReplacementNamed(context, '/drprofilescreen');
                },
              ),
              SizedBox(height: 10),
              MoreCardWidget(
                title: "Logout",
                iconData: Icons.lock,
                onTab: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: DoctorNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 3,
        ),
      ),
    );
  }
}
