import 'package:flutter/material.dart';
import 'package:order_chai/services/auth.dart';
import 'package:order_chai/shared/constants.dart';
import 'package:order_chai/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Order Chai'),
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: Text(
                    'Register',
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email Address'),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      validator: (val) => val.length < 8
                          ? 'Enter a password 8+ characters long'
                          : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          } else {}
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
