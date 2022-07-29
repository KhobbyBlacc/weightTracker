import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../network/auth.dart';
import '../network/preferences_service.dart';
import 'login.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
//get userinfo from userModel from shared_preferences for display
  UserModel? userModel = UserModel();
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() {
    userModel = PreferencesServices.getUserPreferences();
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.people_outlined),
          title: const Text("My Profile"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          width: double.maxFinite,
            padding: const EdgeInsets.all(30),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: '${userModel?.name.toString()}',
                    prefixIcon: const Icon(Icons.people_outlined),
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
                  decoration: InputDecoration(
                    hintText: '${userModel?.email.toString()}',
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
                  decoration: InputDecoration(
                    hintText: '${userModel?.age.toString()}',
                    prefixIcon: const Icon(Icons.people_outlined),
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
                  decoration: InputDecoration(
                    hintText: '${userModel?.phone.toString()}',
                    prefixIcon: const Icon(Icons.phone_iphone_outlined),
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      context.read<AuthenticationService>().signOut();
                      PreferencesServices.clearUserPreferences();
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    child: const Text('Log Out'))
              ],
            ))));
  }
}
