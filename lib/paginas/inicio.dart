import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boxtrust/servicios/auth_service.dart';
import 'package:boxtrust/rutas/rutas.dart' as routes;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _showError = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _showError = false;
    });

    final correo = _emailController.text.trim();
    final contrasena = _passwordController.text.trim();

    final usuario = await AuthService.instance.login(correo, contrasena);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (usuario == null) {
      setState(() {
        _showError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
      return;
    }

    // Navegar según tipo de usuario con las rutas definidas
    if (usuario.esGerente) {
      Navigator.pushReplacementNamed(context, routes.AppRoutes.gerente);
    } else {
      Navigator.pushReplacementNamed(context, routes.AppRoutes.usuario);
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routes.AppRoutes.principal);
        },
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

  Widget _buildTitles() {
    return Column(
      children: [
        Text(
          'INICIO DE SESIÓN',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Inicia sesión en tu cuenta',
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
          decoration: InputDecoration(
            labelText: 'Correo',
            labelStyle: GoogleFonts.poppins(color: Colors.black54),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 179, 154, 109),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
          ),
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
          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: GoogleFonts.poppins(color: Colors.black54),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 179, 154, 109),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
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
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Correo o contraseña incorrectos',
              style: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildBotonLogin() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
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
                  'Iniciar sesión',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }

  Widget _buildRegistroRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿No tienes cuenta?', style: GoogleFonts.poppins(fontSize: 14)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, routes.AppRoutes.registro);
          },
          child: Text(
            'Regístrate',
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
        'Al iniciar sesión, aceptas nuestros Términos de Servicio y Política de Privacidad.',
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
              _buildBotonLogin(),
              const SizedBox(height: 16),
              _buildRegistroRedirect(),
              const SizedBox(height: 32),
              _buildDisclaimer(),
            ],
          ),
        ),
      ),
    );
  }
}
