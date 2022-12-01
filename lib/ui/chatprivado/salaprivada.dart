import 'package:chat_firebase2/domain/controlador/controlchat.dart';
import 'package:chat_firebase2/domain/controlador/controlchatprivado.dart';
import 'package:chat_firebase2/domain/controlador/controluser.dart';
import 'package:chat_firebase2/ui/chatprivado/mensajeprivado.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalaPrivada extends StatefulWidget {
  const SalaPrivada({super.key});

  @override
  State<SalaPrivada> createState() => _SalaPrivadaState();
}

class _SalaPrivadaState extends State<SalaPrivada> {
  @override
  Widget build(BuildContext context) {
    TextEditingController mensaje = TextEditingController();
    ControlAuth ca = Get.find();
    ControlChat cc = Get.find();
    ControlChatPrivado ccp = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sala de chat de - ${ca.emailr}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(child: MensajePrivado()),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mensaje,
                    decoration: const InputDecoration(hintText: 'Mensaje'),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (mensaje.text.isNotEmpty) {
                        final datos = {
                          'email_origen': ca.emailr,
                          'email_destino': ccp.emaildestino,
                          'fecha': DateTime.now(),
                          'mensaje': mensaje.text
                        };
                        ccp.crearChatPrivado(datos);
                        mensaje.clear();
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
