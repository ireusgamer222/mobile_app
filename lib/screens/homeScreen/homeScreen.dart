import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ledScreen/ledScreen.dart';
import '../passwordScreen/passwordScreen.dart';
import '../temperatureAndAirQualityScreen/temperatureAndAirQualityScreen.dart';

Widget homeScreen(context){
  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PasswordEntryScreen()));
  }


  void navigateToNextScreen2(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LedScreen()));
  }

  void navigateToNextScreen3(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailsScreen()));
  }

  return Center( child: //tempANDair(currentTempValue,currentAirQualityValue,currentHumidityValue),
  Padding(padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
    child:Column(

      children: [
        const SizedBox(height: 200,),
        Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.green, spreadRadius: 3)
            ],
            color: Colors.black,
            border: Border.all(color: Colors.blueAccent)
        ),
        child:  Center(child:TextButton(onPressed: (){navigateToNextScreen(context);},child : const Text("Password Entry",style: TextStyle(color: Colors.white),))) ,


      ),
      const SizedBox(height: 40,),
    Container(
      width: 250,
      height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.green, spreadRadius: 3)
          ],
          color: Colors.black,
          border: Border.all(color: Colors.blueAccent,)
      ),
      child:  Center(child:TextButton(onPressed: (){navigateToNextScreen2(context);},child : const Text("LED Switch",style: TextStyle(color: Colors.white),))) ,
    ),
        const SizedBox(height: 40,),
        Container(
          width: 250,
          height: 50,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.green, spreadRadius: 3)
              ],
              color: Colors.black,
              border: Border.all(color: Colors.blueAccent,)
          ),
          child:  Center(child:TextButton(onPressed: (){navigateToNextScreen3(context);},child : const Text("Montiroing Screen",style: TextStyle(color: Colors.white),))) ,
        ),


      ],
    ),
  ),);
}