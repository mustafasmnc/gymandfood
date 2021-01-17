import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CalorieProgress extends StatelessWidget {
  DatabaseService databaseService = DatabaseService();
  final double height, width;
  final int userDailyCalorie;
  final String userId;

  CalorieProgress(
      {this.height,
      this.width,
      this.userDailyCalorie,
      this.userId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseService.getDailyFoods(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var ds = snapshot.data.documents;
            int sum = 0;
            for (int i = 0; i < ds.length; i++) sum += (ds[i]['foodCal']);
            return CustomPaint(
              child: Container(
                height: height,
                width: width,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: sum.toString(),
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
              painter: _ProgressPainter(
                  sum: sum, userDailyCalorie: userDailyCalorie),
            );
          }
        });
  }
}

class _ProgressPainter extends CustomPainter {
  final int sum, userDailyCalorie;

  _ProgressPainter({this.userDailyCalorie, this.sum});
  @override
  void paint(Canvas canvas, Size size) {
    double progress = (sum / userDailyCalorie);
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
