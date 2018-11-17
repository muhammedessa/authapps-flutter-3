import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';


class UserToDatabase {
  
  addNewUser(user , context) {
    FirebaseDatabase.instance.reference().child('users')
        .push().set({
      'email' : user.email,
       'uid' : user.uid
    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');

    }).catchError((e){
      print(e);
    });
  }
}