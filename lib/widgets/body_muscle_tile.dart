import 'package:flutter/material.dart';

class BodyMuscleTile extends StatelessWidget {
  final String bodyMuscleId;
  final String bodyMuscleImage;
  final String bodyMuscleName;
  final String bodyMuscleDesc;

  const BodyMuscleTile(
      {Key key,
      this.bodyMuscleId,
      this.bodyMuscleImage,
      this.bodyMuscleName,
      this.bodyMuscleDesc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: [
          Container(
            height: 124,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 46.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  bodyMuscleName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(bodyMuscleDesc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Container(
            height: 90,
            margin: EdgeInsets.symmetric(vertical: 16),
            alignment: FractionalOffset.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image(
                image: AssetImage(
                  bodyMuscleImage,
                ),
                height: 90,
                width: 90,
              ),
            ),
          )
        ],
      ),
    );
  }
}
