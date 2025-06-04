import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pantalla_perfil.dart';

class CambiarContrasena extends StatefulWidget {
  const CambiarContrasena({super.key});

  @override
  State<CambiarContrasena> createState() => _CambiarContrasenaState();
}

class _CambiarContrasenaState extends State<CambiarContrasena> {
  final _formKey = GlobalKey<FormState>();
  final _actualController = TextEditingController();
  final _nuevaController = TextEditingController();
  final _confirmarController = TextEditingController();

  List<String> buzones = ['Buzón Principal'];
  String? buzonSeleccionado;

  bool _isLoading = false;
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _obscure3 = true;

  // ignore: prefer_final_fields
  //int _selectedIndex = 2; // Perfil

  @override
  void initState() {
    super.initState();
    _cargarBuzones();
  }

  Future<void> _cargarBuzones() async {
    final prefs = await SharedPreferences.getInstance();
    final extras = prefs.getStringList('buzonesExtras') ?? [];
    setState(() {
      buzones = ['Buzón Principal', ...extras];
      buzonSeleccionado = buzones.first;
    });
  }

  void _mostrarError() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text("Error"),
            content: const Text(
              "Datos incorrectos. Verifica e intenta nuevamente.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(color: Color.fromARGB(255, 142, 119, 77)),
                ),
              ),
            ],
          ),
    );
  }

  void _actualizarContrasena() {
    if (!_formKey.currentState!.validate()) return;

    if (!buzones.contains(buzonSeleccionado)) {
      _mostrarError();
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("Contraseña Actualizada"),
              content: const Text(
                "Tu contraseña se ha actualizado correctamente.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const PantallaPerfil()),
                    );
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Color.fromARGB(255, 142, 119, 77)),
                  ),
                ),
              ],
            ),
      );
    });
  }

  InputDecoration _decoracionCampo(
    String label,
    bool obscure,
    VoidCallback onToggle,
  ) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.black54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 142, 119, 77),
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      suffixIcon: IconButton(
        icon: Icon(
          obscure ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: onToggle,
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Text(
          'BOXTRUST',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Image.asset('assets/logo.png', height: 150, width: 150),
      ],
    );
  }

  Widget _buildCampos() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: buzonSeleccionado,
          items:
              buzones.map((buzon) {
                return DropdownMenuItem<String>(
                  value: buzon,
                  child: Text(buzon),
                );
              }).toList(),
          onChanged: (valor) => setState(() => buzonSeleccionado = valor),
          decoration: InputDecoration(
            labelText: 'Seleccionar Buzón',
            labelStyle: GoogleFonts.poppins(color: Colors.black54),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 142, 119, 77),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
          ),
          validator: (value) => value == null ? 'Selecciona un buzón' : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _actualController,
          obscureText: _obscure1,
          decoration: _decoracionCampo('Contraseña Actual', _obscure1, () {
            setState(() => _obscure1 = !_obscure1);
          }),
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Ingresa tu contraseña actual'
                      : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _nuevaController,
          obscureText: _obscure2,
          decoration: _decoracionCampo('Nueva Contraseña', _obscure2, () {
            setState(() => _obscure2 = !_obscure2);
          }),
          validator: (value) {
            if (value == null || value.length < 6) {
              return 'La nueva contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _confirmarController,
          obscureText: _obscure3,
          decoration: _decoracionCampo('Confirmar Contraseña', _obscure3, () {
            setState(() => _obscure3 = !_obscure3);
          }),
          validator: (value) {
            if (value != _nuevaController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBotonActualizar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _actualizarContrasena,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 15, 36, 38),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child:
            _isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  'Actualizar',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }

  Widget _buildInfo() {
    return Text(
      'Únicamente si se sabe su contraseña actual la puede cambiar directamente desde su inicio de sesión.',
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLogo(),
              const SizedBox(height: 20),
              Text(
                'Cambiar Contraseña del Buzón',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '¡Crea una contraseña nueva y segura!',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              _buildCampos(),
              const SizedBox(height: 24),
              _buildBotonActualizar(),
              const SizedBox(height: 16),
              _buildInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
