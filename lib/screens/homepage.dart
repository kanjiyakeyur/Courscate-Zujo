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
        final d = snapshot.data.documents;
        final data = d.reversed.toList();
        if (data.length == 0) {
          return Container();
        }
        return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
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
