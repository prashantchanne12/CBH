import 'package:flutter/material.dart';
import 'user_test_questions.dart';

class UserTestBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Inspect a roof for leaks ?', 't', true),
    Question('Repair an air conditioning system ?', 't', true),
    Question('Install kitchen cabinets ?', 't', true),
    Question('Use precision machines to build custom metal parts ?', 't', true),
    Question('Install an alarm system in a building ?', 't', true),
    Question('Install a hardwood floor ?', 't', true),

    // social
    Question('Teach adults to read ?', 's', true),
    Question('Counsel a person recovering from drug addiction ?', 's', true),
    Question('Counsel a person with depression ?', 's', true),
    Question('Teach social skills to disabled children ?', 's', true),

    //business
    Question('Keep payroll records ?', 'b', true),
    Question('Review financial records for accuracy ?', 'b', true),
    Question('Plan a marketing strategy for a new company ?', 'b', true),
    Question('Track monthly expenses for a company ?', 'b', true),
    Question('Coordinate a business conference ?', 'b', true),
  ];

  void getNextQuestions() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  String getQuestionType() {
    return _questionBank[_questionNumber].questionType;
  }
}
