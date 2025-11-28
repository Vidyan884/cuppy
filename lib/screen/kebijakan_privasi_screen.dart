import 'package:flutter/material.dart';

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});

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
                      "Kebijakan Privasi",
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

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Kebijakan Privasi Aplikasi Cuppy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 14),

                    Text(
                      "Cuppy menghargai privasi setiap pengguna. Dokumen ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi yang Anda berikan saat menggunakan aplikasi Cuppy – Cafe Order System.\n",
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      "1. Informasi yang Kami Kumpulkan",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    Text(
                      "• Data akun pengguna: nama, email, nomor telepon, kata sandi.\n"
                      "• Data transaksi: riwayat pesanan, metode pembayaran, total pembayaran.\n"
                      "• Data teknis: alamat IP, jenis perangkat, aktivitas dalam aplikasi.\n",
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      "2. Cara Kami Menggunakan Informasi",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    Text(
                      "• Memproses pesanan dan pembayaran.\n"
                      "• Meningkatkan performa aplikasi.\n"
                      "• Mengirimkan notifikasi terkait pesanan, promo, atau pembaruan fitur.\n"
                      "• Menjaga keamanan transaksi dan akun.\n",
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      "3. Keamanan Data",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    Text(
                      "Kami menerapkan enkripsi data, akses terbatas, dan validasi untuk menjaga keamanan informasi pengguna.\n",
                      style: TextStyle(fontSize: 15),
                    ),
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
