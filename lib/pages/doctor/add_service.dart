// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/button_widget.dart';
import 'package:pmedic_app/widgets/textfield_card.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/dr_nav_bar.dart';
import '../../widgets/patient_nav_bar.dart';
import '../../widgets/text_widget_with_fivelines.dart';
import '../../widgets/text_widget_with_fivelines.dart';

class ServiceAddPage extends StatefulWidget {
  final bool initialized;
  final bool error;
  final Function? addNewService;
  const ServiceAddPage({
    Key? key,
    required this.initialized,
    required this.error,
    this.addNewService,
  }) : super(key: key);

  @override
  _ServiceAddPageState createState() => _ServiceAddPageState();
}

class _ServiceAddPageState extends State<ServiceAddPage> {
  bool loading = false;
  File? imageFile;
  List<File> workImageFile = [];
  final picker = ImagePicker();
  List rev = [];

  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController company_name = TextEditingController();
  TextEditingController services = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController quanti = TextEditingController();
  bool avail = false;
  TimeOfDay from =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  TimeOfDay to =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  int tempF = 0, tempT = 0;
  String? dropdownValue;
  String? daytoValue;
  String? dayfromValue;

  Future<void> SelectImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future SelectImageOfWork() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        workImageFile.add(File(pickedImage.path));
      });
    }
  }

  Future check() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('doctor')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          elevation: 1,
          margin: EdgeInsets.fromLTRB(20, 10, 20, 80),
          content: Text(
            "Cant Add more than one Profile.",
            style: TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      OnSave();
    }
  }

  Future OnSave() async {
    var service = services.text;
    var phon = phone.text;
    var company_nam = company_name.text;
    var descripton = description.text;
    var addres = address.text;
    var quant = quanti.text;
    setState(
      () {
        Future.delayed(
          Duration(seconds: 10),
          () {
            Navigator.pushReplacementNamed(context, '/drhomescreen');
          },
        );
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saving in Progress..'),
        duration: Duration(seconds: 20),
      ),
    );

    final cover_image = await saveFileToFireBase(imageFile!);

    List<String> portfolio = [];
    if (workImageFile.length > 0) {
      for (var eachFile in workImageFile) {
        String portfolioImageUrl = await saveFileToFireBase(eachFile);
        portfolio.add(portfolioImageUrl);
      }
    }

    return sizes
        .add({
          'userid': FirebaseAuth.instance.currentUser!.uid,
          'clinicLocation': addres,
          'clinicName': company_nam,
          'cover_image': cover_image.toString(),
          'certification': portfolio.toList(),
          'about': descripton,
          'price': phon,
          'profession': dropdownValue,
          'fullName': service,
          'fromTime': from.hourOfPeriod.toString() + from.period.name,
          'toTime': to.hourOfPeriod.toString() + to.period.name,
          'review': rev,
          'dayto': daytoValue,
          'dayfrom': dayfromValue,
          'verify': false,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  CollectionReference sizes = FirebaseFirestore.instance.collection('doctor');

  Future saveFileToFireBase(File file) async {
    if (file != null) {
      List<String> extensionLists = file.path.split(".");
      String extension = extensionLists.last;
      String fileName = const Uuid().v4();
      try {
        await FirebaseStorage.instance
            .ref('appImages/$fileName.$extension')
            .putFile(File(file.path));

        String fileUrl = await FirebaseStorage.instance
            .ref('appImages/$fileName.$extension')
            .getDownloadURL();

        return fileUrl;
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print("errorsss => $e");
      }
      return 'null';
    }
  }

  void onChangeNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/drhomescreen');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/seerequest');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/drmore');
    }
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
          centerTitle: true,
          backgroundColor: const Color(0xff3A6351),
          title: const Text(
            'Doctor Registeration ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 4,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/drhomescreen');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  if (loading)
                    LinearProgressIndicator(
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff64EBB6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade300.withOpacity(.7),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: IconButton(
                                    onPressed: SelectImageFromGallery,
                                    icon: Icon(Icons.camera_alt,
                                        size: 30.0, color: Color(0xff3A6351)),
                                  ),
                                ),
                                SizedBox(height: 20),
                                imageFile != null
                                    ? Image.file(imageFile!)
                                    : Text(
                                        "Upload Profile Picture",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFieldItem(
                          controller: services,
                          hintText: "Dr Name",
                        ),
                        SizedBox(height: 10),
                        TextFieldItem(
                          controller: company_name,
                          hintText: "Clinic Name",
                        ),
                        SizedBox(height: 10),
                        TextFieldItem(
                          controller: phone,
                          hintText: "Contact Number",
                        ),
                        SizedBox(height: 10),
                        TextFieldItem(
                          controller: address,
                          hintText: "Clinic Address",
                        ),
                        SizedBox(height: 10),
                        TextFieldFiveLines(
                          controller: description,
                          title: "About",
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff3A6351),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Specilization",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 46,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: dropdownValue,
                                      hint: Text(
                                        "Select",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Neurologist',
                                        'Dentist',
                                        'Dermatologist',
                                        'Hermatologist',
                                        'Nephrologist',
                                        'Orthopedic',
                                        'Pulmonologist',
                                        'Cardiologist',
                                        'Gynecologist',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff3A6351),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Days",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(children: [
                                  Container(
                                    height: 46,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: daytoValue,
                                        hint: Text(
                                          "Select",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            daytoValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                          'Saturaday',
                                          'Sunday',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    height: 46,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: dayfromValue,
                                        hint: Text(
                                          "Select",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dayfromValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                          'Saturaday',
                                          'Sunday',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff3A6351),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Availability Times",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: from);
                                          if (newTime == null) return;
                                          setState(() => from = newTime);
                                          tempF = 1;
                                        },
                                        child: PhysicalModel(
                                          elevation: 3,
                                          color: Colors.grey.withOpacity(0.1),
                                          child: Container(
                                              color: Colors.white,
                                              height: 30,
                                              width: 60,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3.0,
                                                        vertical: 1),
                                                child: Center(
                                                    child: FittedBox(
                                                  child: Text(
                                                    tempF == 0
                                                        ? "From"
                                                        : from.hour.toString() +
                                                            " : " +
                                                            from.minute
                                                                .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Futura",
                                                        fontSize: 14),
                                                  ),
                                                )),
                                              )),
                                        )),
                                    Text(
                                      " - ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: to);
                                          if (newTime == null) return;
                                          setState(() => to = newTime);
                                          tempT = 1;
                                        },
                                        child: PhysicalModel(
                                          elevation: 3,
                                          color: Colors.grey.withOpacity(0.1),
                                          child: Container(
                                              color: Colors.white,
                                              height: 30,
                                              width: 60,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3.0,
                                                        vertical: 1),
                                                child: Center(
                                                    child: FittedBox(
                                                  child: Text(
                                                    tempT == 0
                                                        ? "To"
                                                        : to.hour.toString() +
                                                            " : " +
                                                            to.minute
                                                                .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Futura",
                                                        fontSize: 14),
                                                  ),
                                                )),
                                              )),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Degree Doc's",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GridView.count(
                                primary: false,
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  ...List.generate(
                                    workImageFile.length,
                                    (index) => Container(
                                      width: 100,
                                      height: 100,
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.file(
                                        workImageFile[index],
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                        height: 100,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Tooltip(
                                          message: "Add your photos",
                                          child: IconButton(
                                              onPressed: SelectImageOfWork,
                                              icon: Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Color(0xff3A6351),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonWidget(
                          onPress: () {
                            check();
                          },
                          buttonTitle: "Save!",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: DoctorNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 1,
        ),
      ),
    );
  }
}
