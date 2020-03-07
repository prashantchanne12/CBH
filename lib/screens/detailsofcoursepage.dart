import 'package:flutter/material.dart';

class detailsofcoursepage extends StatefulWidget {
  final int index;
  final List data;

  const detailsofcoursepage({Key key, this.index, this.data}) : super(key: key);
  @override
  _detailsofcoursepageState createState() => _detailsofcoursepageState();
}

class _detailsofcoursepageState extends State<detailsofcoursepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text(
            "Details of Course",
            style: TextStyle(
              fontFamily: 'Lato',
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Career Opportunities in ${widget.data[widget.index]['name']} :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    widget.data[widget.index]['data'],
                    style: TextStyle(
                      fontSize: 18.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.blue[700],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Educational Path to Pursue ${widget.data[widget.index]['name']} :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  widget.data[widget.index]['educitional path'],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.blue[700],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Some Top Colleges for ${widget.data[widget.index]['name']} :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    widget.data[widget.index]['top colleges'],
                    style: TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
