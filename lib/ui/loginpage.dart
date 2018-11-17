import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  GoogleSignIn _googleSignIn = GoogleSignIn();

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
               child: Text('Login' ),
               color: Colors.deepPurple,
               textColor: Colors.white,
               onPressed: (){

                 FirebaseAuth.instance.signInWithEmailAndPassword(
                     email: _emailController.text, password: _passwordController.text
                 ).then((FirebaseUser user){
                   Navigator.of(context).pushReplacementNamed('/home');
                 }).catchError((e){
                   print(e);
                 });
               },
             ),
             SizedBox(height: 15.0,),
             Text('Don\'t  have an account'),
             SizedBox(height: 15.0,),

             FlatButton(
               child: Text('Register' ),
               color: Colors.green,
               textColor: Colors.white,
               onPressed: (){

                 Navigator.of(context).pushNamed('/register');
               },
             ),


             SizedBox(height: 15.0,),

             FlatButton(
               child: Text('Login by Google' ),
               color: Colors.deepOrange,
               textColor: Colors.white,
               onPressed: (){

                 _googleSignIn.signIn().then((value){
                   value.authentication.then((googleKey){

                     FirebaseAuth.instance.signInWithGoogle(
                         idToken: googleKey.idToken ,
                       accessToken: googleKey.accessToken
                     )
                     .then(( user){
                       print('Google User : $user');
                       Navigator.of(context).pushReplacementNamed('/home');
                     }).catchError((e){
                       print(e);
                     });



                   });
                 });



               },
             ),

           ],
         ),
       ),
     );
  }

}