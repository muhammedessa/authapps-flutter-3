import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authapps/utils/user_to_database.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email',icon: Icon(Icons.email)),
              controller: _emailController,
            ),
            SizedBox(height: 15.0,),

            TextField(
              decoration: InputDecoration(labelText: 'Password',icon: Icon(Icons.vpn_key)),
              controller: _passwordController,
            ),
            SizedBox(height: 15.0,),

            FlatButton(
              child: Text('Register' ),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: (){

                FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text, password: _passwordController.text
                ).then((singedUser){
                   UserToDatabase().addNewUser(singedUser, context);
                }).catchError((e){
                  print(e);
                });
              },
            ),



          ],
        ),
      ),
    );
  }

}