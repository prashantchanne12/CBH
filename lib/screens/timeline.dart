import 'package:cd/shared/header.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 2),
        child: FlatButton(
          onPressed: () => {},
          child: Container(
            alignment: Alignment.center,
            width: 220,
            height: 27,
            child: Text(
              "Nishant",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                  color: Colors.blue,
                )),
          ),
        ),
      ),
    );
  }
}
