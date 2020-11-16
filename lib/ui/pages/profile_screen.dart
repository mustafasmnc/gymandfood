import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:gymandfood/model/exercise.dart';
import 'package:gymandfood/model/meal.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Exercise> monday = [];
  List<Exercise> tuesday = [];
  List<Exercise> wednesday = [];
  List<Exercise> thursday = [];
  List<Exercise> friday = [];
  List<Exercise> saturday = [];
  List<Exercise> sunday = [];

  @override
  void initState() {
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i].exerciseDayofweek == "1") {
        monday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "2") {
        tuesday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "3") {
        wednesday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "4") {
        thursday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "5") {
        friday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "6") {
        saturday.add(exercises[i]);
      } else if (exercises[i].exerciseDayofweek == "7") {
        sunday.add(exercises[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(40),
          ),
          child: BottomNavigationBar(
            currentIndex: 1,
            iconSize: 22,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            selectedItemColor: const Color(0xFF200087),
            unselectedItemColor: Colors.black45,
            selectedLabelStyle: TextStyle(
              color: Colors.pink,
              fontSize: 16,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.yellow,
              fontSize: 14,
            ),
            selectedIconTheme: IconThemeData(size: 28),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
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
                          subtitle: Text(
                            "Hello, Eric",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/originals/36/43/e7/3643e7e8dab9b88b3972ee1c9f909dea.jpg'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: _CalorieProgress(
                              width: height * 0.18, height: height * 0.18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.3,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MEALS FOR TODAY",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    SizedBox(height: height / 150),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < foods.length; i++)
                              _FoodCard(food: foods[i]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: height * 1.6,
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
                    dayCards("Monday", height, width, Color(0xFF6448FE),
                        Color(0xFF5FC6FF), monday),
                    SizedBox(height: height / 50),
                    dayCards("Tuesday", height, width, Color(0xFFD76D77),
                        Color(0xFFFFAF7B), tuesday),
                    SizedBox(height: height / 50),
                    dayCards("Wednesday", height, width, Color(0xFF155799),
                        Color(0xFF159957), wednesday),
                    SizedBox(height: height / 50),
                    dayCards("Thursday", height, width, Color(0xFFFFA738),
                        Color(0xFFFFE130), thursday),
                    SizedBox(height: height / 50),
                    dayCards("Friday", height, width, Color(0xFFFE6197),
                        Color(0xFFFFB463), friday),
                    SizedBox(height: height / 50),
                    dayCards("Saturday", height, width, Color(0xFF6190E8),
                        Color(0xFFA7BFE8), saturday),
                    SizedBox(height: height / 50),
                    dayCards("Sunday", height, width, Color(0xFFf83600),
                        Color(0xFFfe8c00), friday),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget dayCards(String dayName, double height, double width, Color color1,
      Color color2, List<Exercise> dayExercises) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 150,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [color1, color2]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(5, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dayName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: null)
            ],
          ),
          Container(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: dayExercises.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              dayExercises[i].exercisePic,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10)
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class _CalorieProgress extends StatelessWidget {
  final double height, width;

  const _CalorieProgress({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: height,
        width: width,
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
    double relativeProgress= 360*progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(-relativeProgress), false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //throw UnimplementedError();
    return true;
  }
}

class _FoodCard extends StatelessWidget {
  final Food food;

  const _FoodCard({@required this.food});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(20),
                      ),
                      child: Image.network(
                        food.foodPic,
                        width: 120,
                        fit: BoxFit.cover,
                      ))),
              Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: 5,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.foodName.length > 16
                              ? food.foodName.substring(0, 16) + "..."
                              : food.foodName,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                        //SizedBox(height: height / 150),
                        Text(
                          "Calorie: " + food.foodCal,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          "Protein: " + food.foodProtein,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          "Fat: " + food.foodFat,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(height: height / 100),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}