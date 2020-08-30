import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _uid;
  String _userName;
  String _imgUrl;
  String _email;
  File _image;
  List<String> _posts;
  bool fetched = false;
  Map<String, String> get userDetails {
    return {
      'uid': _uid,
      'userName': _userName,
      'email': _email,
      'imgUrl': _imgUrl
    };
  }

  List<String> get userPost {
    return _posts;
  }

  File get image {
    return _image;
  }

  void logout() async {
    fetched = false;
    _uid = '';
    _email = '';
    _imgUrl = '';
  }

  Future<void> loginUserSetup(String uid) async {
    await fatchUser(uid);
  }

  Future<void> autoLogin() async {
    var us = await FirebaseAuth.instance.currentUser();
    await fatchUser(us.uid);
  }

  Future<void> signupUserSetup(
      String id, String name, String email, String imgUrl, File image) async {
    _uid = id;
    _userName = name;
    _email = email;
    _imgUrl = imgUrl;
    _image = image;
    fetched = true;
  }

  Future<void> fatchUser(String uid) async {
    if (!fetched) {
      final d = Firestore.instance.collection('users');
      final data = await d.document(uid).get();
      _uid = uid;
      _userName = data['username'];
      _email = data['email'];
      _imgUrl = data['imgUrl'];
      fetched = true;
    }
  }
}
