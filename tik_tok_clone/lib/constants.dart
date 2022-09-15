import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_clone/controller/auth_controller.dart';
import 'package:tik_tok_clone/views/screens/ui_screens/add_screen_vedio.dart';
import 'package:tik_tok_clone/views/screens/ui_screens/search_screen.dart';
import 'package:tik_tok_clone/views/screens/ui_screens/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const whiteColor = Colors.white;
/////height/////////////////
const height25 = SizedBox(
  height: 25,
);
const height30 = SizedBox(
  height: 30,
);
const height100 = SizedBox(
  height: 100,
);

/////FireBase constants
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//////Controller
var authController = AuthController.instance;
///////////Pages

List pages = [
  VedioScreen(),
  SearchScreen(),
  AddVedioScreen(),
  Text('Messages Screen'),
  Text('Profile Screen'),
];
