class Enterprise {
  final String name;
  final String cnpj;
  final String nickName;
  final String fondationDate;
  final String type;
  final String port;
  final String nature;
//  final List<Activity> mainActivity;

  Enterprise({
    this.name,
    this.cnpj,
    this.nickName,
    this.fondationDate,
    this.type,
    this.port,
    this.nature,
//    this.mainActivity
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    // var activityJson = json['atividade_principal'] as List;
    // List<Activity> _activityJson = activityJson.map((activityJson) => Activity.fromJson(activityJson)).toList();

    return Enterprise(
        name: json['nome'],
        cnpj: json['cnpj'],
        nickName: json['fantasia'],
        fondationDate: json['abertura'],
        type: json['tipo'],
        port: json['porte'],
        nature: json['natureza_juridica'],
//        mainActivity: _activityJson
    );
  }
}

class Activity {
  final String title;
  final String code;

  Activity({
    this.title,
    this.code
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['text'],
      code: json['code']
    );
  }
}