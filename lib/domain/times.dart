// To parse this JSON data, do
//
//     final times = timesFromJson(jsonString);

import 'dart:convert';

Times timesFromJson(String str) => Times.fromJson(json.decode(str));

String timesToJson(Times data) => json.encode(data.toJson());

class Times {
  Times({
    this.attendances,
    this.timesUser,
    this.year,
    this.month,
    this.daysInMonth,
  });

  List<Attendance> attendances;
  TimesUser timesUser;
  String year;
  String month;
  int daysInMonth;

  factory Times.fromJson(Map<String, dynamic> json) => Times(
    attendances: List<Attendance>.from(json["attendances"].map((x) => Attendance.fromJson(x))),
    timesUser: TimesUser.fromJson(json["user"]),
    year: json["year"],
    month: json["month"],
    daysInMonth: json["daysInMonth"],
  );

  Map<String, dynamic> toJson() => {
    "attendances": List<dynamic>.from(attendances.map((x) => x.toJson())),
    "times_user": timesUser.toJson(),
    "year": year,
    "month": month,
    "daysInMonth": daysInMonth,
  };
}

class Attendance {
  Attendance({
    this.id,
    this.userId,
    this.date,
    this.timeIn,
    this.timeOut,
    this.description,
    this.workStatusId,
    this.stateId,
    this.statusId,
    this.approverId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String userId;
  String date;
  DateTime timeIn;
  dynamic timeOut;
  String description;
  String workStatusId;
  String stateId;
  String statusId;
  String approverId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"],
    date: json["date"],
    timeIn: json["time_in"] == null ? null : DateTime.parse(json["time_in"]),
    timeOut: json["time_out"],
    description: json["description"] == null ? null : json["description"],
    workStatusId: json["work_status_id"] == null ? null : json["work_status_id"],
    stateId: json["state_id"] == null ? null : json["state_id"],
    statusId: json["status_id"],
    approverId: json["approver_id"] == null ? null : json["approver_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId,
    "date": date,
    "time_in": timeIn == null ? null : timeIn.toIso8601String(),
    "time_out": timeOut,
    "description": description == null ? null : description,
    "work_status_id": workStatusId == null ? null : workStatusId,
    "state_id": stateId == null ? null : stateId,
    "status_id": statusId,
    "approver_id": approverId == null ? null : approverId,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class TimesUser {
  TimesUser({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.apiToken,
    this.roleId,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic apiToken;
  String roleId;
  dynamic avatar;
  dynamic createdAt;
  dynamic updatedAt;
  String description;

  factory TimesUser.fromJson(Map<String, dynamic> json) => TimesUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    apiToken: json["api_token"],
    roleId: json["role_id"],
    avatar: json["avatar"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "api_token": apiToken,
    "role_id": roleId,
    "avatar": avatar,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "description": description,
  };
}
