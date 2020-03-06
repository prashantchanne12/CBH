import 'dart:async';
import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/services/auth.dart';
import 'package:cd/shared/decoration.dart';
import 'package:cd/shared/header.dart';
import 'package:cd/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final DateTime timestamp = DateTime.now();
bool isLoading = false;
AuthServices _auth = AuthServices();

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final databaseReference = Firestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String _title;
  String _location;
  String address;
  String contact;
  String _description;
  String name;
  String dp;
  int _sec = 0;
  bool ngoOption = false;
  String dropdownValue = 'Feed';
  bool titleValid = true;
  bool descriptionValid = true;
  bool addressValid = true;
  bool contactValid = true;
  bool dateValid = true;
  var now = new DateTime.now();
  List<String> urls = new List();
  String url;

  final format = DateFormat("yyyy-MM-dd HH:mm");
  void _showDialog(String info, String infotitle) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$infotitle"),
          content: new Text('$info uploaded'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Ok",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void uploadtofirebase() async {
    FirebaseUser currentUser = await _auth.getCurrentUser();
    setState(() {
      isLoading = true;
    });
    if (_title.trim().length < 1) {
    } else {
      Timer(Duration(seconds: _sec), () {
        var data = {
          "title": _title,
          "description": _description,
          "date": DateFormat("dd-MM-yyyy").format(now),
          "time": timestamp,
          "location": locationController.text,
          'name': name,
          'userPic': dp
        };
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        if (dropdownValue == 'Feed') {
          databaseReference
              .collection("data")
              .document(fileName)
              .setData(data)
              .whenComplete(() {
            _showDialog("successfully ", "Success");
          }).then((val) {
            titleController.clear();
            descriptionController.clear();
            setState(() {
              isLoading = false;
            });
            databaseReference
                .collection("posts")
                .document(currentUser.uid)
                .collection("usersPosts")
                .document(fileName)
                .setData(data);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final details = Provider.of<List<Details>>(context);
    details.forEach((val) {
      if (val.uid == user.uid) {
        setState(() {
          name = val.name;
          dp = val.profilepic;
        });
      }
    });
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: header(context, titleText: "upload"),
            body: Stack(children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextField(
                          controller: titleController,
                          onChanged: (value) {
                            _title = value.trim();
                            setState(() {
                              _title = _title;
                            });
                          },
                          decoration: textInputDecoration
                              .copyWith(hintText: 'Title')
                              .copyWith(
                                errorText: titleValid
                                    ? null
                                    : "Please enter a title for your blog",
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Scrollbar(
                            child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: new TextField(
                            controller: descriptionController,
                            maxLines: null,
                            onChanged: (value) {
                              _description = value.trim();
                              setState(() {
                                _description = _description;
                              });
                            },
                            decoration: textInputDecoration
                                .copyWith(hintText: 'Description')
                                .copyWith(
                                  errorText: descriptionValid
                                      ? null
                                      : "Description should be of minimum 100 characters",
                                ),
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextField(
                          controller: locationController,
                          onChanged: (value) {
                            _location = value.trim();
                            setState(() {
                              _location = _location;
                            });
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Location'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50.0,
                        width: 300.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.pinkAccent,
                          color: Colors.pink[600],
                          elevation: 5.0,
                          child: InkWell(
                            onTap: uploadtofirebase,
                            child: Center(
                              child: Text(
                                'POST',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Monst',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ))
            ]));
  }
}
