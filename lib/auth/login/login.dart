import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/auth/register/register.dart';
import 'package:todooapp/home.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/utilits/app_style.dart';
import 'package:todooapp/utilits/constants.dart';

import '../../utilits/dialog_utilits.dart';

class Login extends StatelessWidget {
  Login({super.key});

  static const String routeName = 'login';

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: AppStyle.appBarStyle.copyWith(fontSize: 23),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back !',
              style: AppStyle.titlesTextStyle.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailText,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordText,
              decoration: InputDecoration(hintText: 'Paaword'),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 1, 50)),
                textStyle: MaterialStateProperty.all(AppStyle.bottomSheetTitle),
                alignment: AlignmentGeometry.lerp(
                    Alignment.centerLeft, Alignment.centerLeft, double.nan),
              ),
              onPressed: () {
                signIn(context);
              },
              child: Text(
                'Login',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, Register.routeName),
                child: Text(
                  'Create Account',
                  style: AppStyle.bodyTextStyle
                      .copyWith(color: Colors.black26, fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    try {
      showLoading(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailText.text, password: passwordText.text);
      UserDm.currentUser = await getUserFromFireStore(credential.user!.uid);
      if (context.mounted) {
        hideLoadin(context);
        Navigator.pushNamed(context, MyHome.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      hideLoadin(context);
      String message;
      if (authError.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (authError.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = Constants.defaultErrorMessage;
      }
      if (context.mounted) {
        showMessage(context,
            title: "Error", body: message, negButtonTitle: "Ok");
      }
    }
  }

  Future<UserDm> getUserFromFireStore(String id) async{
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference userDoc = collectionReference.doc(id);
    DocumentSnapshot userSnapShot = await userDoc.get();
    return UserDm.fromJson(userSnapShot.data() as Map<String, dynamic>);
  }

}
