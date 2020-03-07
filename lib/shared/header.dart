import 'package:cd/services/auth.dart';
import 'package:flutter/material.dart';

final AuthServices _auth = AuthServices();

header(
  context, {
  bool isAppTitle = false,
  String titleText,
  removeback = false,
  isLogout = false,
  isCenter = true,
}) {
  return AppBar(
    title: Text(
      isAppTitle ? 'Career Buddy' : titleText,
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: isAppTitle ? 30 : 22,
          color: Colors.white),
    ),
    actions: <Widget>[
      isLogout
          ? IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                _auth.signOut();
              },
            )
          : Text(''),
    ],
    automaticallyImplyLeading: removeback ? false : true,
    centerTitle: isCenter ? true : false,
    backgroundColor: Colors.blue[700],
  );
}
