import 'package:flutter/material.dart';

class DetailNotifikasiScreen extends StatelessWidget {
  const DetailNotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D5A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // ICON
            const Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFF2E7D5A),
              size: 90,
            ),

            const SizedBox(height: 10),

            // CUPPY TITLE
            const Text(
              "Cuppy",
              style: TextStyle(
                color: Color(0xFF2E7D5A),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // STATUS
            const Text(
              "Pesanan Selesai!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // ORDER ID
            const Text(
              "Order ID #CP-2839",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF2E7D5A),
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            // DESCRIPTION
            const Text(
              "Halo kak Asep, pesanan takeaway-mu sudah siap.\nSilahkan ambil di kasir ya.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}