import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detailsofcoursepage.dart';

class coursepage extends StatefulWidget {
  final String text;
  const coursepage({Key key, this.text}) : super(key: key);

  @override
  _coursepageState createState() => _coursepageState();
}

class _coursepageState extends State<coursepage> {
  List data;
  String str = '';

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    try {
      print(widget.text);
      if (widget.text == "commerce") {
        str =
            'https://firebasestorage.googleapis.com/v0/b/carrbuddy.appspot.com/o/commercedata.json?alt=media&token=fc66ee94-36c6-42ef-93af-53bec78a3a74';
      } else if (widget.text == "science") {
        str =
            'https://firebasestorage.googleapis.com/v0/b/carrbuddy.appspot.com/o/science.json?alt=media&token=0de509ac-cb99-41d3-b77e-4704aa6fec52';
      } else if (widget.text == "Arts") {
        str =
            'https://firebasestorage.googleapis.com/v0/b/carrbuddy.appspot.com/o/arts.json?alt=media&token=685d2dce-a8be-40c6-b9cf-3466fe603f5e';
      } else {}
      var response = await http.get(str);

      setState(() {
        var converted = json.decode(response.body);

        data = converted["${widget.text}"];

        print(data);
      });
    } catch (e) {}
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CBH  ✔",
            style: TextStyle(fontFamily: 'Lato'),
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.blue[700],
        ),
        body: data == null
            ? Container(
                child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              ))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailsofcoursepage(
                                    index: index, data: data)));
                      },
                      child: new Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 90,
                        width: double.maxFinite,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                          child: Text(
                            '▶  ' + data[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                              color: Colors.blue[700],
                              fontFamily: 'Lato',
                            ),
                          ),
                        ),
                      ),
                    ),
                    elevation: 0.5,
                  );
                }));
  }
}
