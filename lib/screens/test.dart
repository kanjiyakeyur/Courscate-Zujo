import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('status')
          .where('userID', isEqualTo: 'Fq3rwg3aaBXJlfq8xnUqikpeyhx2')
          .getDocuments()
          .asStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              return Text(snapshot.data.documents[index].documentID);
            });
      },
    );
  }
}
