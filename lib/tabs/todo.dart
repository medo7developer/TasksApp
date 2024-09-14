import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todooapp/edit_task/edit_task.dart';
import 'package:todooapp/model/todo_dm.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/utilits/app_colors.dart';
import 'package:todooapp/utilits/app_style.dart';

class Todo extends StatefulWidget {
  Todo({super.key, required this.item});

  TodoDm item;

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> deleteTask(TodoDm item) async {
    CollectionReference todosCollection = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);

    try {
      await todosCollection.doc(item.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حذف المهمة بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء حذف المهمة: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await deleteTask(widget.item);
            },
            foregroundColor: AppColors.white,
            label: 'delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24)),
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTask(task: widget.item),
                ),
              );
            },
            foregroundColor: AppColors.white,
            label: 'Edit',
            backgroundColor: Colors.teal,
            icon: Icons.edit,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24)),
          )
        ],
      ),      child: GestureDetector(
        onTap: toggleTaskState,
        child: Container(
          height: MediaQuery.of(context).size.height * .13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: widget.item.isDone ? Colors.green[100] : AppColors.white),
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 26),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Row(
            children: [
              buildVerticalLine(context),
              buildTodoInfo(),
              buildTodoState(),
            ],
          ),
        ),
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height * .07,
    width: 4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.item.isDone ? Colors.green : AppColors.primaryColor),
  );

  buildTodoInfo() => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(
            widget.item.title,
            maxLines: 1,
            style: AppStyle.titlesTextStyle.copyWith(
              fontSize: 20,
              color: widget.item.isDone ? Colors.green : Colors.black,
            ),
          ),
          Spacer(),
          Text(
            widget.item.description,
            style: AppStyle.bodyTextStyle.copyWith(
              color: widget.item.isDone ? Colors.green : Colors.black,
            ),
          ),
          Spacer(),
        ],
      ),
    ),
  );

  buildTodoState() => Container(
    width: MediaQuery.of(context).size.width * .14,
    decoration: BoxDecoration(
        color: widget.item.isDone ? Colors.green : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Center(
      child: widget.item.isDone
          ? Text(
        'Done',
        style: AppStyle.titlesTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 16
        ),
      )
          : Icon(
        Icons.check,
        color: AppColors.white,
      ),
    ),
  );

  void toggleTaskState() {
    setState(() {
      widget.item.isDone = !widget.item.isDone;
    });

    CollectionReference todosCollection = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);
    todosCollection.doc(widget.item.id).update({
      'isDone': widget.item.isDone,
    });
  }
}
