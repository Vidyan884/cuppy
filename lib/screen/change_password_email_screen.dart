import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

class ChangePasswordEmailScreen extends StatefulWidget {
  /// Email akun yang sedang login
  final String registeredEmail;

  const ChangePasswordEmailScreen({
    super.key,
    required this.registeredEmail,
  });

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<ChangePasswordEmailScreen> createState() =>
      _ChangePasswordEmailScreenState();
}

class _ChangePasswordEmailScreenState extends State<ChangePasswordEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Prefill email dengan email yang sedang login biar gak perlu ngetik lagi
    emailController.text = widget.registeredEmail;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> _checkEmail() async {
    final input = emailController.text.trim().toLowerCase();
    final registered = widget.registeredEmail.trim().toLowerCase();

    if (input.isEmpty) {
      _showMsg('Email wajib diisi');
      return;
    }

    // cek apakah sama dengan email akun yg login (sudah di-trim & lowercase)
    if (input != registered) {
      _showMsg('Email tidak sesuai dengan akun yang sedang login');
      return;
    }

    // kalau lolos → lanjut ke screen ganti password
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(email: input),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BACK
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 8),

              // ILLUSTRASI
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: ChangePasswordEmailScreen.green,
                        child: Icon(
                          Icons.lock_reset_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Verifikasi Email Akun',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ChangePasswordEmailScreen.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Masukkan email yang terdaftar untuk melanjutkan proses ganti password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // FIELD EMAIL
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: ChangePasswordEmailScreen.green,
                    width: 1.6,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      color: Color(0x29000000),
                    ),
                  ],
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    hintText: 'Email yang terdaftar',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Gunakan email yang kamu pakai saat login / registrasi.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),

              const SizedBox(height: 32),

              // TOMBOL LANJUTKAN
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _checkEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ChangePasswordEmailScreen.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Text(isLoading ? 'Loading...' : 'Lanjutkan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}