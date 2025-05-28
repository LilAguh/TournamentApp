class Country {
  final String code;
  final String name;

  Country({required this.code, required this.name});

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name};
  }

  factory Country.fromJson(json) {
    return Country(code: json['code'], name: json['name']);
  }
}
