import 'package:flutter/material.dart';
import 'dart:async';

import '../bottomNavigateScreen/bottomNavigateScreen.dart'; // For using Future.delayed

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      // Navigate to your home screen after 3 seconds
      navigateToNextScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash screen content here (e.g., logo, text)
            Container(
              width: 150,
              height: 200,
              child: FittedBox(
                child: Image.asset('images/th.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20,),
            Text('\nEco-Tech Mud Dome Application',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}