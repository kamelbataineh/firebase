import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class Masseging {

 FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;


 Future<void> handler(RemoteMessage msg)async{
   print(msg.data);
 }
 /////////////
 Future<void> init()async{
   _firebaseMessaging.requestPermission();
   String? token =await _firebaseMessaging.getToken();
   print("token massge : \t ${token}");
 FirebaseMessaging.onBackgroundMessage(handler);
 }
}

