import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/network/preferences_service.dart';
import 'package:weight_tracker/screens/login.dart';

import 'constants/colors.dart';
import 'network/auth.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferencesServices.init();
  PreferencesServices.clearUserPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: white,
          primarySwatch: Colors.green,
        ),
        home: AuthenticationWrapper(),
      ),
    );
    //
  }
}

class AuthenticationWrapper extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  // const AuthenticationWrapper();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
   // print(firebaseUser.email);
    // final authProvider = Provider.of<AuthenticationService>(context);
    // authProvider.signOut();

    if (firebaseUser != null) {
      return Home();
    }
    return Login();
  }
}
