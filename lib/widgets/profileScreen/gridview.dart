import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './gridviewcard.dart';

class GridV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context).userDetails;
    return StreamBuilder(
      stream: Firestore.instance
          .collection('status')
          .orderBy('date')
          .where('userID', isEqualTo: currentUser['uid'])
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final data = snapshot.data.documents;
        return GridView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            //childAspectRatio: 3 / 2,
          ),
          itemBuilder: (ctx, index) {
            return GridViewCard(data[index]);
          },
        );

        //ListView.builder(
        //    itemCount: snapshot.data.documents.length,
        //    itemBuilder: (ctx, index) {
        //      return Text(snapshot.data.documents[index].documentID);
        //    });
      },
    );
  }
}
