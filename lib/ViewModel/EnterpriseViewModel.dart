import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minhaempresa/Model/Enterprise.dart';
import 'package:minhaempresa/Service/PreferencesService.dart';
import '../Service/WebService.dart';

class EnterpriseViewModel {

  Enterprise enterprise;
  Future <Enterprise> enterpriseFuture;
  Icon iconForThisEnterprise;

  String prepareDescription() {
    if (enterprise.mainActivity.first.title != null) {
      var code = enterprise.mainActivity.first.code;
      var title = enterprise.mainActivity.first.title;
      var text = 'Código: $code \nDescrição: $title';
      return text;
    } else { return ""; }
  }

  // fetch data
  void fetchEnterprise(String cnpj) {
    enterpriseFuture = WebService().fetchEntepriseData(cnpj);
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
}