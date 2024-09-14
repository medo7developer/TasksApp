import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/model/todo_dm.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/utilits/app_style.dart';
import 'package:todooapp/utilits/date_time_extension.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddBottomSheet(),
        );
      },
    );
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController tittleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'add new Task',
              style: AppStyle.bottomSheetTitle,
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: tittleController,
              decoration: InputDecoration(hintText: 'Enter Tak title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: discriptionController,
              decoration: InputDecoration(hintText: 'Enter Tak description'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Select Data',
              style: AppStyle.bottomSheetTitle,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Text(
                '${selectedDateTime.toFormateTime}',
                textAlign: TextAlign.center,
              ),
              onTap: showMyDatePicker,
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  addToDoToFirestore();
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }

  void addToDoToFirestore() {
    CollectionReference todosCollections = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);
    DocumentReference doc = todosCollections.doc();
    TodoDm todoDm = TodoDm(
        id: doc.id,
        title: tittleController.text,
        description: discriptionController.text,
        date: selectedDateTime,
        isDone: false);
    doc
        .set(todoDm.toJson())
        .then((_) => {})
        .onError((error, stackTrace) => {})
        .timeout(Duration(milliseconds: 500), onTimeout: () {
      Navigator.pop(context);
      return <dynamic, dynamic>{};
    });
  }

  void showMyDatePicker() async {
    selectedDateTime = await showDatePicker(
            context: context,
            initialDate: selectedDateTime,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        selectedDateTime;
    setState(() {});
  }
}
