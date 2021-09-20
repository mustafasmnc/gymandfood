import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/auth.dart';
import 'package:gymandfood/ui/pages/navigation_page.dart';
import 'package:gymandfood/ui/pages/signin.dart';
import 'package:gymandfood/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String userName, email, password, userId;
  bool _toggleVisibility = true;
  AuthService authService = new AuthService();

  signUp() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (_formKey.currentState.validate()) {
          authService.signUpWithEmailAndPass(email, password).then((value) {
            if (value.substring(0, 5) != 'Error') {
              HelperFunctions.saveUserLoggedInDetails(
                  isLoggedIn: true, userId: value);
              print("User ID: $value");
              setUserDataa(value, email, userName);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavigationPage()));
            } else {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                  content: Text(value),
                ),
              );
            }
          });
        }
      }
      if (_formKey.currentState.validate()) {
        authService.signUpWithEmailAndPass(email, password).then((value) {
          if (value.substring(0, 5) != 'Error') {
            HelperFunctions.saveUserLoggedInDetails(
                isLoggedIn: true, userId: value);
            print("User ID: $value");
            setUserDataa(value, email, userName);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavigationPage()));
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                content: Text(value),
              ),
            );
          }
        });
      }
    } on SocketException catch (_) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          content: Text("There is no internet connection!"),
        ),
      );
    }
  }

  Future<void> setUserDataa(
      String userId, String userEmail, String userName) async {
    Map<String, dynamic> userData = {
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "userType": "user",
      "userPic":
          "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/determined-face.png?alt=media&token=9525d1fe-d652-4708-9215-618873fa659a",
      "userDailyCalorie": 0,
      "userDailyCarb": 0,
      "userDailyProtein": 0,
      "userDailyFat": 0
    };
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection("user")
            //.doc('user_info')
            //.collection('user_info')
            .doc(userId)
            .set(userData)
            .catchError((e) {
          print(e.toString());
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: appBar(context),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   brightness: Brightness.light,
      //   centerTitle: true,
      // ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Flexible(
                  flex: 5,
                  child: Image(
                    image: AssetImage('assets/logoWhite.jpg'),
                    height: 100,
                  )),
              SizedBox(height: 10),
              fitFoodText(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Flexible(
                flex: 2,
                child: TextFormField(
                  validator: (value) {
                    return value.isEmpty ? "Enter your name" : null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide()),
                  ),
                  onChanged: (value) {
                    userName = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: TextFormField(
                  validator: (value) {
                    return value.isEmpty ? "Enter your email" : null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide()),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: TextFormField(
                  validator: (value) {
                    return value.isEmpty ? "Enter your password" : null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: _toggleVisibility
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _toggleVisibility = !_toggleVisibility;
                          });
                        }),
                    labelText: 'Password',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide()),
                  ),
                  obscureText: _toggleVisibility,
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    signUp();
                  },
                  child: submitButton(context: context, text: "Sign Up"),
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
