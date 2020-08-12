import 'package:flutter/material.dart';
import 'package:order_chai/models/chai.dart';
import 'package:order_chai/screens/home/chai_tile.dart';
import 'package:provider/provider.dart';

class chaiList extends StatefulWidget {
  @override
  _chaiListState createState() => _chaiListState();
}

class _chaiListState extends State<chaiList> {
  @override
  Widget build(BuildContext context) {
    final chais = Provider.of<List<Chai>>(context) ?? [];
    return ListView.builder(
      itemCount: chais.length,
      itemBuilder: (context, index) {
        return chaiTile(chai: chais[index]);
      },
    );
  }
}
