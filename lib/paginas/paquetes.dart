import 'package:flutter/material.dart';

class Paquetes extends StatefulWidget {
  const Paquetes({super.key});

  @override
  State<Paquetes> createState() => _PaquetesState();
}

class _PaquetesState extends State<Paquetes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white.withOpacity(0.95),
                  elevation: 1,
                  title: const Text(
                    'PAQUETES TECNOLÓGICOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white.withOpacity(0.95),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'BUZONES',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'DESCRIPCIÓN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildBuzonItem(
                          image: 'assets/buzon3.jpg',
                          title: 'Buzón básico de paquete\npequeño',
                          description: 'Aproximadamente 40\n× 30 × 50 cm',
                        ),
                        _buildBuzonItem(
                          image: 'assets/buzon1.jpg',
                          title: 'Buzón de paquete\nmediano',
                          description: 'Aproximadamente 60\n× 40 × 70 cm',
                        ),
                        _buildBuzonItem(
                          image: 'assets/buzon2.jpg',
                          title: 'Buzón de gran capacidad',
                          description: 'Entre 110 ×\n110 × 110 cm o más',
                        ),
                        const Divider(height: 32),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'PERSONALIZADO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Agregar características',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          onTap: () {
                            // Acción opcional
                          },
                        ),
                        const Divider(height: 32),
                        const Text(
                          'Información de Contacto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildContacto('Número:', '447-122-6690'),
                        const SizedBox(height: 6),
                        _buildContacto(
                          'Correo\nEmpresarial:',
                          'boxtrust@gmail.com',
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuzonItem({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContacto(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
