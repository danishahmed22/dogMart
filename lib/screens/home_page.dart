// home_page.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  final Function(String, int) onUpdateHistory;

  HomePage({required this.onUpdateHistory});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = '';
  List<Map<String, dynamic>> cartItems = [];
  Random random = Random();

  Future<void> fetchRandomDogImage() async {
    try {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final imageUrl = data['message'];
        setState(() {
          this.imageUrl = imageUrl;
          widget.onUpdateHistory(imageUrl, generateRandomPrice());
        });
      } else {
        // Handle the error gracefully (e.g., show a snackbar or log the error).
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load image'),
          ),
        );
      }
    } catch (error) {
      // Handle other exceptions if necessary.
      print('Error fetching image: $error');
    }
  }

  void addToCart(String imageUrl) {
    final price = generateRandomPrice();
    setState(() {
      cartItems.add({'image': imageUrl, 'price': price});
    });
    widget.onUpdateHistory(imageUrl, price);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image added to cart!'),
      ),
    );
  }

  int generateRandomPrice() {
    return ((random.nextInt(45) + 5) * 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Image'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToCartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl.isEmpty
                ? CircularProgressIndicator()
                : Image.network(
              imageUrl,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addToCart(imageUrl);
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchRandomDogImage,
        tooltip: 'Fetch',
        child: Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Price: \$ ${generateRandomPrice()}',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
