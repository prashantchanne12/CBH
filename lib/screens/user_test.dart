import 'package:cd/screens/chart.dart';
import 'package:cd/screens/user_test_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TestPage(),
        ),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

int t = 0, s = 0, b = 0;

class _TestPageState extends State<TestPage> {
  UserTestBrain utb = UserTestBrain();

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (utb.isFinished() == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Chart(
              t: t,
              b: b,
              s: s,
            ),
          ),
        );
      } else {
        if (utb.getQuestionAnswer() == userAnswer &&
            utb.getQuestionType() == 't') {
          t = t + 1;
        }

        if (utb.getQuestionAnswer() == userAnswer &&
            utb.getQuestionType() == 's') {
          s = s + 1;
        }

        if (utb.getQuestionAnswer() == userAnswer &&
            utb.getQuestionType() == 'b') {
          b = b + 1;
        }
        utb.getNextQuestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                utb.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue[700],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                });
              },
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'No',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
