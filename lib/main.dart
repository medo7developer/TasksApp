import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/auth/register/register.dart';
import 'package:todooapp/home.dart';
import 'package:todooapp/utilits/app_theme.dart';

import 'auth/login/login.dart';
import 'edit_task/edit_task.dart';
import 'firebase_options.dart';
import 'model/todo_dm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      routes: {
        MyHome.routeName: (_) => MyHome(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        EditTask.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as TodoDm;
          return EditTask(task: args);
        },
      },
      initialRoute: Login.routeName,
    );
  }
}
