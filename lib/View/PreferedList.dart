import 'package:flutter/material.dart';
import 'package:minhaempresa/Components/AppColor.dart';

class PreferedList extends StatefulWidget {
  @override
  _PreferedListState createState() => _PreferedListState();
}

class _PreferedListState extends State<PreferedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      backgroundColor: HexColor(AppColor.primaryColorLight),
    );
  }
}
