import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Config/config.dart';
import 'package:flutterapp/DialogBox/errorDialog.dart';
import 'package:flutterapp/Widgets/CustomTextField.dart';
import 'package:flutterapp/Widgets/product.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nametextEditingController =
      TextEditingController();
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordtextEditingController =
      TextEditingController();
  File _imageFile;
  final picker = ImagePicker();
  String userImageUrl = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        screenheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: _selectAndPickImage,
                      //() => ("Click"),
                      child: CircleAvatar(
                        radius: _screenwidth * 0.15,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _imageFile == null ? null : FileImage(_imageFile),
                        child: _imageFile == null
                            ? Icon(
                                Icons.add_photo_alternate,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    CustomTextField(
                      controller: _nametextEditingController,
                      data: Icons.person,
                      hintText: "Name",
                      isObsecure: false,
                    ),
                    CustomTextField(
                      controller: _emailtextEditingController,
                      data: Icons.email,
                      hintText: "Email",
                      isObsecure: false,
                    ),
                    CustomTextField(
                      controller: _passwordtextEditingController,
                      data: Icons.lock,
                      hintText: "Password",
                      isObsecure: true,
                    ),
                    CustomTextField(
                      controller: _cpasswordtextEditingController,
                      data: Icons.lock,
                      hintText: "Confirm Password",
                      isObsecure: true,
                    ),
                  ],
                )),
            RaisedButton(
              onPressed: () {
                displayDialog("Server busy...Try Again Later....");
                //uploadAndSaveImage();
              },
              // => ("Click"),
              color: Colors.pink,
              // child: Icon(Icons.person),
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
//    _imageFile=await ImagePicker.getImage(source: ImageSource.gallery);
//    _imageFile = await (PicImagePicker().getImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select file",
            );
          });
    } else
      _passwordtextEditingController.text ==
              _cpasswordtextEditingController.text
          ? _emailtextEditingController.text.isNotEmpty &&
                  _passwordtextEditingController.text.isNotEmpty &&
                  _cpasswordtextEditingController.text.isNotEmpty &&
                  _nametextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please fill up the registration complete form..")
          : displayDialog("Password do not match");
  }

//
  displayDialog(String msg) {
    debugPrint("sethupathi...........................");

    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  // this is image show in avatar
  uploadToStorage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;

      _registerUser();
    });
  }

//
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailtextEditingController.text.trim(),
      password: _passwordtextEditingController.text.trim(),
    )
        .then((_auth) {
      firebaseUser = _auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });

    Future saveUserInfoToFireStore(User fUser) async {
      FirebaseFirestore.instance.collection("user").doc(fUser.uid).set({
        "uid": fUser.uid,
        "email": fUser.email,
        "name": _nametextEditingController.text.trim(),
        "url": userImageUrl,
      });

      await PandaMart.sharedPreferences.setString("uid", fUser.uid);
      await PandaMart.sharedPreferences
          .setString(PandaMart.userEmail, fUser.email);

      await PandaMart.sharedPreferences
          .setString(PandaMart.userName, _nametextEditingController.text);

      await PandaMart.sharedPreferences
          .setString(PandaMart.userAvatarUrl, userImageUrl);
    }



    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Product()));
    }
  }
}
