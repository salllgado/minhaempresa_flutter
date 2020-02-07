import 'package:flutter/material.dart';

class SubEnterpriseSegments extends StatelessWidget {

  String sectionTitle;
  String textToBeDisplayed;

  SubEnterpriseSegments(this.sectionTitle, this.textToBeDisplayed);

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
                  fontSize: 22,
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
