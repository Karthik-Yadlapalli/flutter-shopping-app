// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final rePwdCtrl = TextEditingController();

  String errorText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onSubmitted: (value) {
                        nameCtrl.text = value;
                      },
                      controller: nameCtrl,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailCtrl,
                      onSubmitted: (value) {
                        if (value.contains('@') &&
                            (value.endsWith('.com') || value.endsWith('.in'))) {
                          emailCtrl.text = value;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onSubmitted: (value) {
                        if (value.contains(RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                          setState(() {
                            errorText =
                                'Password must have atleast 8 characters, and must include atleast one number, special symbol, uppercase and lowercase alphabets';
                          });
                        }
                      },
                      obscureText: true,
                      controller: pwdCtrl,
                      decoration: InputDecoration(
                          errorText: errorText.isEmpty ? null : errorText,
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: rePwdCtrl,
                      onEditingComplete: () {
                        if (rePwdCtrl.text != pwdCtrl.text) {
                          setState(() {
                            errorText = 'Password not matched';
                          });
                        }
                      },
                      decoration: InputDecoration(
                          errorText: errorText.isEmpty ? null : errorText,
                          labelText: 'Re-enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Create')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Center(
                      child: Text(
                        'Other Sign-in Options',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 88, 109, 99)),
                            height: 30,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Google',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 88, 109, 99)),
                            height: 30,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Facebook',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
