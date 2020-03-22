import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'package:minhaempresa/Service/PreferencesService.dart';
import 'package:minhaempresa/Worker/EnterpriseWorker.dart';

class EnterpriseViewModel {

  Enterprise enterprise;
  Future <Enterprise> enterpriseFuture;
  Icon iconForThisEnterprise;

  void initDatabase() {
    EnterpriseWorker().getDataFromDatabase();
  }

  String prepareDescription() {
//    if (enterprise.mainActivity.first.title != null) {
//      var code = enterprise.mainActivity.first.code;
//      var title = enterprise.mainActivity.first.title;
//      var text = 'Código: $code \nDescrição: $title';
//      return text;
//    } else { return ""; }
  return "";
  }

  // fetch data
  void fetchEnterprise(String cnpj) {
    // verifica se tem dado salvo no banco se não tiver faz o request
    enterpriseFuture = EnterpriseWorker().fetchDataFromDatabase(cnpj);
  }

  void handlerEnterpriseInPreference() {
    var pref = PreferencesService();

    var userPreferedEnterprises = pref.fetchEntepriseFromUserPreference();
    userPreferedEnterprises.then((value) => {
      if (value.contains(enterprise.cnpj)) {
        // remove from preference
        pref.removeEnterprise(this.enterprise.cnpj),
      } else {
        // add in preference
        pref.saveEnterprise(this.enterprise.cnpj),
      }
    });

  }

  handlerFavoriteIcon() {

    if (iconForThisEnterprise == Icons.star) {
      iconForThisEnterprise = Icon(Icons.star_border);
    } else {
      iconForThisEnterprise = Icon(Icons.star);
    }

    var pref = PreferencesService();
    var userPreferedEnterprises = pref.fetchEntepriseFromUserPreference();
    userPreferedEnterprises.then((value) => {
      this.iconForThisEnterprise = value.contains(this.enterprise.cnpj) ? Icon(Icons.star) : Icon(Icons.star_border),
    });
  }

  // --- database entryPoints
  void saveDataOnDatabase(Enterprise enteprise) {
    EnterpriseWorker().saveDataInDatabase(enteprise);
  }
}