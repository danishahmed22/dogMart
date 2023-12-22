import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class DogImagePage extends StatefulWidget {
  @override
  _DogImagePageState createState() => _DogImagePageState();
}

class _DogImagePageState extends State<DogImagePage> {
  String imageUrl = '';
  List<Map<String, dynamic>> history = [];
  List<Map<String, dynamic>> cart = [];

  @override
  void initState() {
    super.initState();
    _fetchDogImage();
  }

  Future<void> _fetchDogImage() async {
    final response =
    await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        imageUrl = responseData['message'];
        history.add({'image': imageUrl}); // Update to store as a map in history
      });
    } else {
      print('Failed to load image: ${response.statusCode}');
    }
  }

  void _addToCart() {
    Random random = Random();
    int price = random.nextInt(451) + 50;

    cart.add({'image': imageUrl, 'price': price});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int price = random.nextInt(451) + 50;

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history', arguments: history);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart', arguments: cart);
            },
          ),
        ],
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              child: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Price: \$${price.toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchDogImage();
        },
        tooltip: 'Fetch',
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _addToCart();
            },
            child: Text('Add to Cart'),
          ),
        ),
      ),
    );
  }
}