// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/pages/home_screen.dart';
import 'package:pmedic_app/widgets/button_widget.dart';
import 'package:pmedic_app/widgets/single_heading_container.dart';
import 'package:pmedic_app/widgets/text_widget_with_fivelines.dart';

import '../widgets/textfield_card.dart';

class DocAppointment extends StatefulWidget {
  String docIdd;
  String docName;
  DocAppointment({Key? key, required this.docIdd, required this.docName})
      : super(key: key);

  @override
  State<DocAppointment> createState() => _DocAppointmentState();
}

class _DocAppointmentState extends State<DocAppointment> {
  var width, height;
  bool isSelected = false;
  int purpose = 0, appointment = 0, day = 0, time = 0;
  String appoinTime = '09:00 am';
  TextEditingController patientName = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController pdetails = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

// func with named parameter
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Color c1 = Color(0xff3A6351);
  Color c2 = Color(0xff3A6351);
  Color c3 = Color(0xff3A6351);
  Color c4 = Color(0xff3A6351);
  Color c5 = Color(0xff3A6351);
  Color c6 = Color(0xff3A6351);
  Color c7 = Color(0xff3A6351);
  Color c8 = Color(0xff3A6351);
  Color c9 = Color(0xff3A6351);
  Color c10 = Color(0xff3A6351);
  Color c11 = Color(0xff3A6351);
  Color c12 = Color(0xff3A6351);
  Color c13 = Color(0xff3A6351);
  Color c14 = Color(0xff3A6351);
  Color cw1 = Colors.white;
  Color cw2 = Colors.white;
  Color cw3 = Colors.white;
  Color cw4 = Colors.white;
  Color cw5 = Colors.white;
  Color cw6 = Colors.white;
  Color cw7 = Colors.white;
  Color cw8 = Colors.white;
  Color cw9 = Colors.white;
  Color cw10 = Colors.white;
  Color cw11 = Colors.white;
  Color cw12 = Colors.white;
  Color cw13 = Colors.white;
  Color cw14 = Colors.white;

  String aTime1 = '09:00 am';
  String aTime2 = '10:00 am';
  String aTime3 = '11:00 am';
  String aTime4 = '12:00 am';
  String aTime5 = '01:00 pm';
  String aTime6 = '02:00 pm';
  String aTime7 = '03:00 pm';
  String aTime8 = '04:00 pm';
  String aTime9 = '05:00 pm';
  String aTime10 = '06:00 pm';
  String aTime11 = '07:00 pm';
  String aTime12 = '08:00 pm';
  String aTime13 = '09:00 pm';
  String aTime14 = '10:00 pm';

  DateTime dateTime = DateTime.now();
  String place = 'Home Visit';
  bool avail = false;
  User? user = FirebaseAuth.instance.currentUser;
  TimeOfDay now =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  CollectionReference request =
      FirebaseFirestore.instance.collection('request');

  Future<void> addReq() {
    return request
        .add({
          'name': patientName.text,
          'contact': contactNo.text,
          'pid': FirebaseAuth.instance.currentUser!.uid,
          'aptime': appoinTime,
          'docid': widget.docIdd,
          'place': place,
          'date': dateTime.day.toString() +
              '/' +
              dateTime.month.toString() +
              '/' +
              dateTime.year.toString(),
          "time": now.hourOfPeriod.toString() +
              ":" +
              now.minute.toString() +
              now.period.name,
          'docname': widget.docName,
          'avail': avail,
          'detail': pdetails.text,
          'status': 'Pending Request',
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE7E5E5),
        appBar: AppBar(
            title: const Text(
              "Book Appointment",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xff3A6351),
            elevation: 1,
            centerTitle: true,
            leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                ))),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: patientName,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Patient Name",
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            errors.contains('patientNameError')) {
                          removeError(error: 'patientNameError');
                        }

                        return null;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: 'patientNameError');
                          removeError(error: 'patientNameError');
                          return 'Patient Name is required!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: pdetails,
                      style: TextStyle(fontSize: 16),
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Patient Details",
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            errors.contains('patientDetailsError')) {
                          removeError(error: 'patientDetailsError');
                        }

                        return null;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: 'patientDetailsError');
                          removeError(error: 'patientDetailsError');
                          return 'Patient Details is required!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: contactNo,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Contact No",
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            errors.contains('contactError')) {
                          removeError(error: 'contactError');
                        }

                        return null;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: 'contactErrorError');
                          removeError(error: 'contactErrorError');
                          return 'Contact No is required!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleHeading(title: "Appointment Type"),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PhysicalModel(
                        elevation: 3,
                        color: Color(0xff3A6351),
                        borderRadius: BorderRadius.circular(18.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              appointment = 0;
                              place = 'Home Visit';
                            });
                          },
                          child: Container(
                            width: height * 0.14,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: appointment != 0 ? Colors.white : null,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Icon(
                                  Icons.home,
                                  color: appointment != 0
                                      ? Colors.black
                                      : Colors.white,
                                  size: width * 0.06,
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  'Home Visit',
                                  style: TextStyle(
                                      color: appointment != 0
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      PhysicalModel(
                        elevation: 3,
                        color: Color(0xff3A6351),
                        borderRadius: BorderRadius.circular(18.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              appointment = 1;
                              place = 'Clinic';
                            });
                          },
                          child: Container(
                            width: height * 0.14,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: appointment != 1 ? Colors.white : null,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Icon(
                                  Icons.add_circle_outline,
                                  color: appointment != 1
                                      ? Color(0xff3A6351)
                                      : Colors.white,
                                  size: width * 0.06,
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  'Clinic',
                                  style: TextStyle(
                                      color: appointment != 1
                                          ? Color(0xff3A6351)
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SingleHeading(title: "Availabilty"),
                  SizedBox(height: 10),
                  InkWell(
                      onTap: () async {
                        var selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null && selected != dateTime)
                          setState(() {
                            dateTime = selected;
                          });
                        setState(() {
                          c1 = Color(0xff3A6351);
                          c2 = Color(0xff3A6351);
                          c3 = Color(0xff3A6351);
                          c4 = Color(0xff3A6351);
                          c5 = Color(0xff3A6351);
                          c6 = Color(0xff3A6351);
                          c7 = Color(0xff3A6351);
                          c8 = Color(0xff3A6351);
                          c9 = Color(0xff3A6351);
                          c10 = Color(0xff3A6351);
                          c11 = Color(0xff3A6351);
                          c12 = Color(0xff3A6351);
                          c13 = Color(0xff3A6351);
                          c14 = Color(0xff3A6351);
                          cw1 = Colors.white;
                          cw2 = Colors.white;
                          cw3 = Colors.white;
                          cw4 = Colors.white;
                          cw5 = Colors.white;
                          cw6 = Colors.white;
                          cw7 = Colors.white;
                          cw8 = Colors.white;
                          cw9 = Colors.white;
                          cw10 = Colors.white;
                          cw11 = Colors.white;
                          cw12 = Colors.white;
                          cw13 = Colors.white;
                          cw14 = Colors.white;
                        });
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
                                'Date ( ${dateTime.day.toString() + '/' + dateTime.month.toString() + '/' + dateTime.year.toString()} )',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
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
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('request')
                          .where('docid', isEqualTo: widget.docIdd)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        var ds = snapshot.data!.docs;
                        var datee = dateTime.day.toString() +
                            '/' +
                            dateTime.month.toString() +
                            '/' +
                            dateTime.year.toString();

                        for (int i = 0; i < ds.length; i++) {
                          if (ds[i]['aptime'] == aTime1 &&
                              ds[i]['date'] == datee) {
                            c1 = Colors.red;
                            cw1 = Colors.red;
                          }
                          // else {
                          //   c1 = Color(0xff3A6351);
                          //   cw1 = Colors.white;
                          // }
                          if (ds[i]['aptime'] == aTime2 &&
                              ds[i]['date'] == datee) {
                            c2 = Colors.red;
                            cw2 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime3 &&
                              ds[i]['date'] == datee) {
                            c3 = Colors.red;
                            cw3 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime4 &&
                              ds[i]['date'] == datee) {
                            c4 = Colors.red;
                            cw4 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime5 &&
                              ds[i]['date'] == datee) {
                            c5 = Colors.red;
                            cw5 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime6 &&
                              ds[i]['date'] == datee) {
                            c6 = Colors.red;
                            cw6 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime7 &&
                              ds[i]['date'] == datee) {
                            c7 = Colors.red;
                            cw7 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime8 &&
                              ds[i]['date'] == datee) {
                            c8 = Colors.red;
                            cw8 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime9 &&
                              ds[i]['date'] == datee) {
                            c9 = Colors.red;
                            cw9 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime10 &&
                              ds[i]['date'] == datee) {
                            c10 = Colors.red;
                            cw10 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime11 &&
                              ds[i]['date'] == datee) {
                            c11 = Colors.red;
                            cw11 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime12 &&
                              ds[i]['date'] == datee) {
                            c12 = Colors.red;
                            cw12 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime13 &&
                              ds[i]['date'] == datee) {
                            c13 = Colors.red;
                            cw13 = Colors.red;
                          }
                          if (ds[i]['aptime'] == aTime14 &&
                              ds[i]['date'] == datee) {
                            c14 = Colors.red;
                            cw14 = Colors.red;
                          }
                        }
                        return SizedBox(
                          height: 0,
                        );
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(height: height * 0.02),
                  Wrap(
                    spacing: 5,
                    runSpacing: 10,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 0;
                            appoinTime = aTime1;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c1,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 0 ? cw1 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime1,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 0 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 1;
                            appoinTime = aTime2;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c2,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 1 ? cw2 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime2,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 1 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 2;
                            appoinTime = aTime3;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c3,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 2 ? cw3 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime3,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 2 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 3;
                            appoinTime = aTime4;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c4,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 3 ? cw4 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime4,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 3 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 4;
                            appoinTime = aTime5;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c5,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 4 ? cw5 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime5,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 4 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 5;
                            appoinTime = aTime6;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c6,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 5 ? cw6 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime6,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 5 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 6;
                            appoinTime = aTime7;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c7,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 6 ? cw7 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime7,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 6 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 7;
                            appoinTime = aTime8;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c8,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 7 ? cw8 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime8,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 7 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 8;
                            appoinTime = aTime9;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c9,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 8 ? cw9 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime9,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 8 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 9;
                            appoinTime = aTime10;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c10,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 9 ? cw10 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime10,
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        time != 9 ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 10;
                            appoinTime = aTime11;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c11,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 10 ? cw11 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime11,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: time != 10
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 11;
                            appoinTime = aTime12;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c12,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 11 ? cw12 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime12,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: time != 11
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 12;
                            appoinTime = aTime13;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c13,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 12 ? cw13 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime13,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: time != 12
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            time = 13;
                            appoinTime = aTime14;
                          });
                        },
                        child: PhysicalModel(
                          elevation: 3,
                          color: c14,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: time != 13 ? cw14 : null,
                            ),
                            child: Center(
                              child: Text(
                                aTime14,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: time != 13
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ButtonWidget(
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()));
                        addReq();
                      }
                    },
                    buttonTitle: "Appointment Booked!",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayText(String text, double size, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(fontWeight: weight, fontSize: size),
    );
  }

  Future writeData() async {
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }
  }
}
