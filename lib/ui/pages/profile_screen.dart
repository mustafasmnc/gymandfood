import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/model/user.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/widgets/calorie_progress.dart';
import 'package:gymandfood/widgets/favorite_food.dart';
import 'package:gymandfood/widgets/widgets.dart';
import 'package:intl/intl.dart';

String userId;
int userDailyCalorie;
DocumentSnapshot snapshot;

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

  showAddedFoods() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                        stream: databaseService.getDailyFoods(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data.docs.length == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                child: Text("Please add food",
                                    style: TextStyle(
                                      fontFamily: 'helvetica_neue_light',
                                      fontSize: 20,
                                    )),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot auf =
                                      snapshot.data.docs[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      //color: widget.color.withOpacity(.2),
                                      child: GestureDetector(
                                        child: ListTile(
                                          trailing: GestureDetector(
                                              onTap: () {
                                                databaseService
                                                    .removeDailyFoods(
                                                        userId, auf.id);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.black54,
                                              )),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              auf["foodPic"],
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text(
                                            auf["foodName"],
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                "Calorie: ${auf["foodCal"]}",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "Protein: ${auf["foodProtein"]}",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: height * 0.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            formattedDate,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          subtitle: StreamBuilder(
                            stream: databaseService.getUserName(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("");
                              } else {
                                return Text(
                                  "Hello, " + snapshot.data['userName'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                );
                              }
                            },
                          ),
                          trailing: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(user.userPhoto),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showAddedFoods();
                                },
                                child: CalorieProgress(
                                    width: width * 0.35,
                                    height: width * 0.35,
                                    progress: 0.7,
                                    userDailyCalorie: userDailyCalorie,
                                    userId: userId),
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
