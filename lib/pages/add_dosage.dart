import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/button_widget.dart';

import '../widgets/text_widget_with_fivelines.dart';
import '../widgets/textfield_card.dart';

class AddDosage extends StatefulWidget {
  const AddDosage({Key? key}) : super(key: key);

  @override
  State<AddDosage> createState() => _AddDosageState();
}

class _AddDosageState extends State<AddDosage> {
  bool loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController detail = TextEditingController();
  TimeOfDay now =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  final Stream<QuerySnapshot> sizesStream = FirebaseFirestore.instance
      .collection('dosage')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  CollectionReference sizes = FirebaseFirestore.instance.collection('dosage');

  Future<void> addUser() {
    return sizes
        .add({
          'name': name.text,
          'detail': detail.text,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          "time": now.hourOfPeriod.toString() +
              ":" +
              now.minute.toString() +
              now.period.name,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E5E5),
      appBar: AppBar(
        title: const Text(
          "ADD Dosage",
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
            Navigator.pushReplacementNamed(context, '/dosage');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90.0),
                  child: Image.asset(
                    'assets/images/med.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(children: [
                  TextFieldItem(controller: name, hintText: 'Name'),
                  SizedBox(height: 10),
                  TextFieldFiveLines(title: 'Details', controller: detail),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: now);
                      if (newTime == null) return;
                      setState(() => now = newTime);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time ( ${now.hourOfPeriod.toString() + ":" + now.minute.toString() + now.period.name} )',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ButtonWidget(
                      onPress: () {
                        addUser();
                        Navigator.pushReplacementNamed(context, '/dosage');
                      },
                      buttonTitle: 'Save')
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// addUser();
//                       Navigator.pushReplacementNamed(context, '/dosage');