import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Icon(Icons.add),
      ),
    );
  }
}
