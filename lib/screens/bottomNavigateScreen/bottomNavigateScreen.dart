import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../api/localNotification.dart';
import '../detailScreen/detailScreen.dart';
import '../homeScreen/homeScreen.dart';
import '../ledScreen/ledScreen.dart';
import '../passwordScreen/passwordScreen.dart';
import '../temperatureAndAirQualityScreen/temperatureAndAirQualityScreen.dart';



class BottomNavigatorScreen extends StatefulWidget {
  @override
  _BottomNavigatorScreen createState() => _BottomNavigatorScreen();
}

class _BottomNavigatorScreen extends State<BottomNavigatorScreen> {

  int _selectedIndex = 0;
  double currentTempValue = 0;
  double currentAirQualityValue = 0;
  double currentHumidityValue = 0;


  late DatabaseReference _tempRef;
  late DatabaseReference _airQualityRef;
  late DatabaseReference _humidityRef;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();
    _tempRef = FirebaseDatabase.instance.ref('esp32/temperature');
    tempReader();
    _airQualityRef = FirebaseDatabase.instance.ref('esp32/airquality');
    airQualityReader();
    _humidityRef = FirebaseDatabase.instance.ref('esp32/humidity');
    humidityReader();
  }







  @override
  Widget build(BuildContext context) {
    List Screens = [homeScreen(context), DetailDisplay(currentTempValue,currentHumidityValue,currentAirQualityValue)];

    return Scaffold(

      appBar: AppBar(
        title: const Text('Smart home application'),
      ),

      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.red],
            ),
          ),


          child: Screens[_selectedIndex],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Details',
          ),

        ],
      ),

    );
  }

  void tempReader(){
    _tempRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentTempValue = result;
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing");
      }
    });
  }

  void airQualityReader(){
    _airQualityRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentAirQualityValue = result;
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing");
      }
    });
  }

  void humidityReader(){
    _humidityRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentHumidityValue = result;
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing ");
      }
    });
  }




}


