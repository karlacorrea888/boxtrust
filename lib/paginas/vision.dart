import 'package:flutter/material.dart';

class Vision extends StatelessWidget {
  const Vision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'VISIÓN DE LA EMPRESA',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Image.asset('assets/logo.png', height: 100),
            const SizedBox(height: 10),
            const Text(
              'BOXTRUST',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8EBEF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Convertirse en la solución líder en logística de última milla, '
                'revolucionando la experiencia de entrega con buzones inteligentes.',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información de Contacto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Número:', style: TextStyle(fontSize: 14)),
                Text('447-122-6690', style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Correo\nEmpresarial:', style: TextStyle(fontSize: 14)),
                Text('boxtrust@gmail.com', style: TextStyle(fontSize: 14)),
              ],
            ),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
