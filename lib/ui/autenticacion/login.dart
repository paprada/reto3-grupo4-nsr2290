import 'package:chat_firebase2/domain/controlador/controluser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nu = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();
  ControlAuth ca = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ingresar al chat'),
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.messenger_rounded,
                  size: 50,
                ),
              ),
              TextField(
                controller: nu,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passw,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        ca.ingresarEmail(email.text, passw.text).then((value) {
                          if (ca.emailr != "") {
                            Get.offAllNamed('/listausuarios');
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Validacion de Usuarios',
                              message: 'Usuario o Contraseña Invalidos',
                              icon: Icon(Icons.warning),
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.green,
                            ));
                          }
                        }).catchError((e) {
                          Get.showSnackbar(GetSnackBar(
                            title: 'Validacion de Usuarios',
                            message: '$e',
                            icon: const Icon(Icons.warning),
                            duration: const Duration(seconds: 5),
                            backgroundColor: Colors.red,
                          ));
                        });
                      },
                      child: const Text('Ingresar')),
                  ElevatedButton(
                      onPressed: () {
                        ca
                            .addUser(email.text, passw.text, nu.text)
                            .then((value) {
                          if (ca.emailr != "") {
                            Get.offAllNamed('/listausuarios');
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Validacion de Usuarios',
                              message: 'Usuario o Contraseña Invalidos',
                              icon: Icon(Icons.warning),
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }).catchError((e) {
                          Get.showSnackbar(GetSnackBar(
                            title: 'Validacion de Usuarios',
                            message: '$e',
                            icon: const Icon(Icons.warning),
                            duration: const Duration(seconds: 5),
                            backgroundColor: Colors.red,
                          ));
                        });
                      },
                      child: const Text('Registrarse'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
