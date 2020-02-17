import 'package:flutter/material.dart';
import 'package:minhaempresa/Components/EnterpriseSegments.dart';
import 'package:minhaempresa/Service/EnterpriseViewModel.dart';
import 'Components/AppColor.dart';
import 'Components/SubEnterpriseSegments.dart';
import 'Model/Enterprise.dart';

class EnterpriseView extends StatefulWidget {

  EnterpriseViewModel viewModel;

  EnterpriseView(this.viewModel);

  @override
  _EnterpriseViewState createState() => _EnterpriseViewState();
}

class _EnterpriseViewState extends State<EnterpriseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.enterprise.nickName),
      ),
      backgroundColor: HexColor(AppColor.primaryColorLight),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                EnterpriseSegments(
                    "Nome",
                    widget.viewModel.enterprise.name != null ? widget.viewModel.enterprise.name : "Nome"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                EnterpriseSegments(
                    "CNPJ",
                    widget.viewModel.enterprise.cnpj != null ? widget.viewModel.enterprise.cnpj : "CNPJ"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Data de fundação",
                    widget.viewModel.enterprise.fondationDate != null ? widget.viewModel.enterprise.fondationDate : "01/01/2000"
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Tipo",
                    widget.viewModel.enterprise.type != null ? widget.viewModel.enterprise.type : ""
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                SubEnterpriseSegments(
                    "Atividade Principal",
                    widget.viewModel.prepareDescription()
                ),
              ],
            ),
          )
      )
    );
  }
}
