import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  // const UserImagePicker({Key? key}) : super(key: key);
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  // File? _pickedImage;
  File? file;
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
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 50);
    setState(() {
      // final = await _picker.pickImage(source: source);

      file = File(image!.path);
      // return file;
      //   _pickedImage = pickedFile as File;
      // imageFile = pickedFile! as PickedFile?;
    });
    widget.imagePickFn(file!);

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
    setState(() {
      file = File(image!.path);
    });
    widget.imagePickFn(file!);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: file != null ? FileImage(file!) : null,
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
