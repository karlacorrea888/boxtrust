import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio.dart'; // Importa la pantalla de inicio

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaGerente(),
    ),
  );
}

class Usuario {
  final String nombre;
  final String correo;
  final String fotoUrl;
  final String id;
  final String numeroSerie;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.fotoUrl,
    required this.id,
    required this.numeroSerie,
  });
}

class PantallaGerente extends StatefulWidget {
  const PantallaGerente({super.key});

  @override
  State<PantallaGerente> createState() => _PantallaGerenteState();
}

class _PantallaGerenteState extends State<PantallaGerente> {
  List<Usuario> usuarios = [
    Usuario(
      nombre: 'Elynn Lee',
      correo: 'email@fakedomain.net',
      fotoUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      id: '1287',
      numeroSerie: 'ABCD1234',
    ),
    Usuario(
      nombre: 'Oscar Dum',
      correo: 'email@fakedomain.net',
      fotoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      id: '1288',
      numeroSerie: 'EFGH5678',
    ),
    Usuario(
      nombre: 'Carlo Emilion',
      correo: 'email@fakedomain.net',
      fotoUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      id: '1289',
      numeroSerie: 'IJKL9012',
    ),
    Usuario(
      nombre: 'Daniel Jay Park',
      correo: 'djpark@gmail.com',
      fotoUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      id: '1290',
      numeroSerie: 'MNOP3456',
    ),
    Usuario(
      nombre: 'Mark Rojas',
      correo: 'rojasmar@skiff.com',
      fotoUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
      id: '1291',
      numeroSerie: 'QRST7890',
    ),
    Usuario(
      nombre: 'Ana Victoria Avila',
      correo: 'ana@gmail.com',
      fotoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      id: '1292',
      numeroSerie: 'NXFW0237',
    ),
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final usuariosFiltrados =
        usuarios
            .where(
              (u) =>
                  u.nombre.toLowerCase().contains(query.toLowerCase()) ||
                  u.correo.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/fondo.jpeg', fit: BoxFit.cover),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Se ha cerrado sesión"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/5.jpg',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Gildardo Pérez',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'CD HIDALGO, MICH.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onChanged: (value) => setState(() => query = value),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar',
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
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
                            "Lista de Usuarios",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...usuariosFiltrados.map(
                            (usuario) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(usuario.fotoUrl),
                              ),
                              title: Text(
                                usuario.nombre,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                usuario.correo,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () async {
                                final fueEliminado = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => DetalleUsuario(usuario: usuario),
                                  ),
                                );
                                if (fueEliminado == true) {
                                  setState(() {
                                    usuarios.remove(usuario);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Se eliminó el usuario'),
                                    ),
                                  );
                                }
                              },
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
        ],
      ),
    );
  }
}

class DetalleUsuario extends StatelessWidget {
  final Usuario usuario;
  const DetalleUsuario({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/fondo_principal.png', fit: BoxFit.cover),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(usuario.fotoUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    usuario.nombre,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
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
                            _buildDetailRow('ID', usuario.id),
                            const Divider(),
                            _buildDetailRow('Nombre', usuario.nombre),
                            const Divider(),
                            _buildDetailRow('Correo', usuario.correo),
                            const Divider(),
                            _buildDetailRow(
                              'Número de Serie',
                              usuario.numeroSerie,
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final confirmar = await showDialog<bool>(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text(
                                            'Confirmar eliminación',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          content: Text(
                                            '¿Desea eliminar al usuario permanentemente?',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    false,
                                                  ),
                                              child: Text(
                                                'Cancelar',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    true,
                                                  ),
                                              child: Text(
                                                'Eliminar',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                  if (confirmar == true) {
                                    Navigator.pop(context, true);
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                label: const Text('Eliminar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 90,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontSize: 16)),
      ],
    );
  }
}
