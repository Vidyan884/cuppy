import 'package:flutter/material.dart';
import 'account_info_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

  /// nama & email yang dipakai waktu login
  final String initialName;
  final String initialEmail;

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;
    _email = widget.initialEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- HEADER IMAGE ----------
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/profil_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ---------- PROFILE PHOTO ----------
            Transform.translate(
              offset: const Offset(0, -50),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    // kalau asset-mu sering error, sementara bisa pake backgroundColor saja
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFA4E5C2),
                      // backgroundImage: AssetImage("assets/img/profile.png"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // NAMA DINAMIS
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ---------- MENU LIST ----------
            _MenuButton(
              icon: Icons.person_outline,
              text: "Informasi Akun",
              onTap: () async {
                // buka halaman informasi akun, kirim nama & email sekarang
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AccountInfoScreen(
                      initialName: _name,
                      initialEmail: _email,
                    ),
                  ),
                );

                // kalau halaman balik bawa data baru, update profil
                if (result != null && result is Map && mounted) {
                  setState(() {
                    _name = result['name'] ?? _name;
                    _email = result['email'] ?? _email;
                  });
                }
              },
            ),

            _MenuButton(
              icon: Icons.lock_outline,
              text: "Ganti Password",
              onTap: () {
                // (punya flowmu sendiri)
              },
            ),

            _MenuButton(
              icon: Icons.notifications_none,
              text: "Pengaturan Notifikasi",
              onTap: () {},
            ),
            _MenuButton(
              icon: Icons.privacy_tip_outlined,
              text: "Kebijakan Privasi",
              onTap: () {},
            ),
            _MenuButton(
              icon: Icons.description_outlined,
              text: "Ketentuan Layanan",
              onTap: () {},
            ),

            _MenuButton(
              icon: Icons.logout,
              text: "Log Out",
              onTap: () {
                // nanti tinggal isi logic logout
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFE3EFE9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: ProfilScreen.green, size: 26),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}