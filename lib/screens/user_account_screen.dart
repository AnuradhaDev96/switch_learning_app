import 'package:flutter/material.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Account'),
      ),
      body: Container(
        color: Colors.grey,
      ),
    );
  }
}