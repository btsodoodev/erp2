import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';
import 'package:flutter_login_regis_provider/domain/pends.dart';
import 'package:flutter_login_regis_provider/domain/times.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../the_timesheet/buttons.dart';
import 'signDialog.dart';
import '../the_timesheet/third_timesheet.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../timeTable.dart';


Future<Pends> fetchDays(String token) async {
  final response = await http
      .get(Uri.parse('https://bts-algeria.com/API/api/timesheet/today'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+token,
    },);
  if (response.statusCode == 200) {
    return Pends.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

String getToday(){
  final now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  return date.toString().substring(0,10);;
}

bool isDateSignable(String date, Times times ){
  bool ans= false;
  for (Attendance at in times.attendances) {
    if(at.date == date){
      if (at.statusId =="7"){
        ans = true;
      }
    }
  }
  return ans;
}



class Today extends StatefulWidget {
  final Times times;
  Today(this.times);
  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Future<Pends> futurePending;
  User _user = new User();
  bool but ;
  String lsd ;
  String today;

  void _signUpdate(String tod,int state, int status, String desc){
    for (Attendance at in widget.times.attendances){
      if (at.date == tod){
        setState(() {
          at.workStatusId = status.toString();
          at.stateId = state.toString();
          at.description = desc;
          at.statusId="9";});
      }
    }
  }

  @override
  void initState()  {
    super.initState();
    today = getToday();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserProvider>(context).user;
    futurePending = fetchDays(_user.resp.accessToken);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<Pends>(
          future: futurePending,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PendingTable(snapshot.data,);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                bool a = isDateSignable(today, widget.times);
                if (a ){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SignDialog( _signUpdate,today,  );
                    },
                  );
                }else{
                  Fluttertoast.showToast(
                      msg: "Already Signed!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }

              },
              label: const Text('Sign'),
              icon: const Icon(Icons.edit),
              backgroundColor: Colors.green,
            )
    );
          }
        }

