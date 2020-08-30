import 'dart:io';

import 'package:flutter/material.dart';
import './pickerimage.dart';

class AuthWidget extends StatefulWidget {
  final void Function(String email, String name, String pasword,
      File pickedimage, bool islogin) submitFn;
  final bool isloading;
  AuthWidget(this.submitFn, this.isloading);
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _pickedImage;

  void _imagePicker(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _trySubmit() {
    final isvalid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_pickedImage == null && !_isLogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select image  !!!')));
      return;
    }
    if (isvalid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail, _userName, _userPassword, _pickedImage, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              'CoursCate & Zujo',
              softWrap: true,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isLogin) ImagePicker(_imagePicker, true),
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'User Email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter valid No.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('name'),
                        decoration: InputDecoration(labelText: 'User Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Password must getter the 6 charecter';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    widget.isloading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              _isLogin ? 'Login' : 'Signup',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: _trySubmit,
                          ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'Already have account !'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
