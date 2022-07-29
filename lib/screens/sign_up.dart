// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/home.dart';
import 'package:weight_tracker/screens/login.dart';

import '../constants/colors.dart';
import '../network/preferences_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //shared_preferences for userLogin details
  final _preferenceService = PreferencesServices();

  //controllers to accept details to db
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;

  final _formKey = GlobalKey<FormState>();

  void _register() async {

    //create model in firestore

    final UserModel userModel = UserModel();

    userModel.email = _emailController.text;
    userModel.name = _nameController.text;
    userModel.password = _passwordController.text;
    userModel.age = _ageController.text;
    userModel.phone = _phoneController.text;

    //login after _auth
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((uid) {
      // print(uid),
      final userModel = UserModel(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          age: _ageController.text,
          phone: _phoneController.text);
      Fluttertoast.showToast(msg: "Account created successfully :) ");
      PreferencesServices.saveUserPreference(userModel);
      saveData(userModel);
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => Home()));
    });
    print('user: $userModel');
  }

  saveData(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.email)
        .set(userModel.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: appPadding, vertical: appPadding / 2),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: const Icon(Icons.people_outlined),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      prefixIcon: const Icon(Icons.people_outline),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                    height: 10,
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'phone',
                      prefixIcon: const Icon(Icons.people_outline),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
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
                      const Text("I already have an Account..."),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        _register();
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => Home()));
                      },
                      child: const Text('Submit')),
                ],
              )),
        ),
      ),
    );
  }
}
