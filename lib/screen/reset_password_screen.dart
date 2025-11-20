import 'package:flutter/material.dart';
import '../service/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // ← email dari VerificationCodeScreen

  const ResetPasswordScreen({super.key, required this.email});

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController pass1 = TextEditingController();
  final TextEditingController pass2 = TextEditingController();

  bool hide1 = true;
  bool hide2 = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // BACK
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 4),

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
                  radius: 50,
                  backgroundColor: ResetPasswordScreen.green,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage('assets/img/icon.png'),
                      width: 90,
                      height: 90,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // PASSWORD BARU
              _InputPassword(
                controller: pass1,
                label: "Password baru",
                hint: "Masukkan minimal 8 karakter",
                isHidden: hide1,
                onToggle: () => setState(() => hide1 = !hide1),
              ),

              const SizedBox(height: 20),

              // KONFIRMASI PASSWORD
              _InputPassword(
                controller: pass2,
                label: "Konfirmasi password",
                hint: "Masukkan ulang kata sandi baru",
                isHidden: hide2,
                onToggle: () => setState(() => hide2 = !hide2),
              ),

              const SizedBox(height: 32),

              // TOMBOL GANTI PASSWORD
              Container(
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
                  onPressed: isLoading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ResetPasswordScreen.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(isLoading ? "Loading..." : "Ganti Password"),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------- ACTION RESET PW ----------------------
  Future<void> _resetPassword() async {
    final newPass = pass1.text.trim();
    final confirm = pass2.text.trim();

    if (newPass.length < 8) {
      return _showMsg("Password harus minimal 8 karakter");
    }

    if (newPass != confirm) {
      return _showMsg("Konfirmasi password tidak cocok");
    }

    setState(() => isLoading = true);

    final result = await ApiService.resetPassword(
      email: widget.email,
      newPassword: newPass,
    );

    setState(() => isLoading = false);

    if (result['success'] == true) {
      _showMsg("Password berhasil diganti!");

      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      _showMsg(result['message'] ?? "Gagal mengganti password");
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

// =======================================================
//                WIDGET INPUT PASSWORD
// =======================================================
class _InputPassword extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isHidden;
  final VoidCallback onToggle;

  const _InputPassword({
    required this.controller,
    required this.label,
    required this.hint,
    required this.isHidden,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: ResetPasswordScreen.green,
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
            controller: controller,
            obscureText: isHidden,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          hint,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }
}