import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PolicyScreen extends StatelessWidget {
  Future<String> loadPolicyText(String fileName) async {
    return await rootBundle.loadString('assets/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: FutureBuilder<String>(
        future: loadPolicyText("privacy_policy.txt"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load policy.'));
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
