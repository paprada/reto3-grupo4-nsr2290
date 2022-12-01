import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ControlAddUser extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> crearUsuarios(Map<String, dynamic> datos, String uid) async {
    await _db.collection('usuarios').doc().set(datos).catchError((e) {});
  }

  Stream<QuerySnapshot> leerUsuarios() {
    Stream<QuerySnapshot> listado = _db
        .collection('usuarios')
        .orderBy("fecha", descending: true)
        .snapshots();

    return listado;
  }
}
