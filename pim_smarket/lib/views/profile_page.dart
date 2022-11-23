import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/models/models.dart';
import 'package:pim_smarket/services/database.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  File? file;

  String editName = '';
  String editDescription = '';
  String editTags = '';

  late final Stream<QuerySnapshot> chatRoomsStream;

  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Consumer<UserContext>(
          builder: (context, userContext, child) => Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomTheme.pinkColor),
                    borderRadius: CustomTheme.circularBorder,
                  ),
                  margin: const EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: CustomTheme.circularBorder,
                    child: SizedBox.fromSize(
                        size: const Size.square(100),
                        child: Image.network(
                              userContext.user.image,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                            userContext.user.name,
                            textAlign: TextAlign.right,
                            style: CustomTheme.pinkTitle),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          userContext.user.email,
                          textAlign: TextAlign.left,
                          style: CustomTheme.pinkText),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                  child: Text(
                    userContext.user.tags,
                    textAlign: TextAlign.right,
                    style: CustomTheme.pinkTitle),
              ),
              const SizedBox(height: 20,),
              Text(
                  userContext.user.description,
                  textAlign: TextAlign.center,
                  style: CustomTheme.pinkText),
              const SizedBox(height: 20,),
              Button(title: "Edit profile", onClicked:() => _editProfilePopup(context, userContext)),
              const SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chatroom").where("users", arrayContains: userContext.user.email).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    print("not good");
                    return const Scaffold();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("Waiting for usersStream initialization");
                    return const Scaffold();
                  }
                  print("Initialization compleated");
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<
                      String,
                      dynamic>;

                    String conversationName = data["usernames"][0];
                    if(data["usernames"][0] == userContext.user.name){
                      conversationName = data["usernames"][1];
                    }
                    String conversationImage = data["usersImages"][0];
                    if(data["usersImages"][0] == userContext.user.image){
                      conversationImage = data["usersImages"][1];
                    }
                    

                    return InfoCard(name: conversationName, tags: "", onPressed: ()=>_chatPopup(context, userContext, data["chatroomid"].toString()), imageUrl: conversationImage,);
                         
                  }).toList()
                  );
                  },
             ),
              )
            ],
          )),
    );
  }

  Future<void> _chatPopup(BuildContext context, UserContext userContext, String chatRoomID) {

    var messageController = TextEditingController();
    String messageContent = "";

    void onSendMessage(UserContext userContext) {
      
      setState(() {
        messageContent = messageController.text;

        if(messageController.text.isNotEmpty){
          Map<String, dynamic> messageMap ={
            "message" : messageContent,
            "sendby" : userContext.user.email,
            "time"  : DateTime.now().millisecondsSinceEpoch
          };

          databaseMethods.addConversationMessages(chatRoomID, messageMap);
        }
        messageController.text = "";
      });
    }

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.black,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  StreamBuilder(
                      stream: databaseMethods.getConversationMessages(chatRoomID),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasError) {
                        print("not good");
                        return const Scaffold();
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("Waiting for messages Stream initialization");
                        return const Scaffold();
                      }
                      print("Initialization compleated");
                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<
                          String,
                          dynamic>;

                        return Container(
                          alignment: data["sendby"].toString() == userContext.user.email ? Alignment.centerRight : Alignment.centerLeft,
                          child: Text(data["message"],style: CustomTheme.pinkText,
                          ));
                             
                      }).toList()
                      );
                      },
                    ),
                    Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: "Message...",
                            hintStyle: CustomTheme.pinkText50
                          ),
                          style: CustomTheme.pinkText,
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          onSendMessage(userContext);
                        },
                        child: const Icon(Icons.send, color: CustomTheme.pinkColor)
                    ),
                  ],
                ),
              ),
            ),
                ],
              )
            )));
  }

  void pickUploadImage(UserContext userContext) async{
    FilePickerResult? result;
    try{
      result =  await FilePicker.platform.pickFiles(allowMultiple: false);
    }
    catch(e){
      print(e);
    }
    if(result != null){
      try{
        Uint8List? uploadfile = result.files.single.bytes;
        String fileName = basename(result.files.single.name);
        
        Reference storageReference = FirebaseStorage.instance.ref().child("profilePictures/${fileName}");
        final UploadTask uploadTask = storageReference.putData(uploadfile!);
        final TaskSnapshot downloadUrl = await uploadTask;
        final String attchUrl = (await downloadUrl.ref.getDownloadURL());
        print(attchUrl);

        setState(() {
          Map<String,dynamic> editedUserMap = {
            "image": attchUrl,
          };
          databaseMethods.updateUserInfo(editedUserMap,userContext.user.email);

          User editedUser = User.mockStudent();
          databaseMethods.getUserByUserEmail(userContext.user.email)
          .then((val){
            editedUser = User.fromJson(val);
            userContext.changeUser(editedUser);
        });
        });

      }
      catch(e)
      {
        print(e);
      }
    }
    
  }

  Future<void> _editProfilePopup(BuildContext context, UserContext userContext) {
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    var tagsController = TextEditingController();

    DatabaseMethods databaseMethods = DatabaseMethods();

    nameController.text = userContext.user.name;                // initial value
    descriptionController.text = userContext.user.description;  //initial value
    tagsController.text = userContext.user.tags;

    void onEdit() {
      Navigator.of(context).pop();
      setState(() {
        editName = nameController.text;
        editDescription = descriptionController.text;
        editTags = tagsController.text; 

        Map<String,dynamic> editedUserMap = {
          "name" : editName,
          "description" : editDescription,
          "tags" : editTags,
        };

        databaseMethods.updateUserInfo(editedUserMap,userContext.user.email);

        User editedUser = User.mockStudent();
        databaseMethods.getUserByUserEmail(userContext.user.email)
          .then((val){
            editedUser = User.fromJson(val);
            userContext.changeUser(editedUser);
        });
      });
    }

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.black,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child:
                          Button(title: "Pick image", onClicked: () => pickUploadImage(userContext))),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: const Text(
                        "Edit name",
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Name",
                        placeholder: "Name",
                        controller: nameController,
                      )),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5.0, top: 15),
                      child: const Text(
                        "Edit description",
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Description",
                        placeholder: "Description",
                        controller: descriptionController,
                      )),
                      Container(
                      margin: const EdgeInsets.only(bottom: 5.0, top: 15),
                      child: const Text(
                        "Edit tags",
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Tags",
                        placeholder: "Tags",
                        controller: tagsController,
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child:
                          Button(title: "Save", onClicked: () => onEdit())),
                ],
              ),
            )));
  }
}