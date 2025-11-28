import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'account_info_screen.dart';
import 'login_screen.dart';
import 'kebijakan_privasi_screen.dart';
import 'ketentuan_layanan_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

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

  // ============================================================
  //                      LOGOUT POPUP
  // ============================================================
  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (ctx) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(ctx).size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Yakin mau keluar?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();

                        final res =
                            await ApiService.logoutUser(email: _email);

                        if (!mounted) return;

                        if (res['success'] != true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                res['message'] ?? 'Logout gagal',
                              ),
                            ),
                          );
                          return;
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 1.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Yakin",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFFBDBDBD), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Gak jadi deh",
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  //                        UI PROFIL
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFA4E5C2),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // 🔥 TAMBAHAN SATU-SATUNYA (email tampil)
                  Text(
                    _email,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            _MenuButton(
              icon: Icons.person_outline,
              text: "Informasi Akun",
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AccountInfoScreen(
                      initialName: _name,
                      initialEmail: _email,
                    ),
                  ),
                );

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
              onTap: () {},
            ),

            _MenuButton(
              icon: Icons.notifications_none,
              text: "Pengaturan Notifikasi",
              onTap: () {},
            ),

            _MenuButton(
              icon: Icons.privacy_tip_outlined,
              text: "Kebijakan Privasi",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const KebijakanPrivasiScreen(),
                  ),
                );
              },
            ),

            _MenuButton(
              icon: Icons.description_outlined,
              text: "Ketentuan Layanan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const KetentuanLayananScreen(),
                  ),
                );
              },
            ),

            _MenuButton(
              icon: Icons.logout,
              text: "Log Out",
              onTap: _showLogoutDialog,
            ),

            const SizedBox(height: 24),
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
