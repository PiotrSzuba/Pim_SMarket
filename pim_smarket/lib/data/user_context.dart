import 'package:flutter/material.dart';
import 'package:pim_smarket/models/models.dart';

class UserContext extends ChangeNotifier {
  User user = User.empty();

  void changeUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
