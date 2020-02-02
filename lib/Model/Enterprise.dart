class Enterprise {
  final String name;
  final String cnpj;
  final String nickName;
  final String fondationDate;
  final String type;

  Enterprise({
    this.name,
    this.cnpj,
    this.nickName,
    this.fondationDate,
    this.type,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    return Enterprise(
      name: json['name'],
      cnpj: json['cnpj'],
      nickName: json['nickName'],
      fondationDate: json['abertura'],
      type: json['abertura'],
    );
  }
}