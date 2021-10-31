import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/maps.dart';


Widget statusColored(int status){
  if(status == 6){
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(statuses[status],style: TextStyle(color: Colors.white),),
      ),
    );
  }
  if(status == 7){
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(statuses[status],style: TextStyle(color: Colors.white),),
      ),
    );
  }
  if(status == 8){
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(statuses[status],style: TextStyle(color: Colors.white),),
      ),
    );
  }
  if(status == 9){
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(statuses[status],style: TextStyle(color: Colors.white),),
      ),
    );
  }
  else{
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(statuses[status],style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

