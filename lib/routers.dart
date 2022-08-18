import 'package:flutter/material.dart';
import 'package:hero_service_app/screens/dashboard/dashboard_screen.dart';
import 'package:hero_service_app/screens/welcome/welcome_screen.dart';

// สร้างตัวแปร Map ไว้เก็บ URL และ Screen
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen()
};