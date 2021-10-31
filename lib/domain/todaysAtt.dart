// To parse this JSON data, do
//
//     final todaysAtt = todaysAttFromJson(jsonString);

import 'dart:convert';

import 'times.dart';

TodaysAtt todaysAttFromJson(String str) => TodaysAtt.fromJson(json.decode(str));

String todaysAttToJson(TodaysAtt data) => json.encode(data.toJson());

class TodaysAtt {
  TodaysAtt({
    this.attendances,
  });

  List<Attendance> attendances;

  factory TodaysAtt.fromJson(Map<String, dynamic> json) => TodaysAtt(
    attendances: List<Attendance>.from(json["attendances"].map((x) => Attendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendances": List<dynamic>.from(attendances.map((x) => x.toJson())),
  };
}

