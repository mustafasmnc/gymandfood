import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String bodyMuscleId;
  final String bodyMuscleImage;
  final String bodyMuscleName;
  final String bodyMuscleDesc;

  const ExerciseTile(
      {Key key,
      this.bodyMuscleId,
      this.bodyMuscleImage,
      this.bodyMuscleName,
      this.bodyMuscleDesc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            )
          ]),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                bodyMuscleImage,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 15),
            Text(
              bodyMuscleName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 7),
            Text(bodyMuscleDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                )),
          ],
        ),
      ),
    );
  }
}
