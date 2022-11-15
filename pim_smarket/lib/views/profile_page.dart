import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/models/models.dart';
import 'package:pim_smarket/services/database.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  String editName = '';
  String editDescription = '';
  String editTags = '';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Consumer<UserContext>(
          builder: (context, userContext, child) => Column(
            children: [
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
                  Text(
                      "${widget.title} of ${userContext.user.name}",
                      textAlign: TextAlign.center,
                      style: CustomTheme.pinkTitle),
                ],
              ),
              Text(
                  userContext.user.email,
                  textAlign: TextAlign.center,
                  style: CustomTheme.pinkText),
              const SizedBox(height: 20,),
              Text(
                  userContext.user.description,
                  textAlign: TextAlign.center,
                  style: CustomTheme.pinkText),
              const SizedBox(height: 20,),
                  Button(title: "Edit profile", onClicked:() => _editProfilePopup(context, userContext)),
            ],
          )),
    );
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
          "tags" : editTags
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
