import 'package:flutter/material.dart';

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