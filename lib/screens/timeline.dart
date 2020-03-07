import 'package:cd/modal/details.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/screens/displaycourse.dart';
import 'package:cd/services/Database.dart';
import 'package:cd/shared/header.dart';
import 'package:cd/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  List data;
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

    // if(hseStream=="Science" && interest=="BPHARMACY"){
    //     //data=Firestore.instance.collection('BPHARMACY').snapshots();
    // }

    return StreamBuilder<UserName>(
        stream: DatabaseServices(uid: user.uid).userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: header(context, titleText: "CBH  ✔", isCenter: false),
              body: StreamBuilder(
                  stream: Firestore.instance
                      .collection('content')
                      .document(interest)
                      .snapshots(),
                  //print an integer every 2secs, 10 times
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    }
                    var userDocument = snapshot.data;
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(children: <Widget>[
                          Card(
                            child: InkWell(
                              onTap: () async {
                                //Navigator.push(context,MaterialPageRoute(builder: (context) => coursepage(text: "commerce")));
                              },
                              child: new Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                width: double.maxFinite,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 0, 20),
                                      child: Center(
                                        child: Text(
                                          userDocument['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                              fontFamily: "Lato",
                                              color: Colors.blue[900]),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15.0),
                                      child: Center(
                                        child: Text(
                                          userDocument['data'],
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: "Lato",
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 1,
                          ),
                          displaycourse()
                        ]);
                        // Text(userDocument['data']);
                      },
                    );
                  }),
            );
          } else {
            return Loading();
          }
        });
  }
}
