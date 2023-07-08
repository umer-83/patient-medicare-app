// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/profile_item.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE9E6E6),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/more');
            },
          ),
          title: const Text(
            "Profile",
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              var ds = snapshot.data!.docs;
              String usernm = '';
              String emal = '';

              for (int i = 0; i < ds.length; i++) {
                usernm = (ds[i]['username']).toString();
                emal = (ds[i]['email']).toString();
              }
              return Column(
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90.0),
                      child: Image.asset(
                        'assets/images/ptprofile.png',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ProfileItem(
                    cardTitle: usernm,
                    iconData: Icons.person,
                  ),
                  SizedBox(height: 20),
                  ProfileItem(
                    cardTitle: emal,
                    iconData: Icons.email,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
