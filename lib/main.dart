import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/widget_keys.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    await getCurrentOnboardScreenPresentingValue().then((value) => runApp(MyApp(
          isPresented: value,
        )));
  }, (exception, stackTrace) async {
    log("error occured");
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.isPresented}) : super(key: key);
  final bool isPresented;
  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> getCurrentOnboardScreenPresentingValue() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool(WidgetKeys.isOnboardScreensPresented) ?? false;
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    getCurrentOnboardScreenPresentingValue();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Switch Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: widget.isPresented == true ? const DashboardScreen() : const HomeScreen(),
    );
  }
}
