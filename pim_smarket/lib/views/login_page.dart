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
  bool _emailError = false;
  String _password = "";
  bool _passwordError = false;
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

  void onSignUp(UserContext userContext) {}

  void onChangeEmail(String email) {
    setState(() {
      _email = email;
      if (email == "student" || email == "company") {
        _emailError = false;
      } else {
        _emailError = true;
      }
      if (email.isEmpty) _emailError = false;
    });
  }

  void onChangePassword(String password) {
    setState(() {
      _password = password;
      if (password == "1234") {
        _passwordError = false;
      } else {
        _passwordError = true;
      }
      if (password.isEmpty) _passwordError = false;
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
                              placeholder: "name",
                              onChange: onChangeName),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextInput(
                          label: "Enter your email",
                          onChange: onChangeEmail,
                          placeholder: "Email",
                          isError: _emailError,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Enter your password",
                        onChange: onChangePassword,
                        placeholder: "password",
                        asteriskText: true,
                        isError: _passwordError,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Button(
                        title: _isSigningIn ? "Sign in" : "Sign up",
                        onClicked: _isSigningIn
                            ? () => onSignIn(userContext)
                            : () => onSignUp(userContext),
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
