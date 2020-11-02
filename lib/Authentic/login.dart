import 'package:flutter/material.dart';
import 'package:flutterapp/DialogBox/errorDialog.dart';
import 'package:flutterapp/Widgets/CustomTextField.dart';
import 'package:flutterapp/Widgets/product.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
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
                      onTap: () => ("Click"),
                      child: CircleAvatar(
                        radius: _screenwidth * 0.15,
                        backgroundColor: Colors.white,
                      ),
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
                  ],
                )),
            RaisedButton(
              onPressed: () {
                _displayDialog("Sorry Server Down........");
              },
              //   =>
              // ("Click"),
              color: Colors.pink,

              child: Text(
                "Login",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Product()));
              },
              //   =>
              // ("Click"),
              color: Colors.pink,
              // child: Icon(Icons.person),
              child: Text(
                "Shopping as Guest",
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

  Widget _displayDialog(String s) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: s,
          );
        });
  }
}
