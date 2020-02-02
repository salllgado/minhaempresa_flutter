import 'package:flutter/material.dart';
import 'Components/AppColor.dart';
import 'Model/Enterprise.dart';

class EnterpriseView extends StatefulWidget {

  Enterprise enterprise;

  EnterpriseView(this.enterprise);

  @override
  _EnterpriseViewState createState() => _EnterpriseViewState();
}

class _EnterpriseViewState extends State<EnterpriseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.enterprise.cnpj),
      ),
      backgroundColor: HexColor(AppColor.primaryColorLight),
    );
  }
}
