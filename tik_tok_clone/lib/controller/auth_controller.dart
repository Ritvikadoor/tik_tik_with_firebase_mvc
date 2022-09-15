import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/models/user_model.dart' as model;
import 'package:tik_tok_clone/views/screens/auth/login_screens.dart';
import 'package:tik_tok_clone/views/screens/ui_screens/home_screen.dart';

class AuthController extends GetxController {
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  File? get ProfilePhoto => _pickedImage.value;

  User get user => _user.value!;
  static AuthController instance = Get.find();
  Future<String> uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      Get.snackbar("No Pic", "Unsuccessfull");
    }
    Get.snackbar("Profile Picture", "Successfully Uploaded Profile Picture");
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save our user to out auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await uploadToStorage(image);
        model.User user = model.User(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: cred.user!.uid);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Please Enter all fields');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('log success');
      } else {
        Get.snackbar('Error Login Account', 'Please Enter all fields');
      }
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString());
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
