import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog CEO API Demo',
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

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>>? history =
    ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: history?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              title: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    history![index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              subtitle: Text('Price: \$${history[index]['price'] ?? 'N/A'}'),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>>? cart =
    ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>?;

    int total = 0;
    cart?.forEach((item) {
      total += item['price'] as int;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              title: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cart![index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              subtitle: Text('Price: \$${cart[index]['price']}'),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
