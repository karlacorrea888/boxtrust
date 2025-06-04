import 'package:boxtrust/servicios/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:boxtrust/rutas/rutas.dart';

void main() {
  final authService = AuthService.instance;

  const gerentes = [
    'karla@boxtrust.com',
    'fernanda@boxtrust.com',
    'paola@boxtrust.com',
    'angel@boxtrust.com',
    'kevin@boxtrust.com',
  ];

  const usuarios = [
    'paty@gmail.com',
    'esme@gmail.com',
    'eric@gmail.com',
    'juan@gmail.com',
    'horacio@gmail.com',
  ];

  for (var correo in [...gerentes, ...usuarios]) {
    authService.registrarUsuario(correo.toLowerCase(), '123456');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxTrust',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.principal,
      onGenerateRoute: AppRoutes.generarRuta,
    );
  }
}
