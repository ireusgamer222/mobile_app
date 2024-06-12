import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:stemcapstoneproject/api/firebaseAPI.dart';
import 'package:stemcapstoneproject/screens/bottomNavigateScreen/bottomNavigateScreen.dart';
import 'package:stemcapstoneproject/screens/ledScreen/ledScreen.dart';
import 'package:stemcapstoneproject/screens/passwordScreen/passwordScreen.dart';
import 'package:stemcapstoneproject/screens/splashScreen/splashScreen.dart';
import 'package:stemcapstoneproject/screens/temperatureAndAirQualityScreen/temperatureAndAirQualityScreen.dart';
import 'api/localNotification.dart';
import 'firebase_options.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await firebaseAPI().initMessage();
  await NotificationService.initializeNotifications();



  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {




    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:SplashScreen() ,
    );
  }
}



























