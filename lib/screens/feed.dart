import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/screens/feed_details.dart';
import 'package:cd/services/Database.dart';
import 'package:cd/shared/header.dart';
import 'package:cd/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  String name2;
  String dp;
  String receiver;
  String sender;
  @override
  Widget build(BuildContext context) {
    Firestore _fireStore = Firestore.instance;
    final user = Provider.of<User>(context);
    final details = Provider.of<List<Details>>(context);
    details.forEach((val) {
      if (val.uid == user.uid) {
        setState(() {
          name2 = val.name;
        });
      }
    });
    return StreamBuilder<UserName>(
        stream: DatabaseServices(uid: user.uid).userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(55.0),
                child: AppBar(
                  leading: null,
                  elevation: 2.0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.blue[700],
                  centerTitle: true,
                  title: Text(
                    'Trending ⚡',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'Lato',
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _fireStore
                            .collection('data')
                            .orderBy('date')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<DocumentSnapshot> docs = snapshot.data.documents;
                          List<Widget> message = docs
                              .map((docs) => Message(
                                  name: docs.data['name'],
                                  title: docs.data['title'],
                                  description: docs.data['description'],
                                  date: docs.data['date'],
                                  userPic: docs.data['userPic'],
                                  location: docs.data['location'],
                                  me: name2 == docs.data['name']
                                      ? true
                                      : false))
                              .toList();
                          return ListView(
                            controller: scrollController,
                            children: message,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class Message extends StatelessWidget {
  final String name;
  final String title;
  final String description;
  final String date;
  final String location;
  final String userPic;
  final bool me;

  const Message(
      {Key key,
      this.me,
      this.name,
      this.title,
      this.description,
      this.date,
      this.location,
      this.userPic});
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          // goto next page
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedDetails(
                            me: me,
                            name: name,
                            title: title,
                            description: description,
                            date: date,
                            location: location,
                            userPic: userPic,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              margin: EdgeInsets.all(16.0),
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.network(
                                    userPic,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(2.0)),
                                  Text(
                                    description.substring(0, 80) + '...',
                                    style: new TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.black,
                                        fontSize: 16.0),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.pink[40],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
