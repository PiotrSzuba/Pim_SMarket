import 'package:flutter/material.dart';
import 'package:pim_smarket/models/models.dart';

class UserContext extends ChangeNotifier {
  User user = User.empty(); //default User.empty();

  void changeUser(User user) {
    this.user = user;
    notifyListeners();
  }

  bool isAnonymous() {
    return user.userType == 2;// user.userType == UserType.anonymous;
  }

  bool isCompany() {
    return user.userType == 0;
  }

  bool isStudent() {
    return user.userType == 1;
  }
}
