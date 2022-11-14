import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  uploadUserInfo(userMap, email){
    FirebaseFirestore.instance.collection("users")
      .doc(email).set(userMap).catchError((e){
        print(e);
      });
  }

    getUserByUserEmail2(String userEmail) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: userEmail ).get();
  }

  getUserByUserEmail(String userEmail) async{

    var document = await FirebaseFirestore.instance.collection("users")
        .doc(userEmail).get();

    return document.data();
  }

}