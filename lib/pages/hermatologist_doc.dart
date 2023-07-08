// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/doc_card_widget.dart';

class HermatologistDoc extends StatefulWidget {
  const HermatologistDoc({Key? key}) : super(key: key);

  @override
  State<HermatologistDoc> createState() => _HermatologistDocState();
}

class _HermatologistDocState extends State<HermatologistDoc> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('doctor')
      .where("profession", isEqualTo: 'Hermatologist')
      .snapshots();
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
            "Neurologgist",
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(height: 30),
              Expanded(
                child: DocCard(medsStream),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
