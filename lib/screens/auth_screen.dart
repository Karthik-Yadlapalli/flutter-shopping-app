// ignore_for_file: constant_identifier_names, sized_box_for_whitespace, body_might_complete_normally_nullable, library_private_types_in_public_api, prefer_final_fields, depend_on_referenced_packages, avoid_print
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exceptions.dart';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 147, 248, 182).withOpacity(0.5),
                    const Color.fromARGB(221, 86, 188, 121).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
            ),
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                          'https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg',
                          fit: BoxFit.fill),
                    ),
                  ),
                  const AuthCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'userName': '',
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  //controllers
  final _pwdCtrl = TextEditingController();
  final _usrNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  //focusNodes
  final _usrNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _pwdFocusNode = FocusNode();
  final _pwdConfFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _usrNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _pwdFocusNode.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('An error occurred'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        //signUp
        await Provider.of<Auth>(context, listen: false).signUP(
            _authData['userName']!,
            _authData['email']!,
            _authData['password']!);
      }
    } on HttpExceptions catch (error) {
      var errormessage = 'Authentication Failed!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errormessage = 'Email already exist';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errormessage = 'Email is invalid';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errormessage = 'Invalid Password';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errormessage = 'User not found with this email, Please signUp';
      }
      _showErrorDialog(errormessage);
    } catch (error) {
      const errormessage = 'Could not sign-in, Please try again later';
      _showErrorDialog(errormessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top: 6),
        height: _authMode == AuthMode.Signup ? 470 : 280,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 470 : 280),
        width: deviceSize.width * 0.85,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (_authMode == AuthMode.Signup)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usrNameCtrl,
                    focusNode: _usrNameFocusNode,
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Urse Name';
                      }
                    },
                    onSaved: (value) {
                      _authData['userName'] = value!;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailCtrl,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains('@') ||
                        (!value.endsWith('.com') && !value.endsWith('.in'))) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_pwdFocusNode);
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  obscureText: true,
                  controller: _pwdCtrl,
                  focusNode: _pwdFocusNode,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains(RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                      return 'Need min 8 char, and must include  0-9, A-Z and a-z, special symbol';
                    }
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_pwdConfFocusNode);
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
              ),
              if (_authMode == AuthMode.Signup)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    focusNode: _pwdConfFocusNode,
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value!.isEmpty) {
                              return 'Please conform password!';
                            } else if (value != _pwdCtrl.text) {
                              return 'Password didn\'t match';
                            }
                          }
                        : null,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _authMode == AuthMode.Login
                    ? RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign up',
                                  style: const TextStyle(
                                      color: Colors.blueAccent, fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _switchAuthMode)
                            ]),
                      )
                    : RichText(
                        text: TextSpan(
                            text: 'Already a User! ',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Login',
                                  style: const TextStyle(
                                      color: Colors.blueAccent, fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _switchAuthMode)
                            ]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
