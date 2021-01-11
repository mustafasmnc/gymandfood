import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymandfood/ui/pages/app.dart';
import 'package:gymandfood/ui/pages/signin.dart';

import 'helper/functions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserLoggedIn = false;
  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }
  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        print("vall: $value");
        _isUserLoggedIn=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _isUserLoggedIn == true ? App(loggedIn:_isUserLoggedIn) : SignIn(),);
  }
}
