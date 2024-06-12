import 'package:firebase_messaging/firebase_messaging.dart';

class firebaseAPI{

  FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;

  Future <void> initMessage() async{
      await firebaseMessage.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
      );

      final CMToken = await firebaseMessage.getToken();
      print("$CMToken");
  }

}