import 'package:flutter/material.dart';
import 'views/home_screen.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ziauddin Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF006c2c), // Primary color
        scaffoldBackgroundColor: Colors.white, // Background color
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF006c2c), // App bar color
          titleTextStyle: TextStyle(
            color: Colors.white, // White text for app bar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Default text color
          bodyMedium: TextStyle(color: Colors.black), // Default text color
        ),
      ),
      home: HomeScreen(),
    );
  }
}