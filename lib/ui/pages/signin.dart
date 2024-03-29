import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/auth.dart';
import 'package:gymandfood/ui/pages/navigation_page.dart';
import 'package:gymandfood/ui/pages/signup.dart';
import 'package:gymandfood/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String email, password, name;
  bool _toggleVisibility = true;
  AuthService authService = new AuthService();

  signIn() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (_formKey.currentState.validate()) {
          await authService.singInEmailAndPass(email, password).then((value) {
            if (value.substring(0, 5) != 'Error') {
              HelperFunctions.saveUserLoggedInDetails(
                  isLoggedIn: true, userId: value);
              print("User Id: " + value);
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Flexible(
                  flex: 5,
                  child: Image(
                    image: AssetImage('assets/logoWhite.jpg'),
                    height: 100,
                  )),
              SizedBox(height: 15),
              fitFoodText(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Flexible(
                flex: 2,
                child: TextFormField(
                  //style: TextStyle(color:Theme.of(context).primaryColor),
                  validator: (value) {
                    return value.isEmpty ? "Enter email" : null;
                  },
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
                    return value.isEmpty ? "Enter password" : null;
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
                    print("email: $email, password: $password");
                    signIn();
                  },
                  child: submitButton(context: context, text: "Sign In"),
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
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
