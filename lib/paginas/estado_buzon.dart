import 'package:flutter/material.dart';

class EstadoBuzon extends StatefulWidget {
  final String tituloBuzon;
  final bool cerrado;

  const EstadoBuzon({
    super.key,
    required this.tituloBuzon,
    required this.cerrado,
  });

  @override
  State<EstadoBuzon> createState() => _EstadoBuzonState();
}

class _EstadoBuzonState extends State<EstadoBuzon> {
  late bool _cerrado;

  @override
  void initState() {
    super.initState();
    _cerrado = widget.cerrado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el cuerpo detrás del appbar
      backgroundColor: Colors.transparent, // Para que se vea el fondo
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
            image: AssetImage('assets/fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: const Color(0xFFEFE9DE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Text(
                      widget.tituloBuzon,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      _cerrado ? 'Cerrado' : 'Abierto',
                      style: TextStyle(
                        color: _cerrado ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _cerrado ? Icons.lock_outline : Icons.lock_open,
                        color: _cerrado ? Colors.red : Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _cerrado = !_cerrado;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _cerrado = !_cerrado;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return ScaleTransition(
                          scale: animation,
                          child: RotationTransition(
                            turns: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        _cerrado ? Icons.lock : Icons.lock_open,
                        key: ValueKey<bool>(_cerrado),
                        size: 280,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // espacio al final
            ],
          ),
        ),
      ),
    );
  }
}
