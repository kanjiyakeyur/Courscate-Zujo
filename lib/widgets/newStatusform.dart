import 'package:courscate/widgets/pickerimage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class NewFormStatus extends StatefulWidget {
  final bool isloading;
  final Function(String title, String dsecription, File image) submitStatus;
  NewFormStatus(this.submitStatus, this.isloading);
  @override
  _NewFormStatusState createState() => _NewFormStatusState();
}

class _NewFormStatusState extends State<NewFormStatus> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  File _image;
  final _descriptionFocuse = FocusNode();

  void _imagePicker(File pickedImage) {
    _image = pickedImage;
  }

  void _trySubmit() async {
    final isvalid = _formKey.currentState.validate();
    if (_image == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select image  !!!')));
      return;
    }
    if (isvalid) {
      _formKey.currentState.save();
      widget.submitStatus(_title, _description, _image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isloading
        ? Center(
            child: CircularProgressIndicator(
            strokeWidth: 1,
          ))
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ImagePicker(_imagePicker),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('title'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFocuse);
                    },
                    onSaved: (value) {
                      _title = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('description'),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: null,
                    minLines: 2,
                    focusNode: _descriptionFocuse,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    onSaved: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.isloading
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                        )
                      : RaisedButton.icon(
                          onPressed: _trySubmit,
                          icon: Icon(
                            Icons.near_me,
                            color: Colors.black,
                          ),
                          label: Text(
                            ' Confirm',
                            style: TextStyle(color: Colors.black),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                ],
              ),
            ),
          );
  }
}
