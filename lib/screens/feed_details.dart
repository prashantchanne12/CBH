import 'package:flutter/material.dart';

class FeedDetails extends StatefulWidget {
  @override
  _FeedDetailsState createState() => _FeedDetailsState();
  final String name;
  final String title;
  final String description;
  final String date;
  final String location;
  final String userPic;
  final bool me;

  FeedDetails(
      {Key key,
      this.me,
      this.name,
      this.title,
      this.description,
      this.date,
      this.location,
      this.userPic});
}

class _FeedDetailsState extends State<FeedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: null,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.blue[700],
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                widget.userPic,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.date,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
