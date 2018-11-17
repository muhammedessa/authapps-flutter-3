import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();

}

class _HomeState extends State<Home>{

  String _name = '';
  String _uid = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      _name = user.email;
      _uid = user.uid;
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('$_name',style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontSize: 22.0,
            ),),
            SizedBox(height: 15.0,),

            Text('$_uid',style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontSize: 22.0,
            ),),
            SizedBox(height: 15.0,),

            Text('Welcome Dashboard',style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontSize: 22.0,
            ),),
            SizedBox(height: 15.0,),

            FlatButton(
              child: Text('Logout' ),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: (){

                FirebaseAuth.instance.signOut()
                    .then((value){
                  Navigator.of(context).pushReplacementNamed('/landingpage');
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