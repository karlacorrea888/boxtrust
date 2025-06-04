import 'package:boxtrust/paginas/inicio.dart';
import 'package:boxtrust/paginas/mis_buzones.dart';
import 'package:boxtrust/paginas/novedades.dart';
import 'package:boxtrust/paginas/pantalla_perfil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BuzonesApp());
}

class BuzonesApp extends StatelessWidget {
  const BuzonesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buzones App',
      debugShowCheckedModeBanner: false,
      home: const PantallaUsuario(),
    );
  }
}

const historial = [
  {
    "buzon": "Buzón Principal",
    "hora": "10:30",
    "estado": "Cerrado",
    "fecha": "03/05/2025",
  },
  {
    "buzon": "Buzón Principal",
    "hora": "10:25",
    "estado": "Abierto",
    "fecha": "03/05/2025",
  },
  {
    "buzon": "Buzón 1",
    "hora": "19:30",
    "estado": "Cerrado",
    "fecha": "01/04/2025",
  },
  {
    "buzon": "Buzón 1",
    "hora": "19:28",
    "estado": "Abierto",
    "fecha": "01/04/2025",
  },
  {
    "buzon": "Buzón 3",
    "hora": "10:30",
    "estado": "Cerrado",
    "fecha": "02/03/2025",
  },
  {
    "buzon": "Buzón 3",
    "hora": "10:27",
    "estado": "Abierto",
    "fecha": "02/03/2025",
  },
];

class PantallaUsuario extends StatefulWidget {
  const PantallaUsuario({super.key});

  @override
  State<PantallaUsuario> createState() => _PantallaUsuarioState();
}

class _PantallaUsuarioState extends State<PantallaUsuario> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    Widget? destino;
    if (index == 1) {
      destino = const Novedades();
    } else if (index == 2) {
      destino = const PantallaPerfil();
    }

    if (destino != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          pageBuilder: (_, __, ___) => destino!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PantallaBase(
      currentIndex: _currentIndex,
      onTap: _onTap,
      mostrarBotonRegresar: true,
    );
  }
}

class PantallaBase extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final bool mostrarBotonRegresar;

  const PantallaBase({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.mostrarBotonRegresar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none,
              color: currentIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: 'Novedades',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: currentIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: 'Perfil',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/fondo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (mostrarBotonRegresar)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Se ha cerrado la sesión'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 600), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/foto1.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Juan Victoria Avila',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'MARAVATÍO, MICH.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MisBuzones(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.grey,
                            ),
                            label: const Text("Mis buzones"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Novedades(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.new_releases_outlined,
                              color: Colors.grey,
                            ),
                            label: const Text("Novedades"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Historial del Buzón",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...historial.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['buzon']!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${item['hora']} | ${item['estado']} | ${item['fecha']}",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
