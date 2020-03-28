import 'package:flutter/material.dart';
import 'package:minhaempresa/Components/EnterpriseSegments.dart';
import 'package:minhaempresa/ViewModel/EnterpriseViewModel.dart';
import '../Components/AppColor.dart';
import '../Components/SubEnterpriseSegments.dart';
import '../Model/Enterprise.dart';

class EnterpriseView extends StatefulWidget {

  EnterpriseViewModel viewModel;

  EnterpriseView(this.viewModel);

  @override
  _EnterpriseViewState createState() => _EnterpriseViewState();
}

class _EnterpriseViewState extends State<EnterpriseView> {

  var icon = Icon(Icons.star_border);

  @override
  void initState() {
    super.initState();

    icon = widget.viewModel.iconForThisEnterprise;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.enterprise.nickName),
        backgroundColor: HexColor(AppColor.primaryColor),
        actions: <Widget>[
          IconButton(
              icon: icon,
              onPressed:() {
                widget.viewModel.handlerEnterpriseInPreference();

                setState(() {
                  if (icon.icon == Icons.star) {
                    icon = Icon(Icons.star_border);
                  } else {
                    icon = Icon(Icons.star);
                  }
                });
              },
          )
        ],
      ),
      backgroundColor: HexColor(AppColor.primaryColorLight),
      body: Stack(
        children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/wallpaper.png"),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: HexColor(AppColor.primaryColor).withOpacity(0.75)
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
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
                          "Porte da empresa",
                          widget.viewModel.enterprise.port != null ? widget.viewModel.enterprise.port : ""
                      ),
                    ],
                  ),
              ),
            )
        ],
      )
    );
  }
}
