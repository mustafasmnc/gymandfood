import 'package:flutter/material.dart';

Widget submitButton({BuildContext context, String text, buttonWith}) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    width: buttonWith != null ? buttonWith : MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}