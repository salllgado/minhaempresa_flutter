import 'package:flutter/material.dart';

class EnterpriseSegments extends StatelessWidget {

  String sectionTitle;
  String textToBeDisplayed;

  EnterpriseSegments(this.sectionTitle, this.textToBeDisplayed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sectionTitle,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          Text(
            textToBeDisplayed,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      )
    );
  }
}
