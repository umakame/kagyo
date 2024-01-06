import 'package:cloud_firestore/cloud_firestore.dart';

class Kagyo {
  String id;
  String userID;
  String type;
  String title;
  int? count;
  int? time;
  String? specificedTime;
  bool isDone;
  Timestamp createdTime;
  Timestamp updatedTime;

  Kagyo({
    required this.id,
    required this.userID,
    required this.type,
    required this.title,
    this.count,
    this.time,
    this.specificedTime,
    required this.isDone,
    required this.createdTime,
    required this.updatedTime
  });
}
