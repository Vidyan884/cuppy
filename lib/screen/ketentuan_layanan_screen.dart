import 'package:flutter/material.dart';

class KetentuanLayananScreen extends StatelessWidget {
  const KetentuanLayananScreen({super.key});

  static const Color green = Color(0xFF2E7D5A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: green,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      "Ketentuan Layanan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ketentuan Layanan Aplikasi Cuppy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 14),

                    Text(
                      "Selamat datang di Cuppy – Cafe Order System. Dengan menggunakan aplikasi ini, pengguna dianggap telah memahami dan menyetujui seluruh ketentuan layanan berikut.\n",
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      "1. Definisi",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    Text(
                      "• Cuppy adalah aplikasi pemesanan minuman digital.\n"
                      "• Pengguna adalah individu yang membuat akun dan menggunakan layanan aplikasi.\n"
                      "• Layanan mencakup fitur pemesanan, pembayaran, dan sistem poin loyalti.\n",
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      "2. Akun Pengguna",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    Text(
                      "• Pengguna wajib menyediakan data yang benar.\n"
                      "• Pengguna bertanggung jawab menjaga kerahasiaan kata sandi.\n"
                      "• Aktivitas dalam akun adalah tanggung jawab pengguna sepenuhnya.\n",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
