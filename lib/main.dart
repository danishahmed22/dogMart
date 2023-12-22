import 'package:flutter/material.dart';
import 'screens/cart_screen.dart';
import 'screens/history_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Mart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DogImagePage(),
        '/history': (context) => HistoryPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}