import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/pages/admin/dr_details.dart';
import '../../widgets/docs_card.dart';

class VerifiedDoctor extends StatefulWidget {
  const VerifiedDoctor({Key? key}) : super(key: key);

  @override
  State<VerifiedDoctor> createState() => _VerifiedDoctorState();
}

class _VerifiedDoctorState extends State<VerifiedDoctor> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('doctor')
      .where("verify", isEqualTo: true)
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
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
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
