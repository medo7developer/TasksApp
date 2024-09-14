import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/model/todo_dm.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/utilits/app_style.dart';

class EditTask extends StatefulWidget {
  final TodoDm task;

  EditTask({required this.task, Key? key}) : super(key: key);

  static const String routeName = '/editTask';

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> updateTask() async {
    CollectionReference todosCollection = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);

    try {
      await todosCollection.doc(widget.task.id).update({
        'title': titleController.text,
        'description': descriptionController.text,
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحديث المهمة: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task', style: AppStyle.appBarStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateTask,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
