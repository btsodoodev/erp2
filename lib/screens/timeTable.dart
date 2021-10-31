import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';
import 'package:flutter_login_regis_provider/domain/pends.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'coloredStatus.dart';
import 'the_timesheet/buttons.dart';
import 'the_timesheet/third_timesheet.dart';
import 'package:provider/provider.dart';

class PendingTable extends StatefulWidget {
  Pends pend;
  PendingTable(this.pend);

  @override
  State<PendingTable> createState() => _PendingTableState();
}

class _PendingTableState extends State<PendingTable> {


  void _updateReject(int id, ){
    for (Att at in widget.pend.atts){
      if (at.id== id.toString()){
        setState(() {
          at.statusId="8";
        });
      }
    }
  }
  void _updateApprove(int id, ){
    for (Att at in widget.pend.atts){
      if (at.id== id.toString()){
        setState(() {
          at.statusId="6";
        });

      }
    }
  }

  void _updateDisapprove(int id, ){
    for (Att at in widget.pend.atts){
      if (at.id== id.toString()){
        setState(() {
          at.statusId="9";
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
        if (widget.pend.atts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(35.0),
            child: Text("No records Found!", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),),
          );}
        else return SingleChildScrollView(
            child: DataTable(
              columnSpacing: 20,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    '#',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Full name',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'State',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Remark',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Work status',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                  ),
                ),

              ],

              rows:  <DataRow>[
                for(Att att in widget.pend.atts)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Container(width: 20,child: Text(widget.pend.atts.indexOf(att).toString() ))),
                      DataCell(Text(att.name?? 'no description')),
                      DataCell(Text(states[int.parse(att.stateId?? "0")])),
                      DataCell(Text(att.date?? 'no description')),
                      DataCell(Text(att.description?? '-')),
                      DataCell(Text(work_statuses[int.parse(att.workStatusId??'69')])),
                      DataCell(statusColored(int.parse(att.statusId ?? '0'))),
                      DataCell(
                          Row(children: [
                            if((att.statusId=="9" || att.statusId=="8" ||  att.statusId=="6" ) && att.userId!=user.user.first.id.toString())
                              Row(
                                children: [
                                  if(att.statusId!="6")ElevatedButton( style:ElevatedButton.styleFrom(primary:Colors.green,   ),
                                      onPressed: () {
                                        print(att.date);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Approver(  int.parse(att.id) ,att.name, att.date, int.parse(att.userId), _updateApprove);
                                          },
                                        );
                                      },child: Text('Approve')),
                                  if(att.statusId=="6")ElevatedButton( style:ElevatedButton.styleFrom(primary:Colors.orange,   ),
                                      onPressed: () {
                                        print(att.date);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return disapprover(  int.parse(att.id) ,att.name, att.date, int.parse(att.userId),_updateDisapprove);
                                          },
                                        );
                                      },child: Text('Disapprove')),
                                  SizedBox(width: 10,),
                                  if(att.statusId!="8")ElevatedButton( style:ElevatedButton.styleFrom(primary:Colors.red,   ),
                                      onPressed: () {
                                        print(att.date);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return rejecter( int.parse(att.id) ,att.name, att.date, int.parse(att.userId), _updateReject);
                                          },
                                        );
                                      },child: Text('Reject')),
                                ],
                              ),
                          ],)),
                    ],
                  ),
              ],
            ),
          );
        }
  }
