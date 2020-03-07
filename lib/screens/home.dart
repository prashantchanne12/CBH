import 'package:cd/modal/details.dart';
import 'package:cd/screens/chat.dart';
import 'package:cd/screens/feed.dart';
import 'package:cd/screens/profile.dart';
import 'package:cd/screens/timeline.dart';
import 'package:cd/screens/uploads.dart';
import 'package:cd/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Details>>.value(
      value: DatabaseServices().details,
      child: Scaffold(
        body: PageView(
          children: <Widget>[TimeLine(), Feed(), Chat(), Profile()],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up)),
            //BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.chat_bubble_outline,
              size: 35.0,
            )),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
//          BottomNavigationBarItem(icon: Icon(Icons.search)),
          ],
        ),
      ),
    );
  }
}
