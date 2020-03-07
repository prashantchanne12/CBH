import 'package:cd/services/auth.dart';
import 'package:cd/shared/decoration.dart';
import 'package:cd/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String password;
  String email;
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            child: Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monst',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
                            child: Text(
                              'There',
                              style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monst',
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(250.0, 180.0, 0.0, 0.0),
                            child: Text(
                              '.',
                              style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff003CAA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                            height: 50.0,
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
                                    setState(() => loading = true);

                                    dynamic result = await _auth
                                        .userLoginWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'invalid credentials';
                                      });
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                  } catch (e) {
                                    loading = false;
                                    print(e);
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'LOG IN',
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
                          Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'New to CBH',
                                  style: TextStyle(
                                    fontFamily: 'Monst',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.toggleView();
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Color(0xff003CAA),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
