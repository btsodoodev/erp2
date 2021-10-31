
import 'package:flutter/material.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/auth_provider.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/utility/validator.dart';
import 'package:flutter_login_regis_provider/utility/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'timesheet.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();

  String _userName, _password;


  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var doLogin = (){

      final form = formKey.currentState;

      if(form.validate()){

        form.save();

        final Future<Map<String,dynamic>> respose =  auth.login(_userName,_password);

        respose.then((response) {
          if (response['status']) {

            User user = response['user'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Timesheets()));

          } else {
            Fluttertoast.showToast(
                msg: "Please Check credentials!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );          }
        });


      }else{
        print('invalid');

      }

    };


    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );



    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: SizedBox(
                          width: 200,
                          height: 150,
                          child: Image.asset('assets/logo.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(height: 15.0,),
                  Text("Email"),
                  SizedBox(height: 5.0,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    validator: validateEmail,
                    onSaved: (value)=> _userName = value,
                    decoration: buildInputDecoration('Enter Email',Icons.email),
                  ),
                  SizedBox(height: 20.0,),
                  Text("Password"),
                  SizedBox(height: 5.0,),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: (value)=> value.isEmpty?"Please enter password":null,
                    onSaved: (value)=> _password = value,
                    decoration: buildInputDecoration('Enter Password',Icons.lock),
                  ),
                  SizedBox(height: 20.0,),
                  auth.loggedInStatus == Status.Authenticating
                  ?loading
                  : longButtons('Login',doLogin),
                  SizedBox(height: 8.0,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
