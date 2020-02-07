import 'package:flutter/material.dart';
import 'package:minhaempresa/Components/EnterpriseSegments.dart';
import 'Components/AppColor.dart';
import 'Components/SubEnterpriseSegments.dart';
import 'Model/Enterprise.dart';

class EnterpriseView extends StatefulWidget {

  Enterprise enterprise;

  EnterpriseView(this.enterprise);

  String prepareDescription() {
    if (enterprise.mainActivity.first.title != null) {
      var code = enterprise.mainActivity.first.code;
      var title = enterprise.mainActivity.first.title;
      var text = 'Código: $code \nDescrição: $title';
      return text;
    } else { return ""; }
  }

  @override
  _EnterpriseViewState createState() => _EnterpriseViewState();
}

class _EnterpriseViewState extends State<EnterpriseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.enterprise.nickName),
      ),
      backgroundColor: HexColor(AppColor.primaryColorLight),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                EnterpriseSegments(
                    "Nome",
                    widget.enterprise.name != null ? widget.enterprise.name : "Nome"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                EnterpriseSegments(
                    "CNPJ",
                    widget.enterprise.cnpj != null ? widget.enterprise.cnpj : "CNPJ"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Data de fundação",
                    widget.enterprise.fondationDate != null ? widget.enterprise.fondationDate : "01/01/2000"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Tipo",
                    widget.enterprise.type != null ? widget.enterprise.type : ""
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Atividade Principal",
                    widget.prepareDescription()
                ),
              ],
            ),
          )
      )
    );
  }
}
