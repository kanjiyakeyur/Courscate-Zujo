import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../widgets/newStatusform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewStatus extends StatefulWidget {
  static const routename = 'newStatus';
  @override
  _NewStatusState createState() => _NewStatusState();
}

class _NewStatusState extends State<NewStatus> {
  bool _isloading;

  Future<void> _submitStatus(
    String title,
    String description,
    File image,
  ) async {
    final userdata = Provider.of<User>(context, listen: false).userDetails;
    try {
      setState(() {
        _isloading = true;
      });
      final data = await Firestore.instance.collection('status').add({
        'title': title,
        'description': description,
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('statusImage')
          .child(data.documentID + '.jpg');
      await ref.putFile(image).onComplete;
      final imgUrl = await ref.getDownloadURL();
      await Firestore.instance
          .collection('status')
          .document(data.documentID)
          .setData({'imgUrl': imgUrl});
      await Firestore.instance
          .collection('users')
          .document(userdata['uid'])
          .setData({'posts': data.documentID});

      setState(() {
        _isloading = false;
      });
    } catch (error) {
      print(error.toString());
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scafoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text(
          'New Status',
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: NewFormStatus(_submitStatus, _isloading),
    );
  }
}
