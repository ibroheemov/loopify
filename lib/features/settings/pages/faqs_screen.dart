import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  Future<String> loadText(String fileName) async {
    return await rootBundle.loadString('assets/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAQs")),
      body: FutureBuilder<String>(
        future: loadText("faqs.txt"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load the data.'));
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Text(snapshot.data ?? '', style: TextStyle(fontSize: 16)),
            );
          }
        },
      ),
    );
  }
}
