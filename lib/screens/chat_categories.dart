import 'package:cd/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen('technicalChats'),
                    ),
                  );
                },
                child: Category(
                  name: 'Technical',
                  logo: '💻',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen('educationalChats'),
                    ),
                  );
                },
                child: Category(
                  name: 'Educational',
                  logo: '💡',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen('sportsChats'),
                    ),
                  );
                },
                child: Category(
                  name: 'Sports',
                  logo: '⚽',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen('civilChats'),
                    ),
                  );
                },
                child: Category(
                  name: 'Civil Service',
                  logo: '📜',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen('artsChat'),
                    ),
                  );
                },
                child: Category(
                  name: 'Art',
                  logo: '🎤',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final name;
  final logo;
  Category({this.name, this.logo});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
          name + '  ' + logo,
          style: TextStyle(
              fontSize: 22.0, fontFamily: 'Lato', color: Colors.blue[700]),
        ),
      ),
    );
  }
}
