import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/services/Database.dart';
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
              appBar: AppBar(
                title: Text('Group 1'),
                backgroundColor: Colors.purpleAccent,
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
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(userPic)),
              title: Text(title),
              subtitle: Text(description),
            ),
          )
//          Material(
//            color: me ? Colors.white : Colors.pink,
//            borderRadius: BorderRadius.circular(10),
//            elevation: 6,
//            child: Container(
//              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//              child: Text(description),
//            ),
//          ),
        ],
      ),
    );
  }
}
