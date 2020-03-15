import 'package:minhaempresa/Model/Enterprise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {

  static const favoriteEnterprisesKey = "favoriteEnterprisesKey";

  Future<List<String>> fetchEntepriseFromUserPreference() async {
    final preference = await SharedPreferences.getInstance();
    if (preference.getStringList(favoriteEnterprisesKey) == null) {
      return [];
    } else {
      return preference.getStringList(favoriteEnterprisesKey).toList();
    }
  }

  // save item in preference.
  void saveEnterprise(String cnpj) async {
    final preference = await SharedPreferences.getInstance();
    var listOfCNPJ = preference.getStringList(favoriteEnterprisesKey);

    var newList = <String>[];
    print("conteudo da lista recuperada: $listOfCNPJ");
    if (listOfCNPJ == null || listOfCNPJ.isEmpty) {
      newList.add(cnpj);
    } else {
      listOfCNPJ.forEach((element) => {
        if (element != cnpj) {
          newList.add(element)
        }
      });
    }

    print("conteúdo da lista: $newList");

    preference.setStringList(favoriteEnterprisesKey, newList);
  }

  void removeEnterprise(String cnpj) async {
    var list = <String>[];
    final preference = await SharedPreferences.getInstance();

    var userPreferedEnterprises = fetchEntepriseFromUserPreference();
    userPreferedEnterprises.then((value) => {
      if (value.contains(cnpj) == true) {
        this.remove(cnpj),
      } else {
        this.saveEnterprise(cnpj)
      }
    });
  }

  void remove(String cnpj) async {
    final preference = await SharedPreferences.getInstance();
    var userPreferedEnterprises = fetchEntepriseFromUserPreference();
    userPreferedEnterprises.then((value) => {
      for( var i = 0 ; i <= value.length; i++ ) {
        if (value[i] == cnpj) {
          value.removeAt(i),
          print("removed")
        },
      },

      print("conteúdo da lista: $value"),
      preference.setStringList(favoriteEnterprisesKey, value),
    });
  }
}