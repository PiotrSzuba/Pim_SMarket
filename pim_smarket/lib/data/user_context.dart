import 'package:flutter/material.dart';
import 'package:pim_smarket/models/models.dart';

class UserContext extends ChangeNotifier {
  User user = User.mockStudent(); //default User.empty();

  void changeUser(User user) {
    this.user = user;
    notifyListeners();
  }

  bool isAnonymous() {
    return user.userType == UserType.anonymous;
  }

  bool isCompany() {
    return user.userType == UserType.company;
  }

  bool isStudent() {
    return user.userType == UserType.student;
  }
}
