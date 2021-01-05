import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/model/user.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/widgets/favorite_food.dart';
import 'package:gymandfood/widgets/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:gymandfood/model/user_exercises.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  String userId;

  ProfileScreen({Key key, this.userId}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<UserExercises> monday = [];
  List<UserExercises> tuesday = [];
  List<UserExercises> wednesday = [];
  List<UserExercises> thursday = [];
  List<UserExercises> friday = [];
  List<UserExercises> saturday = [];
  List<UserExercises> sunday = [];
  List favoriteFoodsId;
  String userName;

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        widget.userId = value;
      });
    });

    for (int i = 0; i < user_exercises.length; i++) {
      if (user_exercises[i].exerciseDayofweek == "1") {
        monday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "2") {
        tuesday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "3") {
        wednesday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "4") {
        thursday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "5") {
        friday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "6") {
        saturday.add(user_exercises[i]);
      } else if (user_exercises[i].exerciseDayofweek == "7") {
        sunday.add(user_exercises[i]);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        // bottomNavigationBar: ClipRRect(
        //   borderRadius: BorderRadius.vertical(
        //     top: const Radius.circular(40),
        //   ),
        //   child: BottomNavigationBar(
        //     currentIndex: 1,
        //     iconSize: 22,
        //     showSelectedLabels: false,
        //     showUnselectedLabels: false,
        //     selectedFontSize: 0,
        //     unselectedFontSize: 0,
        //     selectedItemColor: const Color(0xFF200087),
        //     unselectedItemColor: Colors.black45,
        //     selectedLabelStyle: TextStyle(
        //       color: Colors.pink,
        //       fontSize: 16,
        //     ),
        //     unselectedLabelStyle: TextStyle(
        //       color: Colors.yellow,
        //       fontSize: 14,
        //     ),
        //     selectedIconTheme: IconThemeData(size: 28),
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: "Home",
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.search),
        //         label: "Search",
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: "Profile",
        //       ),
        //     ],
        //   ),
        // ),
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
                            stream: databaseService.getUserName(widget.userId),
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
                          trailing: GestureDetector(
                            onTap: () {
                              //getFoodsId();
                            },
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(user.userPhoto),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              _CalorieProgress(
                                width: width * 0.35,
                                height: width * 0.35,
                                progress: 0.7,
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
              FavoriteFood(userId: widget.userId),
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
                    dayCards(widget.userId, "Monday", "1", height, width,
                        Color(0xFF6448FE), Color(0xFF5FC6FF), monday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Tuesday", "2", height, width,
                        Color(0xFFD76D77), Color(0xFFFFAF7B), tuesday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Wednesday", "3", height, width,
                        Color(0xFF155799), Color(0xFF159957), wednesday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Thursday", "4", height, width,
                        Color(0xFFFFA738), Color(0xFFFFE130), thursday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Friday", "5", height, width,
                        Color(0xFFFE6197), Color(0xFFFFB463), friday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Saturday", "6", height, width,
                        Color(0xFF6190E8), Color(0xFFA7BFE8), saturday),
                    SizedBox(height: height / 50),
                    dayCards(widget.userId, "Sunday", "7", height, width,
                        Color(0xFFf83600), Color(0xFFfe8c00), friday),
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

class _CalorieProgress extends StatelessWidget {
  final double height, width, progress;

  const _CalorieProgress({this.height, this.width, this.progress});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "1731",
                  style: TextStyle(
                    color: Color(0xFF200087),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              TextSpan(text: "\n"),
              TextSpan(
                  text: "kcal",
                  style: TextStyle(
                    color: Color(0xFF200087),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
            ]),
          ),
        ),
      ),
      painter: _ProgressPainter(progress: 0.7),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter({this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 8
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Offset center = Offset(size.height / 2, size.width / 2);
    double relativeProgress = 360 * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(-relativeProgress), false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //throw UnimplementedError();
    return true;
  }
}
