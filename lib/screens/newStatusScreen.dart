import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isloading = false;

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
      //add new post to data base
      final data = await Firestore.instance.collection('status').add({
        'title': title,
        'description': description,
        'userID': userdata['uid'],
        'userImgUrl': userdata['imgUrl'],
        'userName': userdata['userName'],
        'date': DateTime.now().toIso8601String()
      });
      print('add new post to data base');

      //image upload
      final ref = FirebaseStorage.instance
          .ref()
          .child('statusImage')
          .child(data.documentID + '.jpg');
      await ref.putFile(image).onComplete;
      //image link
      final imgUrl = await ref.getDownloadURL();
      print('image uploaded');

      //lisk add to post
      await Firestore.instance
          .collection('status')
          .document(data.documentID)
          .updateData({'imgUrl': imgUrl});
      print('link add to status');

      //var a = [data.documentID];

      //add status id to user
      //await Firestore.instance
      //    .collection('users')
      //    .document(userdata['uid'])
      //    .updateData({'posts': a});

      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    } on PlatformException catch (error) {
      print(error.message);
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
