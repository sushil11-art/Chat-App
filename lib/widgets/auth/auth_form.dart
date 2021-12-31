import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

// ignore: empty_constructor_bodies
class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(String email, String username, File? image,
      String password, bool isLogin, BuildContext context) submitFn;
  // const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';

  File? _image;

  void _pickedImage(File image) {
    _image = image;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState!.validate();
    // to close the keyboard
    FocusScope.of(context).unfocus();
    if (!_isLogin && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please upload a image"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (_isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userName.trim(), _image,
          _userPassword.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "Please enter at least 4 letters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Please enter password of minimun 7 letters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Signup')),
                  if (!widget.isLoading)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create New account'
                            : 'I already have account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
