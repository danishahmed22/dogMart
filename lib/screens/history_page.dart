// history_page.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> historyData;

  HistoryPage({required this.historyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final imageUrl = historyData[index]['image'];
          final price = historyData[index]['price'];
          return ListTile(
            title: Image.network(imageUrl),
            subtitle: Text('Price: \$ $price'),
          );
        },
      ),
    );
  }
}
