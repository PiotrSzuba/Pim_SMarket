import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/models/models.dart';
import 'package:pim_smarket/services/auth.dart';
import 'package:pim_smarket/services/database.dart';
import 'package:pim_smarket/services/helper_functions.dart';
import 'package:pim_smarket/theme.dart';
import 'package:pim_smarket/views/home_page.dart';
import 'package:pim_smarket/views/main_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _email = "";
  String _emailErrorMessage = "";
  bool _emailError = false;

  String _password = "";
  String _passwordErrorMessage = "";
  bool _passwordError = false;

  String _name = "";
  String _nameErrorMessage = "";
  bool _nameError = false;

  int _userType = 2; //usertype changed to int
  final _userTypeMessage = "You have to pick your account type !";
  bool _userTypeError = false;

  bool _isSigningIn = true;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  void validateEmail(String email) {
    if (email.isEmpty) {
      _emailError = true;
      _emailErrorMessage = "Email cannot be empty !";
      return;
    }

    _emailError = false;
    _emailErrorMessage = "";
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      _passwordError = true;
      _passwordErrorMessage = "Password cannot be empty !";
      return;
    }
    if (password.length < 8 && !_isSigningIn) {
      _passwordError = true;
      _passwordErrorMessage = "Password has to have at least 8 characters !";
      return;
    }
    _passwordError = false;
    _passwordErrorMessage = "";
  }

  void validateName(String name) {
    if (name.isEmpty) {
      _nameError = true;
      _nameErrorMessage = "Name cannot be empty !";
      return;
    }
    _nameError = false;
    _nameErrorMessage = "";
  }

  void onSignIn(UserContext userContext) {
    setState(() {
      validatePassword(_password);
      validateEmail(_email);
    });

    if (_passwordError) return;
    if (_emailError) return;

    var user = User.empty();
    databaseMethods.getUserByUserEmail(_email).then((value) {
      if (value == null) {
        setState(() {
          _emailError = true;
          _emailErrorMessage = "Could not sign in check your email !";
        });
        return;
      }
      user = User.fromJson(value);
      if (user.email == '') return;

      authMethods.signInWithEmailAndPassword(_email, _password).then((value) {
        if (value == null) {
          setState(() {
            _passwordError = true;
            _passwordErrorMessage = "Could not sign in check your password!";
          });
        } else {
          userContext.changeUser(user);
        }
      });
    });
  }

  void onSignUp(UserContext userContext) {
    setState(() {
      if (_userType == 2) _userTypeError = true;
      validateEmail(_email);
      validatePassword(_password);
      validateName(_name);

      if (_emailError) return;
      if (_passwordError) return;
      if (_nameError) return;
      if (_userTypeError) return;

      var user = User(_email, _name, _password, _userType, "", "", "", false);

      authMethods.signUpWithEmailAndPassword(_email, _password).then((value) {
        if (value == 'ERROR_EMAIL_ALREADY_IN_USE') {
          setState(() {
            _emailError = true;
            _emailErrorMessage = "Email already in use !";
          });
        } else if (value == 'invalid-email') {
          setState(() {
            _emailError = true;
            _emailErrorMessage = "Invalid email !";
          });
        } else if (value == null) {
          setState(() {
            _emailError = true;
            _emailErrorMessage = "Unknown error !";
          });
        } else {
          databaseMethods.uploadUserInfo(user.toJson(), _email);
          onChangeMode();
        }
      });
    });
    print("$_email $_name $_password");
  }

  void onChangeEmail(String email) {
    setState(() {
      _email = email;
      validateEmail(email);
    });
  }

  void onChangePassword(String password) {
    setState(() {
      _password = password;
      validatePassword(password);
    });
  }

  void onChangeName(String name) {
    setState(() {
      _name = name;
      validateName(name);
    });
  }

  void onChangeMode() {
    setState(() {
      _emailError = false;
      _passwordError = false;
      _userTypeError = false;
      _nameError = false;
      _emailErrorMessage = "";
      _passwordErrorMessage = "";
      _nameErrorMessage = "";
      _isSigningIn = !_isSigningIn;
    });
  }

  void onChangeAccountType(int? userType) {
    //userType changed to int
    if (userType == null) return;
    setState(() {
      _userTypeError = false;
      _userType = userType;
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
                              isError: _nameError,
                              errorMessage: _nameErrorMessage,
                              onChange: onChangeName),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextInput(
                          label: "Enter your email",
                          onChange: onChangeEmail,
                          placeholder: "Email",
                          isError: _emailError,
                          errorMessage: _emailErrorMessage,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextInput(
                        label: "Enter your password",
                        onChange: onChangePassword,
                        placeholder: "password",
                        asteriskText: true,
                        isError: _passwordError,
                        errorMessage: _passwordErrorMessage,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: _isSigningIn
                            ? null
                            : Column(children: [
                                Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: _userTypeError
                                            ? CustomTheme.errorColor
                                            : CustomTheme.pinkColor50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Radio<int>(
                                              //usertype changed to int
                                              activeColor:
                                                  CustomTheme.pinkColor,
                                              value: 1,
                                              groupValue: _userType,
                                              onChanged: (type) =>
                                                  onChangeAccountType(type)),
                                          Text("Student",
                                              style: _userTypeError
                                                  ? CustomTheme.errorText
                                                  : CustomTheme.pinkText)
                                        ]),
                                        Row(children: [
                                          Radio<int>(
                                              //usertype changed to int
                                              activeColor:
                                                  CustomTheme.pinkColor,
                                              value: 0,
                                              groupValue: _userType,
                                              onChanged: (type) =>
                                                  onChangeAccountType(type)),
                                          Text(
                                            "Company",
                                            style: _userTypeError
                                                ? CustomTheme.errorText
                                                : CustomTheme.pinkText,
                                          ),
                                        ]),
                                      ],
                                    )),
                                SizedBox(
                                    child: _userTypeError
                                        ? Text(
                                            _userTypeMessage,
                                            style: CustomTheme.errorText,
                                          )
                                        : null)
                              ])),
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
