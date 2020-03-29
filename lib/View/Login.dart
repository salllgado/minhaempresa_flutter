import 'package:flutter/material.dart';
import 'package:minhaempresa/Service/PreferencesService.dart';
import 'package:minhaempresa/View/EnterpriseView.dart';
import 'package:minhaempresa/View/PreferedList.dart';
import 'package:minhaempresa/ViewModel/EnterpriseViewModel.dart';
import 'package:minhaempresa/Service/WebService.dart';
import '../Components/AppColor.dart';
import '../Model/Enterprise.dart';

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

    viewModel.initDatabase();

    var pref = PreferencesService();

    var userPreferedEnterprises = pref.fetchEntepriseFromUserPreference();
    userPreferedEnterprises.then((value) => {
      if (value.first != null) {
        viewModel.fetchEnterprise(value.first),

        viewModel.enterpriseFuture.then((value) => {
          if (value != null && value.cnpj != null)  { 
            viewModel.enterprise = value,
            viewModel.saveDataOnDatabase(value),
            viewModel.handlerFavoriteIcon(),
            Navigator.push(context, MaterialPageRoute(builder: (context) => EnterpriseView(viewModel)))
          } else {
            showAlertDialog1(context)
          }
        }),
      }
    });
  }

  void _buttonPressent() {
    viewModel.fetchEnterprise(_tfController.text.toString());
    viewModel.enterpriseFuture.then((value) => {
      if (value != null && value.cnpj != null)  {  
        viewModel.enterprise = value,
        viewModel.saveDataOnDatabase(value),
        viewModel.handlerFavoriteIcon(),
        Navigator.push(context, MaterialPageRoute(builder: (context) => EnterpriseView(viewModel)))
      } else {
        showAlertDialog1(context)
      }
    });
  }

  void _buttonFavoriteAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PreferedList()));
  }

  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ops"),
      content: Text("Parece que houve algum problema, confira o cnpj inserido e tente novamente em alguns segundos."),
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

  Widget handlerFavoritebutton() {
    var enable = false;
    if (enable) {
      return Padding(
        padding: EdgeInsets.only(top: 16),
        child: SizedBox(
          width: 288,
          height: 48,
          child: RaisedButton(
            child: Text(
              "Favoritos",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48/2),
            ),
            color: HexColor(AppColor.primary),
            onPressed: _buttonFavoriteAction,
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.all(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Sua empresa",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                                Text(
                                  "Informe seu CNPJ e obtenha os dados da sua empresa",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
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
                                      labelText: "00.000.000/0001-10",
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
                  handlerFavoritebutton(),
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
        ],
      ),
    );
  }
}
