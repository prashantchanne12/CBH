import 'dart:io';
import 'dart:async';
import 'package:cd/modal/user.dart';
import 'package:cd/services/Database.dart';
import 'package:cd/shared/decoration.dart';
import 'package:cd/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String selectedStream;
  String lastClass;
  String interest;
  List<String> _qualification = ['SSC', 'HSC', 'UNDER GRADUATE', 'GRADUATE'];
  List<String> _stream = ['Arts', 'Science', 'Commerce'];
  String _selectedClass;
  String _interestField;
  String _selectedStream;
  bool HSC = false;
  String dp;
  @override
  Widget build(BuildContext context) {
    List<String> _interest = [];
    if (_selectedClass == 'SSC') {
      setState(() {
        _interest = ['Arts', 'Science', 'Commerce', 'Diploma', 'IT', 'Others'];
        HSC = false;
      });
    }
    if (_selectedClass == 'HSC') {
      setState(() {
        HSC = true;
      });
      if (_selectedStream == 'Arts') {
        _interest = ['B.a', 'BFA', ' Hotel Management', 'Others'];
      }
      if (_selectedStream == 'Science') {
        _interest = [
          'IIT',
          'B.Pharmacy',
          'NEET',
          'Other',
        ];
      }
      if (_selectedStream == 'Commerce') {
        _interest = ['CA', 'Bcom', 'BMS', 'BBA', 'Others'];
      }
    }
    if (_selectedClass == 'UNDER GRADUATE') {
      setState(() {
        _interest = ['MBA', 'M.tech/M.e', 'Others', 'M.a', 'Others'];
        HSC = false;
      });
    }
    if (_selectedClass == 'GRADUATE') {
      setState(() {
        _interest = ['Phd', 'Start-up'];
        HSC = false;
      });
    }
    final user = Provider.of<User>(context);
    File sampleImage;
    return StreamBuilder<UserName>(
        stream: DatabaseServices(uid: user.uid).userName,
        builder: (context, snapshot) {
          Future getImage() async {
            var tempImage =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              sampleImage = tempImage;
            });
            String nameofPhoto = basename(sampleImage.path);
            final StorageReference firebaseStorageRef = await FirebaseStorage
                .instance
                .ref()
                .child('profilepics/${nameofPhoto}.jpg');
            final StorageUploadTask task =
                await firebaseStorageRef.putFile(sampleImage);

            StorageTaskSnapshot taskSnapshot = await task.onComplete;
            String downloadUri = await taskSnapshot.ref.getDownloadURL();
            dp = downloadUri;
            //updating the data
            var now = DateTime.now();
            UserName user = snapshot.data;
            await DatabaseServices(uid: user.uid).updateUserData(
                name ?? user.name,
                user.email,
                downloadUri,
                DateFormat('dd-mm-yyyy').format(now),
                _selectedStream ?? user.lastStream,
                _selectedClass ?? user.lastClass,
                _interest ?? user.interest);
          }

          if (snapshot.hasData) {
            UserName user = snapshot.data;
            return Container(
                height: MediaQuery.of(context).size.height - 200,
                color: Colors.blue.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Update your profile',
                            style: TextStyle(
                                fontSize: 18, color: Colors.pink[900]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            onPressed: getImage,
                            child: Text('Change DP'),
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: user.name,
                            decoration: textInputDecoration,
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButton(
                            hint: Text('Please choose Last Qualification '),
                            value: _selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedClass = newValue;
                              });
                            },
                            items: _qualification.map((qualification) {
                              return DropdownMenuItem(
                                child: new Text(qualification),
                                value: qualification,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          HSC
                              ? Column(
                                  children: <Widget>[
                                    DropdownButton(
                                      hint: Text('Please choose your stream '),
                                      value: _selectedStream,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedStream = newValue;
                                        });
                                      },
                                      items: _stream.map((qualification) {
                                        return DropdownMenuItem(
                                          child: new Text(qualification),
                                          value: qualification,
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          DropdownButton(
                            hint: Text('Please choose your field of interest'),
                            value: _interestField,
                            onChanged: (newValue) {
                              setState(() {
                                _interestField = newValue;
                              });
                            },
                            items: _interest.map((interest) {
                              return DropdownMenuItem(
                                child: new Text(interest),
                                value: interest,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseServices(uid: user.uid)
                                    .updateUserData(
                                        name ?? user.name,
                                        user.email,
                                        dp ?? user.profilepic,
                                        user.date,
                                        _selectedStream ?? user.lastStream,
                                        _selectedClass ?? user.lastClass,
                                        _interestField ?? user.interest);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.pink[400],
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
