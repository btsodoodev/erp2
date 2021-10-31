// To parse this JSON data, do
//
//     final uzr = uzrFromJson(jsonString);

import 'dart:convert';

Uzr uzrFromJson(String str) => Uzr.fromJson(json.decode(str));

String uzrToJson(Uzr data) => json.encode(data.toJson());

class Uzr {
  Uzr({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  factory Uzr.fromJson(Map<String, dynamic> json) => Uzr(
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
