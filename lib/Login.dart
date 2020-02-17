import 'package:flutter/material.dart';
import 'package:minhaempresa/EnterpriseView.dart';
import 'package:minhaempresa/Service/EnterpriseViewModel.dart';
import 'package:minhaempresa/Service/WebService.dart';
import 'Components/AppColor.dart';
import 'Model/Enterprise.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _tfController = TextEditingController();
  EnterpriseViewModel viewModel = EnterpriseViewModel();

  Future <Enterprise> enterprise;
  String _buttonText = "Pressione";

  @override
  void initState() {
    super.initState();
  }

  void _buttonPressent() {
    viewModel.fetchEnterprise(_tfController.text.toString());


    viewModel.enterpriseFuture.then((value) => {
      viewModel.enterprise = value,

//      Navigator.push(context, MaterialPageRoute(builder: (context) => EnterpriseView(viewModel)))
    this.showAlertDialog1(context),
    });
  }


  showAlertDialog1(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ah não"),
      content: Text("Parece que houve algum problema, tente novamente."),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(AppColor.primaryColorLight),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 38, bottom: 38),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Informe seu CNPJ e obtenha os dados da sua empresa",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child:
                              TextField(
                                style: TextStyle(
                                    color: Colors.white
                                ),
                                decoration: InputDecoration(
                                  labelText: "00.000.000/000-11",
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                maxLength: 14,
                                maxLengthEnforced: true,
                                controller: _tfController,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: 288,
                  height: 48,
                  child: RaisedButton(
                    child: Text(
                      "Consultar",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48/2),
                    ),
                    color: HexColor(AppColor.primaryColor),
                    onPressed: _buttonPressent,
                  ),
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}
