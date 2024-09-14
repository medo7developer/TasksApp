import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/model/todo_dm.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/tabs/todo.dart';
import 'package:todooapp/utilits/app_colors.dart';
import 'package:todooapp/utilits/app_style.dart';
import 'package:todooapp/utilits/date_time_extension.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => ListTabState();
}

class ListTabState extends State<ListTab> {
  DateTime seleCalender = DateTime.now();
  List<TodoDm> todoList = [];

  @override
  void initState() {
    super.initState();
    getTodosListFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);

    DateTime startOfDay = DateTime(
        seleCalender.year, seleCalender.month, seleCalender.day, 0, 0, 0);
    DateTime endOfDay = DateTime(
        seleCalender.year, seleCalender.month, seleCalender.day, 23, 59, 59);

    return Column(
      children: [
        buildCalender(),
        Expanded(
          flex: 70,
          child: StreamBuilder<QuerySnapshot>(
            stream: todoCollection
                .where('date', isGreaterThanOrEqualTo: startOfDay)
                .where('date', isLessThanOrEqualTo: endOfDay)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No tasks for this date'));
              }

              List<TodoDm> todoList = snapshot.data!.docs
                  .map((doc) =>
                      TodoDm.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();

              return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Todo(
                    item: todoList[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  buildCalender() {
    return Expanded(
      flex: 27,
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.bgColor,
              ),
            ),
          ],
        ),
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          focusDate: seleCalender,
          lastDate: DateTime.now().add(Duration(days: 365)),
          itemBuilder: (context, date, isSelected, onTap) {
            return InkWell(
              onTap: () {
                setState(() {
                  seleCalender = date;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                  children: [
                    Spacer(),
                    Text(date.dayName,
                        style: isSelected
                            ? AppStyle.SelectedCalenderDayStyle
                            : AppStyle.unSelectedCalenderDayStyle),
                    Spacer(),
                    Text(date.day.toString(),
                        style: isSelected
                            ? AppStyle.SelectedCalenderDayStyle
                            : AppStyle.unSelectedCalenderDayStyle),
                    Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  void getTodosListFromFirestore() async {
    DateTime startOfDay = DateTime(
        seleCalender.year, seleCalender.month, seleCalender.day, 0, 0, 0);
    DateTime endOfDay = DateTime(
        seleCalender.year, seleCalender.month, seleCalender.day, 23, 59, 59);

    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(TodoDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);

    QuerySnapshot querySnapshot = await todoCollection
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todoList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDm.fromJson(json);
    }).toList();

    setState(() {});
  }
}
