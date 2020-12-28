import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Service/WebService.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'dart:async';

class EnterpriseWorker {
  final tableName = "enterprise";

  Future<Enterprise> fetchEnterprise(String cnpj) async {
    // handler if contains file with cnpj else create one from webservice response.
    return WebService().fetchEntepriseData(cnpj);
  }

  getDataFromDatabase() async {
    final pathToDB = await getDatabasesPath();
    final completePath = join(pathToDB, "banco.db");

    var db = await openDatabase(completePath, version: 1,
        onCreate: (db, dbNewestVersion) {
      String query =
          "CREATE TABLE enterprise (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, cnpj VARCHAR, nickName VARCHAR, fondationDate VARCHAR, type VARCHAR, port VARCHAR, nature VARCHAR, porte VARCHAR)";
      db.execute(query);
    });

    return db;
  }

  void saveDataInDatabase(Enterprise enterprise) async {
    Database db = await getDataFromDatabase();

    Map<String, dynamic> values = {
      "name": enterprise.name,
      "cnpj": enterprise.cnpj,
      "nickName": enterprise.nickName,
      "fondationDate": enterprise.fondationDate,
      "type": enterprise.type,
      "port": enterprise.port,
      "nature": enterprise.nature
    };

    db.insert(tableName, values);
  }

  Future<Enterprise> fetchDataFromDatabase(String cnpj) async {
    Database db = await getDataFromDatabase();
    var newCNPJ = cnpj.replaceAll(new RegExp(r'[^\w\s]+'), '');
    String query = "SELECT * FROM enterprise WHERE cnpj = $newCNPJ";
    List itens = await db.rawQuery(query);
    if (itens.isEmpty == false) {
      var iten = itens.first;

      if (iten == null) {
        return fetchEnterprise(newCNPJ);
      } else {
        return Enterprise(
            name: iten["name"],
            cnpj: iten["cnpj"],
            nickName: iten["nickName"],
            fondationDate: iten["fondationDate"],
            type: iten["type"],
            port: iten["port"],
            nature: iten["nature"],
            porte: iten["porte"]);
      }
    } else {
      return fetchEnterprise(newCNPJ);
    }
  }

  Future<List<Enterprise>> fetchAllEnterprisesFromDatabase() async {
    var completer = new Completer<List<Enterprise>>();
    var enterprises = List<Enterprise>();

    Database db = await getDataFromDatabase();
    List item = await db.query(tableName);

    item.forEach((element) {
      enterprises.add(
        Enterprise(
            name: element["name"],
            cnpj: element["cnpj"],
            nickName: element["nickName"],
            fondationDate: element["fondationDate"],
            type: element["type"],
            port: element["port"],
            nature: element["nature"],
            porte: element["porte"])
      );
    });
    
    completer.complete(enterprises);
    return completer.future;
  }
}
