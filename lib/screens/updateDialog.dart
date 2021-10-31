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

import 'dropDowns.dart';
import 'the_timesheet/third_timesheet.dart';

class UpdateDialog extends StatefulWidget {
  final int u_id;
  final String row_date;
  final int row_id;
  final  Function updateUpdate;
  UpdateDialog(this.u_id, this.row_date, this.updateUpdate, this.row_id);
  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {

  String _desc = "";

  int _wilaya = 1;
  void _updateWilaya(int wilaya) {
    setState(() => _wilaya = wilaya);
  }

  int _status = 0;
  void _updateStatus(int status) {
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    Map data = {
      'attendance_date': widget.row_date,
      'status': _status,
      'description': _desc,
      'state': _wilaya,
      'user_id':widget.u_id
    };
    //print("rets_"+_status.toString());
    //print(myController.text);

    String body = json.encode(data);
    return AlertDialog(
      title: const Text('Add Attendance'),
      content: SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WilayaDD(_updateWilaya),
            SizedBox(height: 20,),
            StatusDD(_updateStatus),
            SizedBox(height: 20,),
            TextField(
              onChanged: (text) {
                setState(() {
                  _desc= text;
                  print("from state"+_desc);
                });

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),),
            SizedBox(height: 20,),

          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () async {
            print(body);
            Response response = await http.patch(Uri.parse('http://bts-algeria.com/API/api/timesheet/update'),
                body: body,
                headers: {'Authorization': "Bearer "+user.resp.accessToken, 'Content-type': 'application/json',});
            if (response.statusCode==200){
              widget.updateUpdate( widget.row_id, widget.row_date,_status, _wilaya, _desc );
              Fluttertoast.showToast(
                  msg: "Attendance updated successfully, Waiting for manager approval.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.of(context).pop();
            }
            else{
              print(response.body);
              print ('---------------/---------------/------------');
              Fluttertoast.showToast(
                  msg: "error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}