import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, required this.title});

  final String title;

  @override
  State<AddPage> createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  List<Widget> _tagsWidgets = [];
  List<String> _tagsValues = [];
  final _descriptionController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();

  void addNewTag() {
    setState(() {
      _tagsWidgets.add(newTextInput());
      _tagsValues.add('');
    });
  }

  void onDeleteTag() {
    if (_tagsWidgets.isEmpty) return;
    setState(() {
      _tagsWidgets.removeLast();
      _tagsValues.removeLast();
    });
  }

  void onChangeTag(String value, int index) {
    _tagsValues[index] = value;
  }

  void onSubmit(UserContext userContext) {
    var description = _descriptionController.text;
    var tagsValue = _tagsValues.where((element) => element.isNotEmpty);
    var tags = tagsValue.join(", ");
    if (tagsValue.length > 1) {
      tags.replaceRange(tags.length - 2, tags.length, "");
    }

    var user = userContext.user;
    print("$tags ${_descriptionController.text} $user");

    setState(() {
      _descriptionController.text = '';
      _tagsValues = [];
      _tagsWidgets = [];
    });

    Map<String, dynamic> offerMap = {
      'name': userContext.user.name,
      'email': userContext.user.email,
      'tags': tags,
      'description': description,
      'image': userContext.user.image
    };

    databaseMethods.uploadOffer(offerMap);
    print(offerMap);
  }

  Widget newTextInput() {
    var index = _tagsWidgets.length;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: TextInput(
            label: "Enter new tag",
            placeholder: "Tag",
            onChange: (val) => onChangeTag(val, index)));
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: SingleChildScrollView(
            child: Consumer<UserContext>(
                builder: ((context, userContext, child) => Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              const Text("Tags", style: CustomTheme.pinkTitle),
                        ),
                        Column(children: _tagsWidgets),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            child:
                                Button(title: "New tag", onClicked: addNewTag)),
                        _tagsValues.isEmpty
                            ? Container()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Button(
                                  title: "Delete tag",
                                  onClicked: onDeleteTag,
                                )),
                        Container(
                          margin:
                              const EdgeInsets.only(bottom: 10.0, top: 25.0),
                          child: const Text("Description",
                              style: CustomTheme.pinkTitle),
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            child: TextInput(
                              label: "Enter description",
                              placeholder: "Description",
                              multiLine: true,
                              controller: _descriptionController,
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Button(
                              title: "Add offer",
                              onClicked: () => onSubmit(userContext),
                            )),
                      ],
                    )))));
  }
}
