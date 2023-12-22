import 'package:flutter/material.dart';

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