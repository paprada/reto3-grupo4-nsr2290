import 'package:chat_firebase2/domain/controlador/controladduser.dart';
import 'package:chat_firebase2/domain/controlador/controlchatprivado.dart';
import 'package:chat_firebase2/domain/controlador/controluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({super.key});

  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  ControlAuth ca = Get.find();
  ControlAddUser cau = Get.find();
  ControlChatPrivado ccp = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Contactos'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/salachat');
                },
                icon: const Icon(Icons.group)),
            IconButton(
                onPressed: () {
                  ca.reiniciar().then((value) => Get.offAllNamed('/login'));
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
        body: StreamBuilder(
            stream: cau.leerUsuarios(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> resultado) {
              return ListView.builder(
                  itemCount: resultado.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: Colors.amber,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(resultado.data!.docs[i]
                              .get("nombre")
                              .substring(0, 1)),
                        ),
                        title: Text(resultado.data!.docs[i].get("nombre")),
                        subtitle: Text(resultado.data!.docs[i].get("email")),
                        trailing: IconButton(
                            onPressed: () {
                              ccp
                                  .actualizarDestino(
                                      resultado.data!.docs[i].get("nombre"),
                                      resultado.data!.docs[i].get("email"))
                                  .then((value) => Get.toNamed('/salaprivada'));
                            },
                            icon: const Icon(Icons.message_sharp)),
                      ),
                    );
                  });
            }));
  }
}
