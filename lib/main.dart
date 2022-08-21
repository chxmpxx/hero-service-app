import 'package:flutter/material.dart';
import 'package:hero_service_app/routers.dart';
import 'package:hero_service_app/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

var appStep;
var initURL = '/welcome';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  appStep = sharedPreferences.getInt('appStep');

  if(appStep == 1) {
    initURL = '/login';
  }
  else if(appStep == 2) {
    initURL = '/dashboard';
  }
  else if(appStep == 3) {
    initURL = '/lock';
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL, 
      routes: routes,
    );
  }
}