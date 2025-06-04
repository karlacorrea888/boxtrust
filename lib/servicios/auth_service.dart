class AuthService {
  // Singleton: acceso con AuthService.instance
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;

  // Correos con privilegios de gerente
  static const List<String> _correosGerentes = [
    'fernanda@boxtrust.com',
    'paola@boxtrust.com',
    'angel@boxtrust.com',
    'kevin@boxtrust.com',
    'karla@boxtrust.com',
  ];

  // Almacén de usuarios: correo -> contraseña
  final Map<String, String> _usuarios = {};

  /// Registra un nuevo usuario si el correo no está en uso.
  /// Retorna `true` si el registro fue exitoso, `false` si ya existe.
  bool registrarUsuario(String correo, String contrasena) {
    final correoNormalizado = correo.toLowerCase();
    if (_usuarios.containsKey(correoNormalizado)) return false;
    _usuarios[correoNormalizado] = contrasena;
    return true;
  }

  /// Intenta autenticar a un usuario.
  /// Retorna un objeto `Usuario` si tiene éxito, o `null` si falla.
  Future<Usuario?> login(String correo, String contrasena) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula red
    final correoNormalizado = correo.toLowerCase();
    final storedPassword = _usuarios[correoNormalizado];

    if (storedPassword == contrasena) {
      final esGerente = _correosGerentes.contains(correoNormalizado);
      return Usuario(correo: correoNormalizado, esGerente: esGerente);
    }
    return null;
  }
}

/// Representa un usuario autenticado.
class Usuario {
  final String correo;
  final bool esGerente;

  Usuario({required this.correo, required this.esGerente});
}
