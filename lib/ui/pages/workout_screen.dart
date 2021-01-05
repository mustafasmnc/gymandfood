import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:intl/intl.dart';

class WorkoutScreen extends StatefulWidget {
  Color color;
  String userId;
  String dayId;
  WorkoutScreen(this.color, this.userId, this.dayId);
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
      backgroundColor: widget.color.withOpacity(.7),
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
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "Workouts",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
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
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "60 mins",
                          style: TextStyle(
                            color: Colors.white,
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: databaseService.getAddedExercises(
                      widget.userId, widget.dayId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data.docs.length == 0) {
                      return Center(
                          child: Text(
                        "Sorry, no exercise found.\nPlease add exercise.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ));
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot aue = snapshot.data.docs[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Card(
                                color: widget.color.withOpacity(.2),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      aue["exercisePic"],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    aue["exerciseName"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "Set: ${aue["exerciseSet"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Repeat: ${aue["exerciseRepeat"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                          });
                      // return ReorderableListView(
                      //   children:
                      //       List.generate(snapshot.data.docs.length, (index) {
                      //         DocumentSnapshot aue = snapshot.data.docs[index];
                      //     return ListTile(
                      //       key: ValueKey("value $index"),
                      //       leading: ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: Image.network(
                      //           aue["exercisePic"],
                      //           width: 50,
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //       title: Text(
                      //         aue["exerciseName"],
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w800,
                      //           fontSize: 18,
                      //         ),
                      //       ),
                      //       subtitle: Row(
                      //         children: [
                      //           Text(
                      //             "Set: ${aue["exerciseSet"]}",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //           SizedBox(width: 10),
                      //           Text(
                      //             "Repeat: ${aue["exerciseRepeat"]}",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   }),
                      //   // onReorder: (int oldIndex, int newIndex) {
                      //   //   setState(() {
                      //   //     _updateMyItems(snapshot.data,oldIndex, newIndex);
                      //   //   });
                      //   // },
                      // );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  // void _updateMyItems(QuerySnapshot data,int oldIndex, int newIndex) {
  //   if (newIndex > oldIndex) {
  //     newIndex -= 1;
  //   }
  //   final UserExercises item = data.removeAt(oldIndex);
  //   widget.workouts.insert(newIndex, item);
  // }
}
