import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInfoScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;

  const AccountInfoScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  late TextEditingController nameC;
  late TextEditingController emailC;

  String userName = "";
  String userEmail = "";

  bool isEditingName = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController();
    emailC = TextEditingController();

    loadUser(); // ⬅ ambil data dari shared preferences
  }

  // get user shared preference

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('user_name') ?? "User";
      userEmail = prefs.getString('user_email') ?? "";
    });

    // update input field
    nameC.text = userName;
    emailC.text = userEmail;
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    super.dispose();
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _saveProfile() async {
    final name = nameC.text.trim();
    // final email = widget.initialEmail; // email TIDAK diubah
    // panggil email dari shared preferences
    final email = emailC.text.trim();

    if (name.isEmpty) {
      _showMsg('Nama wajib diisi');
      return;
    }

    setState(() => isLoading = true);

    final result = await ApiService.updateProfile(email: email, name: name);

    setState(() => isLoading = false);

    if (result['success'] == true) {
      _showMsg(result['message'] ?? 'Profil berhasil diperbarui');

      // kirim balik data baru ke ProfilScreen
      Navigator.pop(context, {'name': name, 'email': email});
    } else {
      _showMsg(result['message'] ?? 'Gagal memperbarui profil');
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = nameC.text.isNotEmpty ? nameC.text : userName;
    final displayEmail =
        emailC.text.isNotEmpty ? emailC.text : userEmail;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BACK
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 8),

              // FOTO & NAMA
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFA4E5C2),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====== FIELD NAMA (bisa edit) ======
              const Text(
                'Nama:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              _EditableField(
                controller: nameC,
                readOnly: !isEditingName,
                hint: 'Nama',
                onTapEdit: () {
                  setState(() => isEditingName = true);
                },
              ),

              const SizedBox(height: 20),

              // ====== FIELD EMAIL (TIDAK bisa edit) ======
              const Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F0DE),
                  borderRadius: BorderRadius.circular(26),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Text(
                  displayEmail,
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 32),

              // BUTTON SIMPAN
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
                    onPressed: isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AccountInfoScreen.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
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
                    child: Text(isLoading ? 'Menyimpan...' : 'Simpan'),
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

class _EditableField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String hint;
  final VoidCallback onTapEdit;

  const _EditableField({
    required this.controller,
    required this.readOnly,
    required this.hint,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6F0DE),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onTapEdit,
          ),
        ],
      ),
    );
  }
}
