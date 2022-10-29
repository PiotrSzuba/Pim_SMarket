import 'package:flutter/cupertino.dart';
import 'package:pim_smarket/models/models.dart';

class UserContext extends InheritedWidget {
  final User user;

  const UserContext({super.key, required Widget child, required this.user})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
