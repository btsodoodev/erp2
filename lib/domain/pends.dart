// To parse this JSON data, do
//
//     final pends = pendsFromJson(jsonString);

import 'dart:convert';

Pends pendsFromJson(String str) => Pends.fromJson(json.decode(str));

class Pends {
  Pends({
    this.atts,
  });

  List<Att> atts;

  factory Pends.fromJson(Map<String, dynamic> json) => Pends(
    atts: List<Att>.from(json["attendances"].map((x) => Att.fromJson(x))),
  );

}

class Att {
  Att({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.date,
    this.description,
    this.workStatusId,
    this.stateId,
    this.statusId,

  });

  String id;
  String userId;
  String name;
  String email;
  String date;
  String description;
  String workStatusId;
  String stateId;
  String statusId;


  factory Att.fromJson(Map<String, dynamic> json) => Att(
    id: json["id"],
    userId: json["user_id"],
    date: json["date"],
    email: json["email"],
    name: json["name"],
    description: json["description"],
    workStatusId: json["work_status_id"],
    stateId: json["state_id"],
    statusId: json["status_id"],
  );

}
