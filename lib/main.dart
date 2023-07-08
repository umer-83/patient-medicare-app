// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pmedic_app/pages/add_dosage.dart';
import 'package:pmedic_app/pages/admin/admin_home_screen.dart';
import 'package:pmedic_app/pages/admin/admin_more.dart';
import 'package:pmedic_app/pages/doctor/add_service.dart';
import 'package:pmedic_app/pages/doctor/appointmnet_requests_viewdetails.dart';
import 'package:pmedic_app/pages/cardiologist_doc.dart';
import 'package:pmedic_app/pages/dentist_doc.dart';
import 'package:pmedic_app/pages/dermatologist_doc.dart';
import 'package:pmedic_app/pages/doctor/doctor_home_screen.dart';
import 'package:pmedic_app/pages/doctor/dr_profile_screen.dart';
import 'package:pmedic_app/pages/doctor_screen.dart';
import 'package:pmedic_app/pages/dosage.dart';
import 'package:pmedic_app/pages/gynecologist_doc.dart';
import 'package:pmedic_app/pages/hermatologist_doc.dart';
import 'package:pmedic_app/pages/more_screen.dart';
import 'package:pmedic_app/pages/nephrologist_doc.dart';
import 'package:pmedic_app/pages/neurologist_doc.dart';
import 'package:pmedic_app/pages/orthopedic_doc.dart';
import 'package:pmedic_app/pages/patient_profile_screen.dart';
import 'package:pmedic_app/pages/request_page.dart';
import 'package:pmedic_app/pages/doctor/see_requests.dart';
import 'pages/admin/verify_dr_screen.dart';
import 'pages/doctor/doctor_home_screen.dart';
import 'pages/doctor/dr_more_screen.dart';
import 'pages/home_screen.dart';
import 'pages/login_screen.dart';
import 'pages/reset_screen.dart';
import 'pages/splash_screen.dart';
import 'pages/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();

    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      //Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset': (context) => const ResetScreen(),
        '/docscreen': (context) => DocScreen(),
        '/more': (context) => MoreScreen(),
        '/drprofilescreen': (context) => DrProfileScreen(),
        '/patientprofilescreen': (context) => PatientProfileScreen(),
        '/drmore': (context) => DrMoreScreen(),
        '/adminmore': (context) => AdminMoreScreen(),
        '/adminhomescreen': (context) => AdminHomeScreen(),
        '/drverify': (context) => VerifyDrScreen(),
        '/cardiologist': (context) => CardiologistDoc(),
        '/dentist': (context) => DentistDoc(),
        '/dermatologist': (context) => DermatologistDoc(),
        '/gynecologist': (context) => GynecologistDoc(),
        '/hermatologist': (context) => HermatologistDoc(),
        '/nephrologist': (context) => NephrologistDoc(),
        '/neurologist': (context) => NeuroDoc(),
        '/orthopedic': (context) => OrthopedicDoc(),
        '/seerequest': (context) => SeeRequests(),
        '/drhomescreen': (context) => DoctorHomeScreen(),
        '/dosage': (context) => Dosage(),
        '/adosage': (context) => AddDosage(),
        '/appointmentrequest': (context) => PatientAppointmentStatusScreen(),
        '/service': (context) => ServiceAddPage(
              initialized: _initialized,
              error: _error,
            ),
      },
    );
  }
}
