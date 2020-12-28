import 'package:flutter/material.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'package:minhaempresa/Worker/EnterpriseWorker.dart';

class PreferedViewModel {

  Future<List<Enterprise>> fetchEnterprises() async {
    return await 
    EnterpriseWorker().fetchAllEnterprisesFromDatabase();
  }
}
