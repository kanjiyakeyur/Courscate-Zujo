import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart' as im;

class ImagePicker extends StatefulWidget {
  ImagePicker(this.imgPickerFn);
  final void Function(File pickedImage) imgPickerFn;
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File _pickedImage;
  void _imagepicker() async {
    final File _pickedImageD = await im.ImagePicker.pickImage(
        source: im.ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      _pickedImage = _pickedImageD;
    });
    widget.imgPickerFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage)
              : AssetImage(
                  'assets/images/user.png',
                ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: _imagepicker,
              child: Row(
                children: <Widget>[
                  Icon(Icons.image),
                  SizedBox(
                    width: 10,
                  ),
                  Text('pick image'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
