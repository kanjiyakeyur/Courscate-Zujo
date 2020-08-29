import 'dart:io';

import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../widgets/auth__widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isloding = false;

  void _submitAuthForm(
    String email,
    String name,
    String password,
    File pickedimage,
    bool islogin,
  ) async {
    try {
      setState(() {
        _isloding = true;
      });
      AuthResult authResult;
      if (islogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        //await Provider.of<User>(context).loginUserSetup(authResult.user.uid);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('userImg')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(pickedimage).onComplete;
        final imgUrl = await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': name,
          'email': email,
          'imgUrl': imgUrl,
          'userid': authResult.user.uid
        });

        await Provider.of<User>(context, listen: false).signupUserSetup(
            authResult.user.uid, name, email, imgUrl, pickedimage);
      }
    } on PlatformException catch (error) {
      var errorMessage = 'An Error Occure';
      if (error != null) {
        errorMessage = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isloding = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isloding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Theme.of(context).accentColor,
      body: AuthWidget(_submitAuthForm, _isloding),
    );
  }
}
