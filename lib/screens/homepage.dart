import 'package:courscate/widgets/oneCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('status').orderBy('date').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data.documents;
        return ListView.builder(
            itemCount: data.length,
            reverse: true,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: OneCard(data[index]),
              );
            });
      },
    );
  }
}
