import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ControlChatPrivado extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _userdestino = "".obs;
  final _emaildestino = "".obs;

  String get userdestino => _userdestino.value;
  String get emaildestino => _emaildestino.value;

  Future<void> actualizarDestino(String userd, String emaild) async {
    _userdestino.value = userd;
    _emaildestino.value = emaild;
  }

  Future<void> crearChatPrivado(Map<String, dynamic> datos) async {
    await _db.collection('chatprivado').doc().set(datos).catchError((e) {});
  }

  Stream<QuerySnapshot> leerChatPrivado(String email) {
    Stream<QuerySnapshot> listado = _db
        .collection('chatprivado')
        .where("email_destino", isEqualTo: email)
        .snapshots();

    return listado;
  }
}
