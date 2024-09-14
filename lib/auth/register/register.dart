import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/home.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/utilits/app_style.dart';
import 'package:todooapp/utilits/constants.dart';
import 'package:todooapp/utilits/dialog_utilits.dart';

class Register extends StatelessWidget {
  Register({super.key});

  static const String routeName = 'regiter';

  TextEditingController userNameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: AppStyle.appBarStyle.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameText,
              decoration: InputDecoration(hintText: 'userName'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailText,
              decoration: InputDecoration(hintText: 'E-mail'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordText,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .18,
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
                signUp(context);
              },
              child: Text(
                'Register',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(BuildContext context) async {
    try {
      showLoading(context);
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailText.text, password: passwordText.text);

      UserDm.currentUser = UserDm(
          id: credential.user!.uid,
          email: emailText.text,
          userName: userNameText.text);
      registerUserInFireStore(UserDm.currentUser!);

      if (context.mounted) {
        hideLoadin(context);
        Navigator.pushNamed(context, MyHome.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      hideLoadin(context);
      String message;
      if (authError.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (authError.code == 'email-already-in-use') {
        message = 'email-already-in-use';
      } else {
        message = Constants.defaultErrorMessage;
      }
      if (context.mounted) {
        showMessage(context,
            title: "Error", body: message, negButtonTitle: "Ok");
      }
    } catch (authError) {
      if (context.mounted) {
        hideLoadin(context);
        showMessage(context,
            title: "Error",
            body: Constants.defaultErrorMessage,
            negButtonTitle: "Ok");
      }
    }
  }

  void registerUserInFireStore(UserDm user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference newUserDoc = collectionReference.doc(user.id);
    await newUserDoc.set(user.toJson());
  }
}
