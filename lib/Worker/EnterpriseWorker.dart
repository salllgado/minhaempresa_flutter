import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Service/WebService.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'dart:async';

class EnterpriseWorker {

  Future<Enterprise> fetchEnterprise(String cnpj) async {
    // handler if contains file with cnpj else create one from webservice response.
    return WebService().fetchEntepriseData(cnpj);
  }

  getDataFromDatabase() async {
    final pathToDB = await getDatabasesPath();
    final completePath = join(pathToDB, "banco.db");
    
    var db = await openDatabase(
      completePath,
      version: 1,
      onCreate: (db, dbNewestVersion) {
        String query = "CREATE TABLE enterprise (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, cnpj VARCHAR, nickName VARCHAR, fondationDate VARCHAR, type VARCHAR, port VARCHAR, nature VARCHAR)";
          db.execute(query);
      });

    return db;
  }

  void saveDataInDatabase(Enterprise enterprise) async {

    final tableName = "enterprise";
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
    String query = "SELECT * FROM enterprise";
    List itens = await db.rawQuery(query);
    var iten = itens.first;

   if (iten == null) {
        fetchEnterprise(cnpj);
   } else {
     return Enterprise(
         name: iten["name"],
         cnpj: iten["cnpj"],
         nickName: iten["nickName"],
         fondationDate: iten["fondationDate"],
         type: iten["type"],
         port: iten["port"],
         nature: iten["nature"]
     );
   }
  }
}