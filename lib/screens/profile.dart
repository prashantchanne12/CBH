import 'dart:io';
import 'dart:async';
import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/screens/uploads.dart';
import 'package:cd/services/Database.dart';
import 'package:cd/services/auth.dart';
import 'package:cd/shared/header.dart';
import 'package:cd/shared/loading.dart';
import 'package:cd/shared/settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthServices _auth = AuthServices();
  File sampleImage;
  Widget build(BuildContext context) {
    String name = '';
    var dp;
    showEditDialog() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Settings();
          });
    }

    final user = Provider.of<User>(context);
    final details = Provider.of<List<Details>>(context);
    // print(details);
    details.forEach((val) {
      if (val.uid == user.uid) {
        setState(() {
          name = val.name;
          dp = val.profilepic;
        });
      }
    });
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
            //updating the data
            var now = DateTime.now();
            UserName user = snapshot.data;
            await DatabaseServices(uid: user.uid).updateUserData(
                name ?? user.name,
                user.email,
                downloadUri,
                DateFormat('dd-mm-yyyy').format(now),
                user.lastStream ?? '',
                user.lastClass,
                user.interest);
          }

          if (snapshot.hasData) {
            return Scaffold(
              appBar: header(context, isLogout: true, titleText: "Profile"),
              body: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(dp), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(60.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7.0,
                                    color: Colors.blue,
                                    spreadRadius: 0)
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: "Oxanium",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,
                              width: 155,
                              child: Material(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.blue,
                                child: GestureDetector(
                                  onTap: () {
                                    showEditDialog();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Edit Name',
                                      style: TextStyle(
                                          fontFamily: 'Mono',
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.5,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 224, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
