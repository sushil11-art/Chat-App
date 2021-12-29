import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late XFile _pickedImage;
  // PickedFile? imageFile = null;
  ImagePicker _picker = ImagePicker();
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      // _picker.pickImage
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _pickedImage = pickedFile as XFile;
      // imageFile = pickedFile! as PickedFile?;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _pickedImage = pickedFile as XFile;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
        ),
        ElevatedButton.icon(
            onPressed: () {
              _showChoiceDialog(context);
            },
            icon: Icon(Icons.camera_alt),
            label: Text('Upload a picture')),
      ],
    );
  }
}
