// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pmedic_app/widgets/label.dart';
import '../widgets/carousal_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/patient_nav_bar.dart';
import '../widgets/option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onChangeNavigation(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/appointmentrequest');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/docscreen');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/more');
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Patient Home',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CarouselSliderWidget(),
                  SizedBox(height: 25),
                  LableWidget(
                    title: "Categories",
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 8);
                      },
                      shrinkWrap: true,
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            CategoriesWidget(
                              categoryTitle: "Neurologist",
                              categoryImage: 'assets/images/c1.png',
                              onTab: () {
                                Navigator.pushReplacementNamed(
                                    context, '/neurologist');
                              },
                            ),
                            SizedBox(width: 8),
                            CategoriesWidget(
                              categoryTitle: "Cardiologist",
                              categoryImage: 'assets/images/c4.png',
                              onTab: () {
                                Navigator.pushReplacementNamed(
                                    context, '/cardiologist');
                              },
                            ),
                            SizedBox(width: 8),
                            CategoriesWidget(
                              categoryTitle: "Orthopedic",
                              categoryImage: 'assets/images/c3.png',
                              onTab: () {
                                Navigator.pushReplacementNamed(
                                    context, '/orthopedic');
                              },
                            ),
                            SizedBox(width: 8),
                            CategoriesWidget(
                              categoryTitle: "Dermatologist",
                              categoryImage: 'assets/images/c2.png',
                              onTab: () {
                                Navigator.pushReplacementNamed(
                                    context, '/dermatologist');
                              },
                            ),
                            SizedBox(width: 8),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  LableWidget(
                    title: "Appointment",
                  ),
                  SizedBox(height: 10),
                  OptionCard(
                    optionTitle: "Requests",
                    optionImage: 'assets/images/appointmentt.png',
                    optionSubTitle: "See appoint requests!",
                    onTab: () {
                      Navigator.pushReplacementNamed(
                          context, '/appointmentrequest');
                    },
                  ),
                  SizedBox(height: 20),
                  OptionCard(
                    optionTitle: "Add Dosage",
                    optionImage: 'assets/images/med.png',
                    optionSubTitle: "See Dosage Time!",
                    onTab: () {
                      Navigator.pushReplacementNamed(context, '/dosage');
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          onChange: onChangeNavigation,
          cIndex: 0,
        ),
      ),
    );
  }
}
