// import 'dart:html';

import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({Key? key}) : super(key: key);

  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(String email, String username, var image,
      String password, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // ...image upload

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(image!);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user!.uid)
            .set({"username": username, 'email': email, 'image_url': url});
      }
    } on FirebaseAuthException catch (err) {
      var message = "An error occured,please check credentials";

      if (err.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (err.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
        print("email already used");
        // Get.snackbar("Authentication failed", message,
        //     snackPosition: SnackPosition.TOP,
        //     backgroundColor: Colors.green,
        //     margin: const EdgeInsets.all(30));

      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
      // Scaffold.of(ctx)
      //     // ignore: deprecated_member_use
      //     .showBottomSheet((ctx) => Text(message), backgroundColor: Colors.red);

      // print(err.message);

    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      // print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
