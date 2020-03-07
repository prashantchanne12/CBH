import 'package:cd/services/auth.dart';
import 'package:cd/shared/decoration.dart';
import 'package:cd/shared/loading.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error = '';
  String email;
  String displayName;
  String password;
  bool loading = false;
  List<String> _qualification = ['SSC', 'HSC', 'UNDER GRADUATE', 'GRADUATE'];
  List<String> _stream = ['Arts', 'Science', 'Commerce'];
  String _selectedClass;
  String _interestField;
  String _selectedStream;
  bool HSC = false;
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<String> _interest = [];
    if (_selectedClass == 'SSC') {
      setState(() {
        _interest = ['Arts', 'Science', 'Commerce', 'Diploma', 'IT', 'Others'];
        HSC = false;
      });
    }
    if (_selectedClass == 'HSC') {
      setState(() {
        HSC = true;
      });
      if (_selectedStream == 'Arts') {
        _interest = ['B.a', 'BFA', ' Hotel Management', 'Others'];
      }
      if (_selectedStream == 'Science') {
        _interest = [
          'IIT',
          'B.Pharmacy',
          'NEET',
          'Other',
        ];
      }
      if (_selectedStream == 'Commerce') {
        _interest = ['CA', 'Bcom', 'BMS', 'BBA', 'Others'];
      }
    }
    if (_selectedClass == 'UNDER GRADUATE') {
      setState(() {
        _interest = ['MBA', 'M.tec', 'M.e', 'Others', 'M.a', 'Others'];
        HSC = false;
      });
    }
    if (_selectedClass == 'GRADUATE') {
      setState(() {
        _interest = ['Phd', 'Start-up'];
        HSC = false;
      });
    }
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                              child: Text(
                                'Sign',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monst',
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                              child: Text(
                                'Up',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monst',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                email = value.trim();
                              },
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                  fontFamily: 'Monst',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                hintText: 'Email ID',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff003CAA),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              onChanged: (value) {
                                password = value.trim();
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                  fontFamily: 'Monst',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                hintText: 'Password',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff003CAA),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            TextField(
                              onChanged: (value) {
                                displayName = value.trim();
                              },
                              decoration: InputDecoration(
                                labelText: 'NAME',
                                labelStyle: TextStyle(
                                  fontFamily: 'Monst',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                hintText: 'Name',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff003CAA),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: Text('Please choose Last Qualification '),
                              value: _selectedClass,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedClass = newValue;
                                });
                              },
                              items: _qualification.map((qualification) {
                                return DropdownMenuItem(
                                  child: new Text(qualification),
                                  value: qualification,
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            HSC
                                ? Column(
                                    children: <Widget>[
                                      DropdownButton(
                                        isExpanded: true,
                                        hint:
                                            Text('Please choose your stream '),
                                        value: _selectedStream,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedStream = newValue;
                                          });
                                        },
                                        items: _stream.map((qualification) {
                                          return DropdownMenuItem(
                                            child: new Text(qualification),
                                            value: qualification,
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            DropdownButton(
                              isExpanded: true,
                              hint:
                                  Text('Please choose your field of interest'),
                              value: _interestField,
                              onChanged: (newValue) {
                                setState(() {
                                  _interestField = newValue;
                                });
                              },
                              items: _interest.map((interest) {
                                return DropdownMenuItem(
                                  child: new Text(interest),
                                  value: interest,
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              height: 50.0,
                              width: 350.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Color(0xff005AFE),
                                color: Color(0xff003CAA),
                                elevation: 5.0,
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .userRegistrationwithEmailPasssword(
                                              email,
                                              password,
                                              displayName,
                                              _selectedStream ?? '',
                                              _selectedClass,
                                              _interestField);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error =
                                              'invalid email format or already used email';
                                        });
                                      }
                                    } catch (e) {
                                      print(e);
                                      setState(() {
                                        loading = true;
                                      });
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Monst',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Center(
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Already Registered?',
                                  style: TextStyle(
                                    fontFamily: 'Monst',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.toggleView();
                                    },
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Color(0xff003CAA),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
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
                ),
              ),
            ),
          );
  }
}
