// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/doc_card_widget.dart';
import '../widgets/patient_nav_bar.dart';

class DocScreen extends StatefulWidget {
  const DocScreen({Key? key}) : super(key: key);
  @override
  State<DocScreen> createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('doctor')
      .where('verify', isEqualTo: true)
      .snapshots();

  void onChangeNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/appointmentrequest');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        appBar: AppBar(
          title: const Text(
            "Find Doctors",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff3A6351),
          elevation: 1,
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                 Center(
                child: Text(
                  "Hello, Are you searching specialist doctor? Simply write Dr name in search bar or scroll the screen here!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3A6351),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            String searchKey = value;
                            medsStream = FirebaseFirestore.instance
                                .collection('doctor')
                                .where('fullName',
                                    isGreaterThanOrEqualTo: searchKey)
                                .where('fullName', isLessThan: searchKey + 'z')
                                .snapshots();
                          });
                        },
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          hintText: 'Search for Doctor',
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  const BorderSide(color: Colors.blue, width: 2)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: DocCard(medsStream),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 2,
        ),
      ),
    );
  }
}
