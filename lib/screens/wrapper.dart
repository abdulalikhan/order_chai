import 'package:flutter/material.dart';
import 'package:order_chai/models/user.dart';
import 'package:order_chai/screens/authenticate/authenticate.dart';
import 'package:order_chai/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
