import 'package:boxtrust/servicios/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boxtrust/paginas/principal.dart';
import 'package:boxtrust/rutas/rutas.dart' as routes;

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final AuthService _authService = AuthService.instance;

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _showError = false;

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _showError = false;
    });

    final exito = _authService.registrarUsuario(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    await Future.delayed(const Duration(seconds: 1)); // Simula red

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (exito) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Registro exitoso"),
              content: const Text(
                "Tu cuenta ha sido registrada correctamente.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                      context,
                      routes.AppRoutes.login,
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
    } else {
      setState(() => _showError = true);
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PrincipalPage()),
          );
        },
      ),
    );
  }

  InputDecoration _campoDecoracion(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.black54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 142, 119, 77),
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      suffixIcon: suffixIcon,
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

  Widget _buildTitles() {
    return Column(
      children: [
        Text(
          'REGISTRO',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Crea tu cuenta en BoxTrust',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _campoDecoracion('Correo'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu correo';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Ingresa un correo válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: _campoDecoracion(
            'Contraseña',
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _confirmController,
          obscureText: _obscureConfirm,
          decoration: _campoDecoracion(
            'Confirmar Contraseña',
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              },
            ),
          ),
          validator: (value) {
            if (value != _passwordController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'El correo ya está registrado',
              style: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildBotonRegistro() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _registrar,
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
                  'Registrarse',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes una cuenta?',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, routes.AppRoutes.login);
          },
          child: Text(
            'Inicia sesión',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color.fromARGB(255, 142, 119, 77),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Al registrarte, aceptas nuestros Términos de Servicio y Política de Privacidad.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLogo(),
              const SizedBox(height: 24),
              _buildTitles(),
              const SizedBox(height: 32),
              _buildFormFields(),
              const SizedBox(height: 24),
              _buildBotonRegistro(),
              const SizedBox(height: 16),
              _buildLoginRedirect(),
              const SizedBox(height: 32),
              _buildDisclaimer(),
            ],
          ),
        ),
      ),
    );
  }
}
