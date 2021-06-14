import 'dart:io';
import 'package:flutter/material.dart';
import 'package:castrin_notify/screens/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override


  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    // Resto:
    _firebaseMessaging.configure(
      // Em 1º plano:
        onMessage: (message) async {
          print('message onMessage: $message aaa');
        },
        // Em 2º plano mas já iniciado:
        onResume: (message) async {
          print('message onResume: $message');
          final data = message['data'];
          final _link = data['view'];

          if(_link != null) {
            launch(_link.toString());
          }
        },
        // Em 2º plano mas não iniciado:
        onLaunch: (message) async {
          print('message onLaunch: $message');
          final data = message['data'];
          final _link = data['view'];

          if(_link != null) {
            launch(_link.toString());
          }
        });

    // Pra iOS
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true
      ),
      );
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        // print("iOS Push Settings: [$settings]");
      });
    }
  }

  Widget build(BuildContext context){
    return MaterialApp(
        title: "Castrin notifica",
        theme: ThemeData(
            fontFamily: 'Metropolis',
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 0, 59, 208),
            secondaryHeaderColor:  Color.fromARGB(255, 38, 38, 38)
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
    );
  }
}
