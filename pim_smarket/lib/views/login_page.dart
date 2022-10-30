import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/models/models.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _email = "";
  String _password = "";
  String _name = "";
  bool _isSigningIn = true;

  void onSignIn(UserContext userContext) {
    if (_password != "1234") return;
    if (_email == "student") {
      userContext.changeUser(User.mockStudent());
      return;
    }
    if (_email == "company") {
      userContext.changeUser(User.mockCompany());
      return;
    }
  }

  void onChangeEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  void onChangePassword(String password) {
    setState(() {
      _password = password;
    });
  }

  void onChangeName(String name) {
    setState(() {
      _name = name;
    });
  }

  void onChangeMode() {
    setState(() {
      _isSigningIn = !_isSigningIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: Consumer<UserContext>(
            builder: (context, userContext, child) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                          _isSigningIn
                              ? "Sign in to ${CustomTheme.appName}"
                              : "Sign up to ${CustomTheme.appName}",
                          style: CustomTheme.pinkTitle),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: _isSigningIn
                          ? null
                          : TextInput(
                              label: "Enter your name",
                              value: _name,
                              placeholder: "name",
                              onChange: onChangeName),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextInput(
                          label: "Enter your email",
                          value: _email,
                          onChange: onChangeEmail,
                          placeholder: "Email",
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Enter your password",
                        value: _password,
                        onChange: onChangePassword,
                        placeholder: "password",
                        asteriskText: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Button(
                        title: _isSigningIn ? "Sign in" : "Sign up",
                        onClicked: () => onSignIn(userContext),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => onChangeMode(),
                          child: Text(
                            _isSigningIn
                                ? "Don`t have an account ?"
                                : "Already have an account ?",
                            style: CustomTheme.pinkText,
                          ),
                        ),
                        TextButton(
                            onPressed: () => onChangeMode(),
                            child: Text(
                              _isSigningIn
                                  ? "Sign up instead !"
                                  : "Sign in instead !",
                              style: CustomTheme.pinkText,
                            ))
                      ],
                    )
                  ],
                ))));
  }
}
