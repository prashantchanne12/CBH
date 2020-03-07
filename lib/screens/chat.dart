import 'package:cd/screens/chat_categories.dart';
import 'package:cd/screens/chat_screen.dart';
import 'package:cd/shared/header.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          isCenter: true, isLogout: false, titleText: "Chats  📱"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, bottom: 50.0, left: 50.0, right: 50.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Click Here To ',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Join QnA Session With Expert',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 50.0,
                      width: 80.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue[600],
                        color: Colors.blue[800],
                        elevation: 5.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatCategories(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Go !',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lato',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
