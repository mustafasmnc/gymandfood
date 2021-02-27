import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/workout_screen.dart';

Widget submitButton(
    {BuildContext context,
    String text,
    double buttonWith,
    double buttonheight,
    Color buttoncolor}) {
  return Container(
    height: buttonheight == null ? 50 : buttonheight,
    alignment: Alignment.center,
    width: buttonWith != null ? buttonWith : MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: buttoncolor == null ? Theme.of(context).primaryColor : buttoncolor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget noData(double topPadding) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: topPadding),
      Image.asset(
        "assets/nodata.png",
        width: 50,
        fit: BoxFit.cover,
      ),
      Text("There is no data",
          style: TextStyle(
            color: Colors.red[300],
            fontSize: 14,
          ),
          textAlign: TextAlign.center),
    ],
  );
}

showAlertDialog(BuildContext context, String title, String content) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'helvetica_neue_light',
                            fontSize: 20,
                            color: title == "Error" ? Colors.red : Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Divider(color: Colors.black54),
                        SizedBox(height: 10),
                        Text(
                          content,
                          style: TextStyle(
                            fontFamily: 'helvetica_neue_light',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    )),
                InkWell(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff00bfa5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget dayCards(
  String userId,
  String dayName,
  String dayId,
  double height,
  double width,
  Color color1,
  Color color2,
) {
  DatabaseService databaseService = DatabaseService();

  return OpenContainer(
    closedElevation: 0,
    transitionDuration: const Duration(milliseconds: 1500),
    openShape: const ContinuousRectangleBorder(),
    transitionType: ContainerTransitionType.fade,
    closedColor: Color(0xFFE9E9E9),
    openBuilder: (context, _) {
      return WorkoutScreen(color1, userId, dayId);
    },
    closedBuilder: (context, VoidCallback openContainer) {
      return GestureDetector(
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => WorkoutScreen(dayExercises)));
        // },
        onTap: openContainer,
        child: Container(
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
                        null,
                        color: Colors.white,
                      ),
                      onPressed: null)
                ],
              ),
              Container(
                  height: 60,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: databaseService.getUserExercises(userId, dayId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data.docs.length == 0) {
                          return Center(
                              child: Text(
                            "Sorry, no exercise found.\nPlease add exercise.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ));
                        } else {
                          try {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot aue =
                                      snapshot.data.docs[index];
                                  return Container(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            aue["exercisePic"],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 10)
                                      ],
                                    ),
                                  );
                                });
                          } catch (e) {
                            print(e);
                            return Center(
                              child: Text("Error"),
                            );
                          }
                        }
                      }))
            ],
          ),
        ),
      );
    },
  );
}

showAddedFoods(BuildContext context, String userId) {
  DatabaseService databaseService = DatabaseService();

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          content: Container(
            //height: MediaQuery.of(context).size.height * 0.6,
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
                          try {
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
                          } catch (e) {
                            print(e);
                            return Center(
                              child: Text("Error"),
                            );
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      });
}

showUserSettingsScreen(BuildContext context, String userId) {
  TextEditingController textUserName = TextEditingController();
  TextEditingController textDailyCalorie = TextEditingController();
  TextEditingController textDailyCarb = TextEditingController();
  TextEditingController textDailyProtein = TextEditingController();
  TextEditingController textDailyFat = TextEditingController();
  DatabaseService databaseService = DatabaseService();

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 370.0,
            child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: databaseService.getUserInfo(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      try {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ClipRRect(
                                  child: Image(
                                    image: NetworkImage(
                                      snapshot.data["userPic"],
                                    ),
                                    height: 80,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    decoration: new InputDecoration(
                                      hintText:
                                          snapshot.data["userName"].toString(),
                                    ),
                                    controller: textUserName,
                                    maxLength: 25,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            new Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                            "Daily Calorie",
                                            style: TextStyle(
                                              fontFamily:
                                                  'helvetica_neue_light',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: TextField(
                                            decoration: new InputDecoration(
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: snapshot
                                                  .data["userDailyCalorie"]
                                                  .toString(),
                                            ),
                                            controller: textDailyCalorie,
                                            maxLength: 4,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text(
                                              "Daily Carb",
                                              style: TextStyle(
                                                fontFamily:
                                                    'helvetica_neue_light',
                                                fontSize: 20,
                                              ),
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: TextField(
                                            decoration: new InputDecoration(
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: snapshot
                                                  .data["userDailyCarb"]
                                                  .toString(),
                                            ),
                                            controller: textDailyCarb,
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text(
                                              "Daily Protein",
                                              style: TextStyle(
                                                fontFamily:
                                                    'helvetica_neue_light',
                                                fontSize: 20,
                                              ),
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: TextField(
                                            decoration: new InputDecoration(
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: snapshot
                                                  .data["userDailyProtein"]
                                                  .toString(),
                                            ),
                                            controller: textDailyProtein,
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text(
                                              "Daily Fat",
                                              style: TextStyle(
                                                fontFamily:
                                                    'helvetica_neue_light',
                                                fontSize: 20,
                                              ),
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: TextField(
                                            decoration: new InputDecoration(
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: snapshot
                                                  .data["userDailyFat"]
                                                  .toString(),
                                            ),
                                            controller: textDailyFat,
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                )),
                            InkWell(
                              child: GestureDetector(
                                onTap: () {
                                  String userName;
                                  int userDailyCalorie,
                                      userDailyCarb,
                                      userDailyProtein,
                                      userDailyFat;
                                  if (textUserName.text == "")
                                    userName = snapshot.data["userName"];
                                  else
                                    userName = textUserName.text;
                                  if (textDailyCalorie.text == "")
                                    userDailyCalorie =
                                        snapshot.data["userDailyCalorie"];
                                  else
                                    userDailyCalorie =
                                        int.parse(textDailyCalorie.text);
                                  if (textDailyCarb.text == "")
                                    userDailyCarb =
                                        snapshot.data["userDailyCarb"];
                                  else
                                    userDailyCarb =
                                        int.parse(textDailyCarb.text);
                                  if (textDailyProtein.text == "")
                                    userDailyProtein =
                                        snapshot.data["userDailyProtein"];
                                  else
                                    userDailyProtein =
                                        int.parse(textDailyProtein.text);
                                  if (textDailyFat.text == "")
                                    userDailyFat =
                                        snapshot.data["userDailyFat"];
                                  else
                                    userDailyFat = int.parse(textDailyFat.text);
                                  databaseService.updateUserInfo(
                                      userId,
                                      userName,
                                      userDailyCalorie,
                                      userDailyCarb,
                                      userDailyProtein,
                                      userDailyFat);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xff00bfa5),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(32.0),
                                        bottomRight: Radius.circular(32.0)),
                                  ),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } catch (e) {
                        print(e);
                        return Center(
                          child: Text("Error"),
                        );
                      }
                    }
                  }),
            ),
          ),
        );
      });
}

Widget fitFoodText({Color color,double fontSize,FontWeight fontWeight}) {
  return Text("Fit & Food",
      style: GoogleFonts.gruppo(
          textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      )));
}
