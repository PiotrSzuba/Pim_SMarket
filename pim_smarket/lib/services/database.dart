import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(userMap, email) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .set(userMap)
        .catchError((e) {
      print(e);
    });
  }

  uploadOffer(offerMap) {
    FirebaseFirestore.instance
        .collection("offers")
        .add(offerMap)
        .catchError((e) {
      print(e);
    });
  }

  updateMyOffers(String userEmail, image, name) {
    dynamic querySnapshots = FirebaseFirestore.instance
        .collection("offers")
        .where("email", isEqualTo: userEmail)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({"image": image, "name": name});
        print(element.data()["email"]);
      });
    });
  }

  updateUserInfo(userMap, email) {
    FirebaseFirestore.instance.collection("users").doc(email).update(userMap);
  }

  getUserByUserEmail(String userEmail) async {
    try {
      var document = await FirebaseFirestore.instance
          .collection("users")
          .doc(userEmail)
          .get();

      return document.data();
    } catch (e) {
      return null;
    }
  }

  getUsersData() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userType", isEqualTo: 1)
        .snapshots();
  }

  getOffers() async {
    return await FirebaseFirestore.instance.collection("offers").snapshots();
  }

  createChatRoom(String chatroomId, charRoomMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomId)
        .set(charRoomMap)
        .catchError((e) {
      print(e);
    });
  }

  updateChatRoom(String chatroomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomId)
        .update(chatRoomMap)
        .catchError((e) {
      print(e);
    });
  }

  updateMyChatRooms(String userEmail, username, image) {
    dynamic querySnapshots = FirebaseFirestore.instance
        .collection("chatroom")
        .where("users", arrayContains: userEmail)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        dynamic usernames = [
          element.data()["usernames"][0],
          element.data()["usernames"][1]
        ];
        dynamic images = [
          element.data()["usersImages"][0],
          element.data()["usersImages"][1]
        ];
        if (element.data()["users"][0] == userEmail) {
          usernames = [username, element.data()["usernames"][1]];
          images = [image, element.data()["usersImages"][1]];
        } else {
          usernames = [element.data()["usernames"][0], username];
          images = [element.data()["usersImages"][0], image];
        }

        element.reference
            .update({"usernames": usernames, "usersImages": images});
      });
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chat")
        .add(messageMap)
        .catchError((e) {
      print(e);
    });
  }

  getConversationMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRoom(String chatRoomID) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .where("chatroomid", isEqualTo: chatRoomID)
        .snapshots();
  }

  getChatRooms(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .where("users", arrayContains: userEmail)
        .snapshots();
  }
}
