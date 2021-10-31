import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';
import 'package:flutter_login_regis_provider/domain/pends.dart';
import 'package:flutter_login_regis_provider/domain/times.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/screens/drawer.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'timeTable.dart';


Future<Pends> fetchPending(String token) async {
  final response = await http
      .get(Uri.parse('https://bts-algeria.com/API/api/timesheet/pending'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+token,
    },);
  if (response.statusCode == 200) {
    return Pends.fromJson(jsonDecode(response.body));
  } else {

    throw Exception('Failed to load album');
  }
}


class Pending extends StatefulWidget {
  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  Future<Pends> futurePending;
  User _user = new User();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserProvider>(context).user;
    futurePending = fetchPending(_user.resp.accessToken);

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<Pends>(
        future: futurePending,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PendingTable(snapshot.data,);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),

    );
  }
}

