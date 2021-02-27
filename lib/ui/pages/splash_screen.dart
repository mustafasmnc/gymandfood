import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/ui/pages/navigation_page.dart';
import 'package:gymandfood/ui/pages/signin.dart';
import 'package:gymandfood/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                _isUserLoggedIn == true ? NavigationPage() : SignIn())));
  }

  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value) {
      setState(() {
        _isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [1.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Image.asset('assets/logo.png'),
              fitFoodText(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w100),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
            ],
          ),
        ),
      ),
    );
  }
}
