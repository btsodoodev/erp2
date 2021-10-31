import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';
import 'package:flutter_login_regis_provider/domain/times.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';




class WilayaDD extends StatefulWidget {
  final Function updateWilaya;
  WilayaDD(this.updateWilaya);

  @override
  _WilayaDDState createState() => _WilayaDDState();
}

class _WilayaDDState extends State<WilayaDD> {

  int dropdownValue =0;
  String val= states[1];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(color: Colors.black),
      items: states
          .map((index, value) {
        return MapEntry(
            index,
            DropdownMenuItem<String>(
              value: value,
              child: Text(states[index]),
            ));
      })
          .values
          .toList(),
      value: val,
      onChanged: (String newValue) {
        if (newValue != null) {
          setState(() {
            val = newValue;
            var usdKey = states.keys.firstWhere(
                    (k) => states[k] == val, orElse: () => null);
            print (usdKey);
            dropdownValue = usdKey;
            widget.updateWilaya(dropdownValue);

          });
        }
      },


    );
  }
}

class StatusDD extends StatefulWidget {
  final Function updateStatus;
  StatusDD(this.updateStatus);

  @override
  _StatusDDState createState() => _StatusDDState();
}

class _StatusDDState extends State<StatusDD> {

  int dropdownValue =0;
  String val= work_statuses[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: work_statuses
          .map((index, value) {
        return MapEntry(
            index,
            DropdownMenuItem<String>(
              value: value,
              child: Text(work_statuses[index]),
            ));
      })
          .values
          .toList(),
      value: val,
      onChanged: (String newValue) {
        if (newValue != null) {
          val = newValue;
          var usdKey = work_statuses.keys.firstWhere(
                  (k) => work_statuses[k] == val, orElse: () => null);
          dropdownValue = usdKey;
          widget.updateStatus(dropdownValue);
          print(dropdownValue);


        }
      },
    );
  }
}


class MonthDD extends StatefulWidget {
  final Function updateMonth;
 MonthDD(this.updateMonth);

  @override
  _MonthDDState createState() => _MonthDDState();
}

class _MonthDDState extends State<MonthDD> {

  String val="01";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: months.map((name, value) {
        return MapEntry(
            name,
            DropdownMenuItem<String>(
              value: value,
              child: Text(name),
            ));
      })
          .values
          .toList(),
      value: val,
      onChanged: (String newValue) {
        if (newValue != null) {
          setState(() {
            val = newValue;
           widget.updateMonth(val);

          });
        }
      },


    );
  }
}
