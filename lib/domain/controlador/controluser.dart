import 'package:chat_firebase2/domain/controlador/controladduser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlAuth extends GetxController {
  final FirebaseAuth authf = FirebaseAuth.instance;
  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _email = "".obs;
  final Rx<dynamic> _mensajes = "".obs;

  String get emailr => _email.value;
  String get uid => _uid.value;

  Future<void> reiniciar() async {
    _email.value = "";
    _email.refresh();
  }

  Future<void> addUser(String u, String p, String nu) async {
    ControlAddUser cau = Get.find();
    try {
      UserCredential usuario =
          await authf.createUserWithEmailAndPassword(email: u, password: p);
      print(usuario);

      _uid.value = usuario.user!.uid;
      _email.value = usuario.user!.email;

      dynamic datos = {
        'email': _email.value,
        'nombre': nu,
        'fecha': DateTime.now(),
        'uid': _uid.value
      };
      cau.crearUsuarios(datos, uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('Contraseña Debil');
      } else if (e.code == 'email-already-in-use') {
        _uid.value = "";
        _email.value = "";
        return Future.error('Email ya esta en Uso');
      }
    }
  }

  Future<void> ingresarEmail(String u, String p) async {
    try {
      UserCredential usuario =
          await authf.signInWithEmailAndPassword(email: u, password: p);
      _uid.value = usuario.user!.uid;
      _email.value = usuario.user!.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('Usuario No Encontrado');
      } else if (e.code == 'wrong-password') {
        return Future.error('Contraseña Incorrecta');
      }
    }
  }
}
