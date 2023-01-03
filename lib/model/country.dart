class Country {
  Country({
    required this.name,
    required this.currency,
    required this.unicodeFlag,
    required this.flag,
    required this.dialCode,
  });

  final String name;
  final String currency;
  final String unicodeFlag;
  final String flag;
  final String dialCode;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"] ?? '',
    currency: json["currency"] ?? '',
    unicodeFlag: json["unicodeFlag"] ?? '',
    flag: json["flag"] ?? '',
    dialCode: json["dialCode"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "currency": currency,
    "unicodeFlag": unicodeFlag,
    "flag": flag,
    "dialCode": dialCode,
  };
}
