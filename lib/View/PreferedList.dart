import 'package:flutter/material.dart';
import 'package:minhaempresa/Components/AppColor.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'package:minhaempresa/ViewModel/PreferedViewModel.dart';

class PreferedList extends StatefulWidget {
  PreferedViewModel viewModel;
  PreferedList(this.viewModel);

  @override
  _PreferedListState createState() => _PreferedListState();
}

class _PreferedListState extends State<PreferedList> {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
        appBar: AppBar(
          title: Text("Favoritos"),
        ),
        backgroundColor: HexColor(AppColor.primaryColorLight),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
              future: widget.viewModel.fetchEnterprises(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Expanded(child: Text("Nenhum item"));
                    } else {
                      List<Enterprise> enterprises =
                          snapshot.data as List<Enterprise>;

                      return ListView.builder(
                          itemCount: enterprises.length,
                          itemBuilder: (context, index) {
                            Enterprise _enterprise = enterprises[index];
                            return Container(
                              width: c_width,
                              padding: EdgeInsets.all(4),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Razão Social ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      Flexible(
                                          child: Text(_enterprise.name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 4, bottom: 4),
                                      child: Row(
                                        children: [
                                          Text("CNPJ ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                          Text(_enterprise.cnpj,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0)),
                                        ],
                                      ))
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            );
                          });
                    }
                    break;
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text("no data");
                    break;
                  case ConnectionState.active:
                    return Text("deu bom ?");
                    break;
                }
              },
            )));
  }
}
