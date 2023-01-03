import 'country.dart';

class countryResData {
  countryResData({
    required this.error,
    required this.msg,
    required this.data,
  });

  final bool error;
  final String msg;
  final List<Country> data;

  factory countryResData.fromJson(Map<String, dynamic> json) => countryResData(
    error: json["error"] ?? false,
    msg: json["msg"] ?? '',
    data: json["data"]!=null ? List<Country>.from(json["data"].map((x) => Country.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<Map<String,dynamic>>.from(data.map((x) => x.toJson())),
  };
}