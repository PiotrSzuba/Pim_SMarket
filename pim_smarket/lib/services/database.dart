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

  getOffers() async{
    return await FirebaseFirestore.instance.collection("offers")
      .snapshots();
  }

  createChatRoom(String chatroomId, charRoomMap){
    FirebaseFirestore.instance.collection("chatroom")
        .doc(chatroomId).set(charRoomMap).catchError((e) {print(e);});
  }

  updateChatRoom(String chatroomId, chatRoomMap){
    FirebaseFirestore.instance.collection("chatroom")
        .doc(chatroomId).update(chatRoomMap).catchError((e) {print(e);});
  }

  addConversationMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection("chatroom")
        .doc(chatRoomId)
        .collection("chat")
        .add(messageMap).catchError((e){print(e);});
  }

  getConversationMessages(String chatRoomId){
    return FirebaseFirestore.instance.collection("chatroom")
        .doc(chatRoomId)
        .collection("chat")
        .orderBy("time", descending: true)
        .snapshots();
  }

    getChatRoom(String chatRoomID) async{
    return await FirebaseFirestore.instance.collection("chatroom")
        .where("chatroomid", isEqualTo: chatRoomID).snapshots();
  }

    getChatRooms(String userEmail) async{
    return await FirebaseFirestore.instance.collection("chatroom")
        .where("users", arrayContains: userEmail).snapshots();
  }

}