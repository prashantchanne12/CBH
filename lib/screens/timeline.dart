import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

final CollectionReference usersRef = Firestore.instance
    .collection('HSC')
    .document()
    .collection('science')
    .document()
    .collection('BPHARMACY');

class _TimeLineState extends State<TimeLine> {
  String name;
  String dp;
  String lastClass;
  String hseStream;
  String interest;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final details = Provider.of<List<Details>>(context);
    // print(details);
    details.forEach((val) {
      if (val.uid == user.uid) {
        setState(() {
          name = val.name;
          dp = val.profilepic;
          lastClass = val.lastClass;
          hseStream = val.selectedStream;
          interest = val.interest;
        });
      }
    });
    return StreamBuilder(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment> comments = [];
            snapshot.data.documents.forEach((doc) {
              comments.add(Comment.fromDocument(doc));
            });
            return ListView(children: comments);
          } else {
            return Loading();
          }
        });
  }
}

class Comment extends StatelessWidget {
  final String data;

  Comment({this.data});
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      data: doc['data'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(data),
//          leading: CircleAvatar(
//            backgroundImage: NetworkImage(avatarUrl),
//          ),
//          subtitle: Text(timeago.format(timestamp.toDate())),
        )
      ],
    );
  }
}
