import 'package:flutter/material.dart';
import 'Components/AppColor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

typedef VoidNavigate = void  Function();

class _LoginState extends State<Login> {

  TextEditingController _tfController = TextEditingController();

  String _buttonText = "Pressione";

  void _buttonPressent() {
    setState(() {
      print(_tfController.text.toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(AppColor.primaryColorLight),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 38, bottom: 38),
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
                          onPressed: () {
                            this._buttonPressent();
                          },
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        )
      ),
    );
  }
}
