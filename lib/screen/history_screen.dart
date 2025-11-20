import 'package:flutter/material.dart';
import 'home_screen.dart';

// ===========================================
//              HISTORY SCREEN
// ===========================================

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedTab = 0; // 0 = ongoing, 1 = completed

  // ----- DATA DUMMY SESUAI FIGMA -----
  final List<_OrderData> ongoingOrders = [
    _OrderData(
      image: "assets/img/kopi_1.png",
      name: "Signature Cream Brew",
      category: "Coffee",
      date: "24 Okt 2025 - 12:30",
      price: "Rp xx",
      code: "#CP-2840",
    ),
  ];

  final List<_OrderData> completedOrders = [
    _OrderData(
      image: "assets/img/makanan_1.png", // bisa diganti gambar toastie
      name: "Creamy Fruity Toastie",
      category: "Food",
      date: "23 Okt 2025 - 09:30",
      price: "Rp xx",
      code: "#CP-2839",
    ),
    _OrderData(
      image: "assets/img/kopi_1.png", // misal minuman hijau
      name: "Raspberry Daylight",
      category: "Non-Coffee",
      date: "22 Okt 2025 - 15:10",
      price: "Rp xx",
      code: "#CP-2838",
    ),
    _OrderData(
      image: "assets/img/kopi_1.png",
      name: "Caramel Swirl Latte",
      category: "Coffee",
      date: "21 Okt 2025 - 18:45",
      price: "Rp xx",
      code: "#CP-2837",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // pilih list berdasarkan tab yang aktif
    final List<_OrderData> currentList =
        selectedTab == 0 ? ongoingOrders : completedOrders;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D5A),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Riwayat Order",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          // TAB BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TabButton(
                label: "Ongoing",
                active: selectedTab == 0,
                onTap: () => setState(() => selectedTab = 0),
              ),
              const SizedBox(width: 12),
              _TabButton(
                label: "Completed",
                active: selectedTab == 1,
                onTap: () => setState(() => selectedTab = 1),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // LIST DATA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: currentList.length,
              itemBuilder: (context, index) {
                final item = currentList[index];
                return _OrderCard(
                  image: item.image,
                  name: item.name,
                  category: item.category,
                  date: item.date,
                  price: item.price,
                  code: item.code,
                  onDetail: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Detail ${item.name} ditekan!"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ===========================================
      //             BOTTOM NAVIGATION
      // ===========================================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: const Color(0xFF2E7D5A),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const KeranjangScreen()),
            );
          } else if (index == 2) {
            // stay di History
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Keranjang",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}

// ===========================================
//            KERANJANG SCREEN SEDERHANA
// ===========================================

class KeranjangScreen extends StatelessWidget {
  const KeranjangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D5A),
        title: const Text('Keranjang'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Keranjang kosong'),
      ),
    );
  }
}

// ===========================================
//                 MODEL DATA
// ===========================================

class _OrderData {
  final String image;
  final String name;
  final String category;
  final String date;
  final String price;
  final String code;

  _OrderData({
    required this.image,
    required this.name,
    required this.category,
    required this.date,
    required this.price,
    required this.code,
  });
}

// ===========================================
//                 TAB BUTTON
// ===========================================

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2E7D5A) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF2E7D5A),
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF2E7D5A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ===========================================
//                ORDER CARD
// ===========================================

class _OrderCard extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  final String date;
  final String price;
  final String code;
  final VoidCallback onDetail;

  const _OrderCard({
    required this.image,
    required this.name,
    required this.category,
    required this.date,
    required this.price,
    required this.code,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetail, // card bisa diklik
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black12,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      code,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D5A),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // BUTTON
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onDetail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D5A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Lihat Detail",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}