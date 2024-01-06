import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String accountId;
  String accountName;

  Timestamp? createdTime;
  Timestamp? updatedTime;

  Account(
      {required this.accountId,
      required this.accountName,
      this.createdTime,
      this.updatedTime});
}
