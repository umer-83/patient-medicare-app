import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/docs_card.dart';
import 'dr_details.dart';

class UnVerifiedDoctor extends StatefulWidget {
  const UnVerifiedDoctor({Key? key}) : super(key: key);

  @override
  State<UnVerifiedDoctor> createState() => _UnVerifiedDoctorState();
}

class _UnVerifiedDoctorState extends State<UnVerifiedDoctor> {
 Stream medsStream = FirebaseFirestore.instance
      .collection('doctor')
      .where("verify", isEqualTo: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 20),
              Expanded(
                child: DocCard(medsStream),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget DocCard(medsStream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: medsStream,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasError) {
        print('Something went Wrong');
      }
      if (snapshot.data == null) {
        print('yo');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot documentSnap = snapshot.data!.docs[index];
          return (DocsCard(
            drName: documentSnap['fullName'].toString(),
            drImage: documentSnap['cover_image'].toString(),
            drSpeclization: documentSnap['profession'].toString(),
            onTab: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ViewDrDetails(documentSnapshot: documentSnap)));
            },
          ));
        },
      );
    },
  );
}
