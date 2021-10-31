import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/times.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/screens/drawer.dart';
import 'package:provider/provider.dart';
import 'first_timesheets/first_timesheets.dart';
import 'pending.dart';
import 'the_timesheet/third_timesheet.dart';
import 'today/today.dart';
import 'package:http/http.dart' as http;


Future<Times> fetchTimes(String token, int uid) async {
  var date =  DateTime.now();
  final response = await http
      .get(Uri.parse('https://bts-algeria.com/API/api/timesheet/u/'+uid.toString()+'/'+date.year.toString()+'/'+date.month.toString()),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+token,
    },);
  print(token);
  print("--------------------");
  if (response.statusCode == 200) {
    print(response.body);

    return Times.fromJson(jsonDecode(response.body));
  } else {

    throw Exception('Failed to load album');
  }
}

class Timesheets extends StatefulWidget {
  final int ini;
  final int id;
  Timesheets([this.ini, this.id]);
  @override
  State<Timesheets> createState() => _TimesheetsState();
}

class _TimesheetsState extends State<Timesheets> with TickerProviderStateMixin {
  User _user = new User();
  Times times;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:4, vsync: this,initialIndex: widget.ini?? 0, );// initialise it here
  }

  @override
  void didChangeDependencies() {
    _user = Provider.of<UserProvider>(context).user;
    fetchTimes(_user.resp.accessToken, _user.user.first.id).then((Times ties) {
      setState(() {
        times = ties;
      }); ;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final List<Tab> theTabs = <Tab>[
    Tab(text: "Today" ,icon: Icon(Icons.today)),
    Tab(text: "Time sheets" ,icon: Icon(Icons.group_outlined)),
    Tab(text: "Timesheet",icon: Icon(Icons.watch_later_outlined )),
    Tab(text: "Pending attendance",icon: Icon(Icons.pending_actions_outlined)),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: theTabs,
          ),
          title: const Text('BTS ERP'),
        ),
        body:   TabBarView(
          controller: _tabController,
          children: [
            Today(times),
            FirstTimesheets(),
            Timesheet(widget.id),
            Pending(),
          ],
        ),
        drawer: TheDrawer(),
      ),
    );
  }
}
