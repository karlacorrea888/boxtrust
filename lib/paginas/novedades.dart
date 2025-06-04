import 'package:boxtrust/paginas/pantalla_perfil.dart';
import 'package:boxtrust/paginas/pantalla_usuario.dart';
import 'package:boxtrust/paginas/paquetes.dart';
import 'package:flutter/material.dart';
import 'package:boxtrust/paginas/objetivo.dart';
import 'package:boxtrust/paginas/vision.dart';
import 'package:boxtrust/paginas/mision.dart';

class Novedades extends StatefulWidget {
  const Novedades({super.key});

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
  int _selectedIndex = 1; // Novedades es la vista actual

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const PantallaUsuario(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const PantallaPerfil(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.grey.shade100),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/fondo_principal.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Text(
                  'BOXTRUST',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset('assets/logo.png', height: 80),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'NOVEDADES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildOptionCard(
                        context,
                        'OBJETIVO DE LA EMPRESA',
                        const Objetivo(),
                      ),
                      _buildOptionCard(
                        context,
                        'MISIÓN DE LA EMPRESA',
                        const Mision(),
                      ),
                      _buildOptionCard(
                        context,
                        'VISIÓN DE LA EMPRESA',
                        const Vision(),
                      ),
                      _buildOptionCard(
                        context,
                        'PAQUETES TECNOLÓGICOS',
                        const Paquetes(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Novedades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    Widget targetPage,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
      ),
    );
  }
}
