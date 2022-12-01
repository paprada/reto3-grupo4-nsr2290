import 'package:chat_firebase2/domain/controlador/controlchatprivado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controlador/controlchat.dart';
import '../../domain/controlador/controluser.dart';

class MensajePrivado extends StatefulWidget {
  const MensajePrivado({super.key});

  @override
  State<MensajePrivado> createState() => _MensajePrivadoState();
}

class _MensajePrivadoState extends State<MensajePrivado> {
  ControlAuth ca = Get.find();
  ControlChatPrivado ccp = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ccp.leerChatPrivado(ca.emailr),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> resultado) {
          return ListView.builder(
              itemCount: resultado.data!.docs.length,
              itemBuilder: (context, i) {
                return Card(
                  color:
                      resultado.data!.docs[i].get("email_destino").toString() ==
                              ca.emailr
                          ? Colors.green
                          : Colors.blueGrey,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: resultado.data!.docs[i]
                                  .get("email_destino")
                                  .toString() ==
                              ca.emailr
                          ? const Icon(Icons.arrow_forward)
                          : const Icon(Icons.arrow_back),
                    ),
                    title: Text(
                      resultado.data!.docs[i].get("mensaje").toString(),
                      textAlign: resultado.data!.docs[i]
                                  .get("email_destino")
                                  .toString() ==
                              ca.emailr
                          ? TextAlign.start
                          : TextAlign.end,
                    ),
                    subtitle: Text(
                        resultado.data!.docs[i].get("email_origen").toString(),
                        textAlign: resultado.data!.docs[i]
                                    .get("email_destino")
                                    .toString() ==
                                ca.emailr
                            ? TextAlign.start
                            : TextAlign.end),
                  ),
                );
              });
        });
  }
}
