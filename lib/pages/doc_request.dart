import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/doc_card_widget.dart';
import '../widgets/patient_req_card_widget.dart';
import '../widgets/request_card_widget.dart';

class DocRequest extends StatefulWidget {
  const DocRequest({Key? key}) : super(key: key);

  @override
  State<DocRequest> createState() => _DocRequestState();
}

class _DocRequestState extends State<DocRequest> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('request')
      .where("pid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("avail", isEqualTo: true)
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Text(
                    'Requests!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: preqCard(medsStream),
                // child: availableMedicine(medsStream),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
