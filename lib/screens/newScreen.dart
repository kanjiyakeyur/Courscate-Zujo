import 'package:courscate/widgets/oneCard.dart';
import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  static const routename = 'newScree';
  @override
  Widget build(BuildContext context) {
    final dynamic data = ModalRoute.of(context).settings.arguments as dynamic;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Status',
          style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: OneCard(data),
    );
  }
}
