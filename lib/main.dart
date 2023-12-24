import 'package:flutter/material.dart';
import 'screens/cart_screen.dart';
import 'screens/history_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> historyData = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dog Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
          onUpdateHistory: (image, price) {
            setState(() {
              historyData.add({'image': image, 'price': price});
            });
          },
        ),
        '/history': (context) => HistoryPage(historyData: historyData),
        '/add_to_cart': (context) => AddToCartPage(cartItems: []),
      },
    );
  }
}
