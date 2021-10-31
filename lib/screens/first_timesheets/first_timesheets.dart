import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/emps.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';
import 'package:flutter_login_regis_provider/domain/times.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/screens/today/signDialog.dart';
import 'package:flutter_login_regis_provider/screens/the_timesheet/third_timesheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../timesheet.dart';


Future<Emps> fetchBoys(String token) async {
  final response = await http
      .get(Uri.parse('https://bts-algeria.com/API/api/timesheets'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+token,
    },);
  if (response.statusCode == 200) {
    return Emps.fromJson(jsonDecode(response.body));
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
      if (at.statusId =="7" || at.statusId =="8"){
        ans = true;
      }
    }
  }
  return ans;
}


class FirstTimesheets extends StatefulWidget {


  @override
  State<FirstTimesheets> createState() => _FirstTimesheetsState();
}

class _FirstTimesheetsState extends State<FirstTimesheets> {
  Future<Times> futureButton;
  Future<Emps> futureTimes;
  User _user = new User();
  bool but ;
  String lsd ;
  String today;

  bool _isSigned = false;
  void _updateSign(bool sign){
    setState(() {
      _isSigned = sign;
    });
  }

  @override
  void initState()  {
    super.initState();
    today = getToday();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _user = Provider.of<UserProvider>(context).user;
    futureTimes = fetchBoys(_user.resp.accessToken);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<Emps>(
          future: futureTimes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BoysTable(snapshot.data,);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),


    );

  }
}


class BoysTable extends StatefulWidget {
  final Emps emps;
  BoysTable(this.emps);
  @override
  _BoysTableState createState() => _BoysTableState();
}

class _BoysTableState extends State<BoysTable> {
  @override

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Full name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Month',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Year',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),

        ],
        rows:  <DataRow>[
          for (Emp emp in widget.emps.emp)
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Timesheets(2,emp.id)));
                },
                    child: Text(emp.name))),
                DataCell(Text(widget.emps.mt.toString())),
                DataCell(Text(widget.emps.yr.toString())),

              ],
            ),
        ],
      ),
    );
  }
}

