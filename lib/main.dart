import 'package:chat_firebase2/domain/controlador/controladduser.dart';
import 'package:chat_firebase2/domain/controlador/controlchat.dart';
import 'package:chat_firebase2/domain/controlador/controlchatprivado.dart';
import 'package:chat_firebase2/domain/controlador/controluser.dart';
import 'package:chat_firebase2/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyC5LglNozUNF2uGMlFPMFes3CsccwYIflQ",
              authDomain: "mintic-42f73.firebaseapp.com",
              projectId: "mintic-42f73",
              storageBucket: "mintic-42f73.appspot.com",
              messagingSenderId: "23948098148",
              appId: "1:23948098148:web:e6f54efd8af319dd32fd71"))
      : await Firebase.initializeApp();

  Get.put(ControlChat());
  Get.put(ControlAuth());
  Get.put(ControlAddUser());
  Get.put(ControlChatPrivado());
  runApp(const App());
}
