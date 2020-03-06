import 'package:cd/services/auth.dart';
import 'package:flutter/material.dart';

final AuthServices _auth = AuthServices();

header(context,
    {bool isAppTitle = false,
    String titleText,
    removeback = false,
    isLogout = false}) {
  return AppBar(
    title: Text(
      isAppTitle ? 'Career Buddy' : titleText,
      style: TextStyle(
          fontFamily: 'Oxanium',
          fontSize: isAppTitle ? 35 : 22,
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
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
