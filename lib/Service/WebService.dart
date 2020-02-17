import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:minhaempresa/Model/Enterprise.dart';

class WebService {

  static const baseUrl = 'https://www.receitaws.com.br/v1/cnpj/';

  Future<Enterprise> fetchEntepriseData(String cnpj) async {
    final response = await http.get('$baseUrl'+'$cnpj');

    print(response.body);
    if (response.statusCode == 200) {
      return Enterprise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
