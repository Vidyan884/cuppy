import 'package:flutter/material.dart';
import 'detail_notifikasi_screen.dart';  // <-- WAJIB DITAMBAH

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const Color green = Color(0xFF2E7D5A);

  @override
  Widget build(BuildContext context) {
    // data dummy 1 notifikasi
    final notifications = <_NotificationItem>[
      _NotificationItem(
        title: 'Pesanan Takeaway sudah siap',
        subtitle: 'Ambil segera ke kasir.',
        time: '13.05',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _NotificationCard(
            title: item.title,
            subtitle: item.subtitle,
            time: item.time,
            onTap: () {
              // ➜ OPEN DETAIL NOTIFIKASI
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DetailNotifikasiScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/* ============================
   MODEL DATA
=============================== */

class _NotificationItem {
  final String title;
  final String subtitle;
  final String time;

  _NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

/* ============================
   KARTU NOTIFIKASI
=============================== */

class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color green = NotificationScreen.green;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon lonceng
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none,
                color: green,
              ),
            ),

            const SizedBox(width: 12),

            // teks judul + subjudul
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // jam di kanan atas
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}