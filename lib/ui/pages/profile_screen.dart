import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/signin.dart';
import 'package:gymandfood/widgets/calorie_progress.dart';
import 'package:gymandfood/widgets/favorite_food.dart';
import 'package:gymandfood/widgets/widgets.dart';
import 'package:intl/intl.dart';

String userId;
int userDailyCalorie;
bool logOut = false;

DatabaseService databaseService = DatabaseService();

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List favoriteFoodsId;
  String userName;
  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
      });
    });
    getData();
    super.initState();
  }

  void getData() async {
    FirebaseFirestore.instance.collection("user").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data()["userDailyCalorie"]);
        setState(() {
          userDailyCalorie = result.data()["userDailyCalorie"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
        //centerTitle: true,
        title: StreamBuilder(
            stream: databaseService.getUserInfo(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              } else
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          "Hello, " + snapshot.data['userName'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(snapshot.data['userPic']),
                      backgroundColor: Colors.transparent,
                    )
                  ],
                );
            }),
        actions: [],
      ),
      backgroundColor: const Color(0xFFE9E9E9),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              height: height * 0.25,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ListTile(
                      //   title: Text(
                      //     formattedDate,
                      //     style: TextStyle(
                      //         fontSize: 16, fontWeight: FontWeight.w400),
                      //   ),
                      //   subtitle: StreamBuilder(
                      //     stream: databaseService.getUserName(userId),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return Text("");
                      //       } else {
                      //         return Text(
                      //           "Hello, " + snapshot.data['userName'],
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w600),
                      //         );
                      //       }
                      //     },
                      //   ),
                      //   trailing: CircleAvatar(
                      //     radius: 30.0,
                      //     backgroundImage: NetworkImage(user.userPhoto),
                      //     backgroundColor: Colors.transparent,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            CalorieProgress(
                                width: width * 0.35,
                                height: width * 0.35,
                                progress: 0.7,
                                userDailyCalorie: userDailyCalorie,
                                userId: userId),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _IngredientProgress(
                                  width: width * 0.30,
                                  ingredient: "Protein",
                                  progress: 0.3,
                                  progressColor: Colors.green,
                                  leftAmount: 72,
                                ),
                                _IngredientProgress(
                                  width: width * 0.30,
                                  ingredient: "Carbs",
                                  progress: 0.5,
                                  progressColor: Colors.red,
                                  leftAmount: 110,
                                ),
                                _IngredientProgress(
                                  width: width * 0.30,
                                  ingredient: "Fat",
                                  progress: 0.7,
                                  progressColor: Colors.yellow,
                                  leftAmount: 27,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            FavoriteFood(userId: userId),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: height * 1.85,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Weakly Workouts",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  SizedBox(height: height / 100),
                  dayCards(userId, "Monday", "1", height, width,
                      Color(0xFF6448FE), Color(0xFF5FC6FF)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Tuesday", "2", height, width,
                      Color(0xFFD76D77), Color(0xFFFFAF7B)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Wednesday", "3", height, width,
                      Color(0xFF155799), Color(0xFF159957)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Thursday", "4", height, width,
                      Color(0xFFFFA738), Color(0xFFFFE130)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Friday", "5", height, width,
                      Color(0xFFFE6197), Color(0xFFFFB463)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Saturday", "6", height, width,
                      Color(0xFF6190E8), Color(0xFFA7BFE8)),
                  SizedBox(height: height / 50),
                  dayCards(userId, "Sunday", "7", height, width,
                      Color(0xFFf83600), Color(0xFFfe8c00)),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Profile Settings",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'helvetica_neue_light',
                          color: Colors.black87,
                        ),
                      ))
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                showUserSettingsScreen(context, userId);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 24,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Todays Foods",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'helvetica_neue_light',
                          color: Colors.black87,
                        ),
                      ))
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                showAddedFoods(context, userId);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 24,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'helvetica_neue_light',
                          color: Colors.black87,
                        ),
                      ))
                ],
              ),
              onTap: () {
                HelperFunctions.saveUserLoggedInDetails(
                    isLoggedIn: false, userId: null);
                setState(() {
                  logOut = true;
                });
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
                //App(loggedIn:false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/drawer_header_background.png'))),
        child: Stack(
          children: [
            // Positioned(
            //     bottom: 12,
            //     left: 20,
            //     child: Text(
            //       "userName",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 22,
            //           fontWeight: FontWeight.w500),
            //     ))
          ],
        ));
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey[300]),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: progressColor),
                )
              ],
            ),
            SizedBox(width: 5),
            Text("${leftAmount}g left")
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
