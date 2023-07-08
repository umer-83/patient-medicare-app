import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../widgets/text_widget_with_fivelines.dart';
import '../widgets/textfield_card.dart';

class Dosage extends StatefulWidget {
  @override
  _DosageState createState() => _DosageState();
}

class _DosageState extends State<Dosage> {
  bool loading = false;

  final Stream<QuerySnapshot> sizesStream = FirebaseFirestore.instance
      .collection('dosage')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: sizesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            backgroundColor: Color(0xFFE7E5E5),
            appBar: AppBar(
              backgroundColor: Color(0xff3A6351),
              title: Text(
                "Dosage",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,
              elevation: 1,
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ExpandedTileList.builder(
                      itemCount: storedocs.length,
                      itemBuilder: (context, index, controller) {
                        return ExpandedTile(
                          controller: index == 2
                              ? controller.copyWith(isExpanded: true)
                              : controller,
                          leading: Image(
                              image: AssetImage('assets/images/med.png'),
                              width: 50,
                              height: 50),
                          title: Text(
                            storedocs[index]['name'].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          contentSeperator: 10,
                          content: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Detail:",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      storedocs[index]['detail'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time:",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      storedocs[index]['time'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff3A6351),
              onPressed: (() {
                Navigator.pushReplacementNamed(context, '/adosage');
              }),

              //tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
