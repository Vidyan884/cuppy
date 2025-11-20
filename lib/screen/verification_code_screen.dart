import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'reset_password_screen.dart'; // <--- TAMBAHAN: import screen reset password

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();

  bool isLoading = false;

  String get code => c1.text + c2.text + c3.text + c4.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BACK
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                const SizedBox(height: 8),

                // LOGO
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
                    radius: 44,
                    backgroundColor: VerificationCodeScreen.green,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/img/icon.png'),
                        width: 90,
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Masukkan Kode Verifikasi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: VerificationCodeScreen.green,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 18),

                // 4 kotak OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _OtpBox(controller: c1),
                    _OtpBox(controller: c2),
                    _OtpBox(controller: c3),
                    _OtpBox(controller: c4),
                  ],
                ),

                const SizedBox(height: 28),

                _PrimaryPillButtonOtp(
                  text: isLoading ? 'Memverifikasi...' : 'Verifikasi Kode',
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (code.length != 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kode harus 4 digit'),
                              ),
                            );
                            return;
                          }

                          setState(() => isLoading = true);

                          final result = await ApiService.verifyOtp(
                            email: widget.email,
                            otp: code,
                          );

                          setState(() => isLoading = false);

                          if (result['success'] == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result['message'] ??
                                      'Kode benar, silakan buat password baru',
                                ),
                              ),
                            );

                            // ⬇️ PINDAH KE HALAMAN RESET PASSWORD
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ResetPasswordScreen(email: widget.email),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result['message'] ??
                                      'Kode verifikasi salah',
                                ),
                              ),
                            );
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;

  const _OtpBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: VerificationCodeScreen.green,
              width: 1.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: VerificationCodeScreen.green,
              width: 2.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryPillButtonOtp extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _PrimaryPillButtonOtp({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: VerificationCodeScreen.green,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}