import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  void _pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text("Choose image source"), actions: [
        ElevatedButton(
            child: const Text("Camera"), onPressed: () => ImageSource.camera),
        ElevatedButton(
          child: const Text("Gallery"),
          onPressed: () => ImageSource.camera,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.camera_alt),
            label: Text('Upload a picture')),
      ],
    );
  }
}
