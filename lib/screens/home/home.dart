import 'package:flutter/material.dart';
import 'package:order_chai/models/chai.dart';
import 'package:order_chai/screens/home/chai_list.dart';
import 'package:order_chai/screens/home/settings_form.dart';
import 'package:order_chai/services/auth.dart';
import 'package:order_chai/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Chai>>.value(
      value: DatabaseService().chais,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(
            'Order Chai',
          ),
          backgroundColor: Colors.green[500],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/chai_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: chaiList()),
      ),
    );
  }
}
