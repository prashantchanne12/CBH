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
        _interest = ['MBA', 'M.tech/M.e', 'Others', 'M.a', 'Others'];
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
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Signup to Career Buddy'),
              backgroundColor: Colors.blue,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Login'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'please enter email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) =>
                          val.length < 6 ? 'password is quite small' : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Your Name'),
                      validator: (val) =>
                          val.isEmpty ? 'please enter name' : null,
                      onChanged: (val) {
                        setState(() {
                          displayName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
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
                      height: 20,
                    ),
                    HSC
                        ? Column(
                            children: <Widget>[
                              DropdownButton(
                                hint: Text('Please choose your stream '),
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
                      hint: Text('Please choose your field of interest'),
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
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.userRegistrationwithEmailPasssword(
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
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
