// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.resp,
    this.user,
  });

  Resp resp;
  List<UserElement> user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    resp: Resp.fromJson(json["response"]),
    user: List<UserElement>.from(json["user"].map((x) => UserElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": resp.toJson(),
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class Resp {
  Resp({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  factory Resp.fromJson(Map<String, dynamic> json) => Resp(
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "expires_in": expiresIn,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}

class UserElement {
  UserElement({
    this.email,
    this.name,
    this.id,
  });

  String email;
  String name;
  int id;

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
    email: json["email"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "id": id,
  };
}
