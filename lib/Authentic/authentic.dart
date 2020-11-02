import 'package:flutter/material.dart';
import 'package:flutterapp/Authentic/login.dart';
import 'package:flutterapp/Authentic/register.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.pink, Colors.pink],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
          ),
          title: Text(
            "PandaMart",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: Colors.yellow,
                fontFamily: "Signatra.ttf"),
          ),
          centerTitle: false,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.yellow,
                ),
                text: "Login",
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.yellow,
                ),
                text: "Register",
              )
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: TabBarView(children: [
              Login(),
              Register(),
            ])),
      ),
    );
  }
}
