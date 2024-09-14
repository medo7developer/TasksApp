import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDm {
  static const String collectionName = 'todo';
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  TodoDm({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  TodoDm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    Timestamp timeStamp = json['date'];
    date = timeStamp.toDate();
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'isDone': isDone,
  };
}