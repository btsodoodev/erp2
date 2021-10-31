
import 'dart:convert';

import 'package:flutter_login_regis_provider/domain/refresher.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserPreferences {

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', user.resp.accessToken);
    prefs.setString('refreshToken', user.resp.refreshToken);
    prefs.setString('email', user.user.first.email);
    prefs.setString('name', user.user.first.name);
    prefs.setInt('id', user.user.first.id);
    print("SAVED ");
    print(DateTime.now());
    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if( prefs.getString("refreshToken")==null) print("THEPROBLEM0001");
    String refreshToken = prefs.getString("refreshToken");
    String email =prefs.getString('email');
    String name=prefs.getString('name');
    int id =prefs.getInt('id');
    Map data = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': 1,
      'client_secret': 'I0fbK8Av3wrImG9bzBnJdxTVH5IeZnugVwyfInj6',
      'scope': null
    };
    String body = json.encode(data);
    print("SENDING====>");
    print(DateTime.now());
    final response = await http.post(Uri.parse('https://bts-algeria.com/API/oauth/token'),
        headers: {'Content-type': 'application/json'},
        body: body,);
    print("RECEIVING====>");
    print(DateTime.now());

    if (response.statusCode == 200) {
      Uzr usr = Uzr.fromJson(jsonDecode(response.body));
      Resp resp = new Resp(accessToken: usr.accessToken, refreshToken: usr.refreshToken);
      UserElement userElement = UserElement(email: email, name: name, id: id);
      List<UserElement> ul = [];
      ul.add(userElement);
      print("all fine ");
      saveUser(User(resp: resp, user: ul));

      return User(resp: resp, user: ul);
    } else print("all is not fine");return User(resp: null, user: null);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('refreshToken');
    prefs.remove('accessToken');
    prefs.remove('email');
    prefs.remove('name');
    prefs.remove('id');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("accessToken");
    return token;
  }
}


