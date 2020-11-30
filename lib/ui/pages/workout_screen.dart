import 'package:flutter/material.dart';
import 'package:gymandfood/model/user_exercises.dart';
import 'package:intl/intl.dart';

class WorkoutScreen extends StatefulWidget {
  List<UserExercises> workouts = [];
  WorkoutScreen(this.workouts);
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
      //backgroundColor: const Color(0xFF200087),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: IconButton(
            //       icon: Icon(Icons.close, color: Colors.black, size: 30),
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       }),
            // ),
            SizedBox(height: 5),
            ListTile(
              title: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Workouts",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "60 mins",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // for (int i=0; i<widget.workouts.length; i++)
            // Column(
            //   children: [

            //   ],
            // )
            Expanded(
              child: ListView.builder(
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.workouts.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Card(
                        color: Color(0xFF26547C).withOpacity(.5),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              widget.workouts[i].exercisePic,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            widget.workouts[i].exerciseName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            widget.workouts[i].exerciseSetRepeat,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          // trailing: ClipRRect(
                          //   borderRadius: BorderRadius.circular(10),
                          //   child: Image.asset(
                          //     widget.workouts[i].exercisePic,
                          //     width: 50,
                          //     height: 50,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
