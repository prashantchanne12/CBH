import 'package:flutter/material.dart';

import 'coursepage.dart';

class displaycourse extends StatefulWidget {
  @override
  _displaycourseState createState() => _displaycourseState();
}

class _displaycourseState extends State<displaycourse> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Column(
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => coursepage(
                                    text: "Commerce",
                                  )));
                    },
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 85,
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                        child: Text(
                          "Commerce",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.blue[900]),
                        ),
                      ),
                    ),
                  ),
                  elevation: 1,
                ),
                Card(
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  coursepage(text: "science")));
                    },
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 85,
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                        child: Text(
                          "Science",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.blue[900]),
                        ),
                      ),
                    ),
                  ),
                  elevation: 1,
                ),
                Card(
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => coursepage(text: "Arts")));
                    },
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 85,
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                        child: Text(
                          "Arts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.blue[900]),
                        ),
                      ),
                    ),
                  ),
                  elevation: 1,
                ),
              ],
            ));
  }
}
