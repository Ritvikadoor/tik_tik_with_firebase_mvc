import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment {
  String username;
  String comment;
  final dataPublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment({
    required this.comment,
    required this.dataPublished,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.username,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "dataPublished": dataPublished,
        "likes": likes,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "id": id,
      };
  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        comment: snapshot['username'],
        dataPublished: snapshot['dataPublished'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
