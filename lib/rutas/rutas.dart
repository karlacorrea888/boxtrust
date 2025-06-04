import 'package:boxtrust/paginas/mis_buzones.dart';
import 'package:boxtrust/paginas/mision.dart';
import 'package:boxtrust/paginas/novedades.dart';
import 'package:boxtrust/paginas/objetivo.dart';
import 'package:boxtrust/paginas/paquetes.dart';
import 'package:boxtrust/paginas/vision.dart';
import 'package:flutter/material.dart';
import 'package:boxtrust/paginas/principal.dart';
import 'package:boxtrust/paginas/inicio.dart';
import 'package:boxtrust/paginas/registro.dart';
import 'package:boxtrust/paginas/pantalla_usuario.dart';
import 'package:boxtrust/paginas/pantalla_gerente.dart';
import 'package:boxtrust/paginas/pantalla_perfil.dart';

import '../paginas/cambiar_contraseña.dart';
import '../paginas/estado_buzon.dart';

class AppRoutes {
  static const String principal = '/';
  static const String login = '/inicio';
  static const String registro = '/registro';
  static const String usuario = '/bienvenidaUsuario';
  static const String gerente = '/bienvenidaGerente';
  static const String buzones = '/misbuzones';
  static const String estadoBuzon = '/estadobuzon';
  static const String novedad = '/novedades';
  static const String objetivo = '/objetivoempresa';
  static const String mision = '/misionempresa';
  static const String vision = '/visionempresa';
  static const String paquetes = '/paquetestecnologicos';
  static const String perfil = '/perfilusuario';
  static const String contrasena = '/cambiarcontrasena';

  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case principal:
        return MaterialPageRoute(builder: (_) => const PrincipalPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registro:
        return MaterialPageRoute(builder: (_) => const RegistroScreen());
      case usuario:
        return MaterialPageRoute(builder: (_) => const PantallaUsuario());
      case gerente:
        return MaterialPageRoute(builder: (_) => const PantallaGerente());
      case buzones:
        return MaterialPageRoute(builder: (_) => const MisBuzones());
      case novedad:
        return MaterialPageRoute(builder: (_) => const Novedades());
      case objetivo:
        return MaterialPageRoute(builder: (_) => const Objetivo());
      case mision:
        return MaterialPageRoute(builder: (_) => const Mision());
      case vision:
        return MaterialPageRoute(builder: (_) => const Vision());
      case paquetes:
        return MaterialPageRoute(builder: (_) => const Paquetes());
      case perfil:
        return MaterialPageRoute(builder: (_) => const PantallaPerfil());
      case contrasena:
        return MaterialPageRoute(builder: (_) => const CambiarContrasena());
      case estadoBuzon:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => EstadoBuzon(
                tituloBuzon: args['tituloBuzon'],
                cerrado: args['cerrado'],
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('Ruta no encontrada: ${settings.name}'),
                ),
              ),
        );
    }
  }
}
