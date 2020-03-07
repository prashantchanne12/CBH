import 'package:flutter/material.dart';

class Question {
  String questionText;
  String questionType;
  bool questionAnswer;

  Question(String q, String t, bool a) {
    questionText = q;
    questionType = t;
    questionAnswer = a;
  }
}
