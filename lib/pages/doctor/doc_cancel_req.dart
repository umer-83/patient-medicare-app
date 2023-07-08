import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/request_card_widget.dart';


class DocCanRequest extends StatefulWidget {
  const DocCanRequest({Key? key}) : super(key: key);

  @override
  State<DocCanRequest> createState() => _DocCanRequestState();
}

class _DocCanRequestState extends State<DocCanRequest> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('request')
      .where("docid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("avail", isEqualTo: false)
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
                child: reqCard(medsStream),
                // child: availableMedicine(medsStream),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
