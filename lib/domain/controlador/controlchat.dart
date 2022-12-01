import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ControlChat extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> crearChat(Map<String, dynamic> datos) async {
    await _db.collection('chat').doc().set(datos).catchError((e) {});
  }

  Stream<QuerySnapshot> leerChat() {
    Stream<QuerySnapshot> listado =
        _db.collection('chat').orderBy("fecha", descending: true).snapshots();

    return listado;
  }
}
