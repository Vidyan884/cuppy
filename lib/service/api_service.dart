import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiService {
  // Ganti base URL sesuai server kamu
  static const String baseUrl = "http://localhost:3000";

  // ==============================================================  
  //                           LOGIN  
  // ==============================================================  
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': decoded['user'],
          'message': decoded['message'],
        };
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Login gagal (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================  
  //                           REGISTER  
  // ==============================================================  
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = null;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': decoded};
      } else {
        return {
          'success': false,
          'message': decoded is Map && decoded['message'] != null
              ? decoded['message']
              : 'Registrasi gagal (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================  
  //                       FORGOT PASSWORD  
  // ==============================================================  
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': decoded['message']};
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Gagal mengirim OTP (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================  
  //                       VERIFY OTP  
  // ==============================================================  
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/verify-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': decoded['message']};
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Verifikasi gagal (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================  
  //                      RESET PASSWORD  
  // ==============================================================  
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': decoded['message']};
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Reset gagal (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ===========================================================
  //                          PROFILE  
  // ===========================================================

  /// GET PROFILE
  static Future<Map<String, dynamic>> getProfile({
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/profile?email=$email');

    try {
      final response = await http.get(url);
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['success'] == true) {
        return {'success': true, 'data': decoded['user']};
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Gagal mengambil profil (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

 /// ---------- UPDATE PROFILE (NAMA SAJA) ----------
  static Future<Map<String, dynamic>> updateProfile({
    required String email,
    required String name,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/profile');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'name': name,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['success'] == true) {
        return {
          'success': true,
          'data': decoded['user'],
          'message': decoded['message'] ?? 'Profil berhasil diperbarui',
        };
      } else {
        return {
          'success': false,
          'message': decoded['message'] ??
              'Gagal update profil (status: ${response.statusCode})',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}

/// =============================================================
///                    TEST API CONNECTION WIDGET
/// =============================================================
class TestAPI extends StatefulWidget {
  const TestAPI({super.key});

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  String result = "Menunggu respon...";

  Future<void> checkConnection() async {
    try {
      final response =
          await http.get(Uri.parse('$ApiService.baseUrl/api/test'));

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() => result = decoded['message']);
      } else {
        setState(() =>
            result = "Gagal terhubung (${response.statusCode})");
      }
    } catch (e) {
      setState(() => result = "Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test API")),
      body: Center(
        child: Text(
          result,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}