import 'package:firebasetut1/api/food_api.dart';
import 'package:firebasetut1/model/user.dart';
import 'package:firebasetut1/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  IntUser _user = IntUser();
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
    } else {
      signUp(_user, authNotifier);
    }
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Display Name",
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.white,
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Display Name is required';
          }
          if (value.length < 5 || value.length > 12) {
            return 'Display Name must be betweem 5 and 12 characters';
          }

          return null;
        }
      },
      onSaved: (String? value) {
        if (value != null) {
          _user.displayName = value;
        }
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: 'julian@food.com',
      style: const TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.white,
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Email is required';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        }
      },
      onSaved: (String? value) {
        if (value != null) {
          _user.email = value;
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      style: const TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.white,
      obscureText: true,
      controller: _passwordController,
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Password is required';
          }

          if (value.length < 5 || value.length > 20) {
            return 'Password must be betweem 5 and 20 characters';
          }

          return null;
        }
      },
      onSaved: (String? value) {
        if (value != null) {
          _user.password = value;
        }
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      style: const TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.white,
      obscureText: true,
      validator: (String? value) {
        if (value != null) {
          if (_passwordController.text != value) {
            return 'Passwords do not match';
          }

          return null;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building login screen');
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
            child: Column(
              children: [
                const Text(
                  'Please Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(
                  height: 32,
                ),
                _authMode == AuthMode.Signup
                    ? _buildDisplayNameField()
                    : Container(),
                _buildEmailField(),
                _buildPasswordField(),
                _authMode == AuthMode.Signup
                    ? _buildConfirmPasswordField()
                    : Container(),
                SizedBox(height: 32),
                ButtonTheme(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text(
                      'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        _authMode = _authMode == AuthMode.Login
                            ? AuthMode.Signup
                            : AuthMode.Login;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                ButtonTheme(
                  minWidth: 200,
                  child: ButtonTheme(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => _submitForm(),
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Signup',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
