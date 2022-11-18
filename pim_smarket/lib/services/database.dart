import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  uploadUserInfo(userMap, email){
    FirebaseFirestore.instance.collection("users")
      .doc(email).set(userMap).catchError((e){
        print(e);
      });
  }

  uploadOffer(offerMap){
    FirebaseFirestore.instance.collection("offers")
      .add(offerMap).catchError((e){
        print(e);
      });
  }

  updateUserInfo(userMap, email){
    FirebaseFirestore.instance.collection("users")
        .doc(email).update(userMap);
  }

  getUserByUserEmail(String userEmail) async{

    var document = await FirebaseFirestore.instance.collection("users")
        .doc(userEmail).get();

    return document.data();
  }

  getUsersData() async{
    return await FirebaseFirestore.instance.collection("users")
      .where("userType", isEqualTo: 1).snapshots();
  }

  getUsersDataByName(String name) async{
    return await FirebaseFirestore.instance.collection("users")
      .where("name", isEqualTo: name).snapshots();
  }

  
  getOffers() async{
    return await FirebaseFirestore.instance.collection("offers")
      .snapshots();
  }

}