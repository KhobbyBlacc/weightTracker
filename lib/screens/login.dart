// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/sign_up.dart';

import '../constants/colors.dart';
import '../network/preferences_service.dart';
import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //shared_preferences for userLogin details
  // final _preferenceService = PreferencesServices();

  //controllers to accept details to db
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Weight Tracker')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: appPadding, vertical: appPadding / 2),
        child: Padding(
          padding: const EdgeInsets.all(27),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.mail_outline_outlined),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Passwoard',
                      prefixIcon: const Icon(Icons.password_outlined),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text("I don't have an Account..."),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => SignUp()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        _login();
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => Home()));
                      },
                      child: const Text('Log In'))
                ],
              )),
        ),
      ),
    );
  }

  void _login() async {
//sign in with formKey email&password and proceed to homeScreen

    if (_formKey.currentState!.mounted) {
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((uid) {
        uid.user.toString();
        print(uid.user.toString());
        //  print(uid),
        final userModel = UserModel(
            email: _emailController.text, password: _passwordController.text);

        Fluttertoast.showToast(msg: "Login Successful ");
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => Home()),
          );
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }
}
