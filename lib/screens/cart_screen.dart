import 'package:flutter/material.dart';

class AddToCartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  AddToCartPage({required this.cartItems});

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final imageUrl = cartItems[index]['image'];
          final price = cartItems[index]['price'];
          return ListTile(
            title: Image.network(imageUrl),
            subtitle: Text('Price: \$ $price'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  cartItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Total: \$ ${calculateTotal(cartItems)}',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  int calculateTotal(List<Map<String, dynamic>> cartItems) {
    return cartItems.fold(0, (previousValue, item) => previousValue + (item['price'] as int));
  }

}
