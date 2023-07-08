import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/pages/doctor/appointmnet_requests_viewdetails.dart';
import 'package:pmedic_app/widgets/patient_req_card.dart';

import 'package:pmedic_app/widgets/request_card.dart';

Widget preqCard(medsStream) {
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

          return (PrequestCard(
            patientName: '${documentSnap['name'].toString()}',
            status: documentSnap['status'].toString(),
            appointmentType: '${documentSnap['place'].toString()}',
            drName: '${documentSnap['docname'].toString()}',
            time: '${documentSnap['aptime'].toString()}', 
            date: documentSnap['date'].toString(),
          ));
        },
      );
    },
  );
}
