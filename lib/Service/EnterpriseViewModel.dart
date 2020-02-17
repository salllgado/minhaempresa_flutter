import 'package:minhaempresa/Model/Enterprise.dart';
import 'WebService.dart';

class EnterpriseViewModel {

  Enterprise enterprise;
  Future <Enterprise> enterpriseFuture;

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

}