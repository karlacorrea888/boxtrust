import 'package:boxtrust/paginas/estado_buzon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MisBuzones extends StatefulWidget {
  const MisBuzones({super.key});

  @override
  State<MisBuzones> createState() => _MisBuzonesState();
}

class _MisBuzonesState extends State<MisBuzones> {
  List<String> buzonesExtras = [];
  List<bool> estados = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBuzones = prefs.getStringList('buzonesExtras') ?? [];
    final savedEstados =
        prefs
            .getStringList('estadosExtras')
            ?.map((e) => e == 'true')
            .toList() ??
        List.generate(savedBuzones.length, (_) => true); // ← CORREGIDO

    setState(() {
      buzonesExtras = savedBuzones;
      estados = savedEstados;
    });
  }

  Future<void> _guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('buzonesExtras', buzonesExtras);
    await prefs.setStringList(
      'estadosExtras',
      estados.map((e) => e.toString()).toList(),
    );
  }

  void _renombrarBuzones() {
    setState(() {
      for (int i = 0; i < buzonesExtras.length; i++) {
        buzonesExtras[i] = 'Buzón ${i + 2}';
      }
    });
  }

  void _mostrarDialogoAgregarBuzon() {
    TextEditingController controlador = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Ingrese código de buzón (opcional)'),
            content: TextField(
              controller: controlador,
              decoration: const InputDecoration(hintText: 'Ej. 77899'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    buzonesExtras.add('');
                    estados.add(true);
                    _renombrarBuzones();
                  });
                  _guardarDatos();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buzón agregado')),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _mostrarDialogoEliminarBuzon() {
    if (buzonesExtras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay buzones para eliminar')),
      );
      return;
    }

    String? seleccionado = buzonesExtras.first;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Eliminar buzón'),
            content: StatefulBuilder(
              builder: (context, setStateDialog) {
                return DropdownButton<String>(
                  value: seleccionado,
                  items:
                      buzonesExtras
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged:
                      (value) => setStateDialog(() => seleccionado = value!),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  final index = buzonesExtras.indexOf(seleccionado!);
                  setState(() {
                    buzonesExtras.removeAt(index);
                    estados.removeAt(index);
                    _renombrarBuzones();
                  });
                  _guardarDatos();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buzón eliminado')),
                  );
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
    );
  }

  Widget _buildBuzonCard(String nombre, bool cerrado, int index) {
    return GestureDetector(
      onTap: () async {
        final nuevoEstado = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (_) => EstadoBuzon(tituloBuzon: nombre, cerrado: cerrado),
          ),
        );

        if (nuevoEstado != null) {
          setState(() {
            if (index >= 0) {
              estados[index] = nuevoEstado;
            }
          });
          _guardarDatos();
        }
      },
      child: Card(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.9),
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: const Icon(Icons.mail_lock, color: Color(0xFF0A2422)),
          title: Text(
            nombre,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Text('Estado: ${cerrado ? "Cerrado" : "Abierto"}'),
        ),
      ),
    );
  }

  List<Widget> _generarBuzones() {
    List<Widget> lista = [_buildBuzonCard('Buzón Principal', true, -1)];
    for (int i = 0; i < buzonesExtras.length; i++) {
      lista.add(_buildBuzonCard(buzonesExtras[i], estados[i], i));
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_principal.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/foto1.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'BIENVENIDO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'Juan Victoria Avila',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'BUZONES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: _generarBuzones(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 15),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _mostrarDialogoAgregarBuzon,
            backgroundColor: const Color(0xFF0F2B28),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            heroTag: 'remove',
            onPressed: _mostrarDialogoEliminarBuzon,
            backgroundColor: const Color(0xFF0F2B28),
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
