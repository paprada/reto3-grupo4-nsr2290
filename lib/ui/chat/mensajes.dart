import 'package:chat_firebase2/domain/controlador/controlchat.dart';
import 'package:chat_firebase2/domain/controlador/controluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mensaje extends StatefulWidget {
  const Mensaje({super.key});

  @override
  State<Mensaje> createState() => _MensajeState();
}

class _MensajeState extends State<Mensaje> {
  ControlAuth ca = Get.find();
  ControlChat cc = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: cc.leerChat(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> resultado) {
          return ListView.builder(
              itemCount: resultado.data!.docs.length,
              itemBuilder: (context, i) {
                return Card(
                  color: resultado.data!.docs[i].get("email").toString() ==
                          ca.emailr
                      ? Colors.green
                      : Colors.blueGrey,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: resultado.data!.docs[i].get("email").toString() ==
                              ca.emailr
                          ? const Icon(Icons.arrow_forward)
                          : const Icon(Icons.arrow_back),
                    ),
                    title: Text(
                      resultado.data!.docs[i].get("mensaje").toString(),
                      textAlign:
                          resultado.data!.docs[i].get("email").toString() ==
                                  ca.emailr
                              ? TextAlign.start
                              : TextAlign.end,
                    ),
                    subtitle: Text(
                        resultado.data!.docs[i].get("email").toString(),
                        textAlign:
                            resultado.data!.docs[i].get("email").toString() ==
                                    ca.emailr
                                ? TextAlign.start
                                : TextAlign.end),
                  ),
                );
              });
        });
  }
}
