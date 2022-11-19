import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/services/database.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Widget> students = List<Widget>.generate(
      20,
      (index) => InfoCard(
            name: "student ${index + 1}",
            tags: "C C++ C# F# Java Python Lisp Javascript Typescript Dart",
            imageUrl: 'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
            onPressed: () => print("student ${index + 1} clicked"),
          ));

  List<Widget> companies = List<Widget>.generate(
      20,
      (index) => InfoCard(
            name: "company ${index + 1}",
            tags: "Greedy, low pay, fruity fridays, paid coffee",
            imageUrl: 'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
            onPressed: () => print("Company ${index + 1} clicked"),
          ));

  List<Widget> _getItems(UserContext userContext) {
    return userContext.isStudent() ? companies : students;
  }

  String searchName = '';
  String searchTags = '';

  @override
  Widget build(BuildContext context) {
    print("name: $searchName tags: $searchTags");
    return PageTemplate(
        floatingActionButton: FloatingActionButton(
            onPressed: () => _searchPopup(context),
            backgroundColor: CustomTheme.pinkColor,
            child: const Icon(Icons.search, color: Colors.black)),
            child: Consumer<UserContext>(
                builder: (context, userContext, child) =>
                      usersList(userContext)
                      ));
  }

  Future<void> _searchPopup(BuildContext context) {
    var nameController = TextEditingController();
    var tagsController = TextEditingController();

    void onSearch() {
      Navigator.of(context).pop();
      setState(() {
        searchName = nameController.text;
        searchTags = tagsController.text;
      });
      print("searching");
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
                        "Search by tags",
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Enter tags",
                        placeholder: "Tags",
                        controller: tagsController,
                      )),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5.0, top: 15),
                      child: const Text(
                        "Search by name",
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Enter name",
                        placeholder: "Name",
                        controller: nameController,
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child:
                          Button(title: "Search", onClicked: () => onSearch())),
                ],
              ),
            )));
  }

  Future<void> _profileDetailsPopup(BuildContext context, Map<String,dynamic> data) {

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
                              data['image'],
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        data['name'],
                        style: CustomTheme.pinkTitle,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        data['email'],
                        style: CustomTheme.pinkText,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        data['tags'],
                        style: CustomTheme.pinkText,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        data['description'],
                        style: CustomTheme.pinkText,
                      )),
                ],
              ),
            )));
  }

  DatabaseMethods databaseMethods = DatabaseMethods();
  late final Stream<QuerySnapshot> usersStream;
  late final Stream<QuerySnapshot> offersStream;

  late final Stream<QuerySnapshot> searchByNameStream;

  Widget usersList(UserContext userContext){
    if(userContext.user.userType == 0){
      try{
        return StreamBuilder(
          stream: usersStream,
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

                return InfoCard(name: data['name'], tags: data['tags'], onPressed: ()=>{_profileDetailsPopup(context, data)}, imageUrl: data['image'],);        
          }).toList()
            );
          },
        );
      }catch(e){print(e);return const Scaffold(body: Text("Sheep's not Gucci",style: TextStyle(color: Colors.white)),);}
    }
    else{
      try{
        return StreamBuilder(
          stream: offersStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              print("not good");
              return const Scaffold();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
             print("Waiting for offersStream initialization");
              return const Scaffold();
            }
            print("Initialization compleated");
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<
                    String,
                    dynamic>;

                return InfoCard(name: data['name'], tags: data['tags'], onPressed: ()=>{_profileDetailsPopup(context, data)}, imageUrl: data['image']);           
          }).toList()
            );
          },
        );
      }catch(e){print(e);return const Scaffold(body: Text("Sheep's not Gucci",style: TextStyle(color: Colors.white),),);}
    }
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  getData() async{
    databaseMethods.getUsersData().then((value){
      setState(() {
        usersStream = value;
      });
    });
    databaseMethods.getOffers().then((value){
      setState(() {
        offersStream = value;
      });
    });
  }
}
