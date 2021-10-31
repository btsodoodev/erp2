// To parse this JSON data, do
//
//     final emps = empsFromJson(jsonString);

import 'dart:convert';

Emps empsFromJson(String str) => Emps.fromJson(json.decode(str));


class Emps {
  Emps({
    this.emp,
    this.yr,
    this.mt,
  });

  List<Emp> emp;
  int yr;
  int mt;

  factory Emps.fromJson(Map<String, dynamic> json) => Emps(
    emp: List<Emp>.from(json["users"].map((x) => Emp.fromJson(x))),
    yr: json["year"],
    mt: json["month"],
  );

}

class Emp {
  Emp({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Emp.fromJson(Map<String, dynamic> json) => Emp(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
